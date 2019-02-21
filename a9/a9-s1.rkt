#lang racket
(require "pc2c.rkt")
(require "parenthc.rkt")



(define value-of-cps
  (lambda (expr^ env-cps k)
    (union-case expr^ expr
      [(const expr)(apply-k k expr)]
      [(mult x1 x2) (value-of-cps x1 env-cps (*-out-k x2 env-cps k))]
      [(sub1 x) (value-of-cps x env-cps (s1-in-k k))]
      [(zero x)(value-of-cps x env-cps (zr-in-k k))]
      [(if test conseq alt)(value-of-cps test env-cps (if-in-k conseq alt env-cps k))]
      [(letcc body)(value-of-cps body (extend-env k env-cps) k)]
      [(throw k-exp e-exp)(value-of-cps k-exp env-cps (thr-out-k e-exp env-cps))]
      [(let e body)(value-of-cps e env-cps (let-in-k body env-cps k))]                                                    
      [(var expr)(apply-env env-cps expr k)]
      [(lambda body)(apply-k k (make-closure body env-cps))]
      [(app rator rand)(value-of-cps rator env-cps (app-out-k rand env-cps k))]
      )))




(define-union expr
  (const cexp)
  (var n)
  (if test conseq alt)
  (mult nexp1 nexp2)
  (sub1 nexp)
  (zero nexp)
  (letcc body)
  (throw kexp vexp)
  (let exp body)              
  (lambda body)
  (app rator rand))


;; (let ((f (lambda (f)
;;   	      (lambda (n)
;; 	        (if (zero? n) 
;; 		    1
;; 	            (* n ((f f) (sub1 n))))))))
;;   (* (letcc k ((f f) (throw k ((f f) 4)))) 5))
 



(define app-in-k
  (lambda (c^ k^)
    `(app-in-k ,c^ ,k^)))

(define app-out-k
  (lambda (ran^ env^ k^)
    `(app-out-k ,ran^ ,env^ ,k^)))


(define let-in-k
  (lambda (b^ env^ k^)
    `(let-in-k ,b^ ,env^ ,k^)))
    
(define thr-out-k
  (lambda (e^ env^)
    `(thr-out-k ,e^ ,env^)))
    
(define thr-in-k
  (lambda (v^)
    `(thr-in-k ,v^)))

(define if-in-k
  (lambda (c^ a^ env^ k^)
    `(if-in-k ,c^ ,a^ ,env^ ,k^)))
    
(define zr-in-k
  (lambda (k^)
    `(zr-in-k ,k^)))
    
(define *-in-k
  (lambda (y^ k^)
    `(*-in-k ,y^ ,k^)))

(define *-out-k
  (lambda (x^ env^ k^)
    `(*-out-k ,x^ ,env^ ,k^)))
(define s1-in-k
    (lambda (k^)
      `(s1-in-k ,k^)))
    

(define apply-k
  (lambda (k v)
    (match k
      [`(empty-k) v]
      [`(*-in-k ,y^ ,k^)(apply-k k^ (* v y^))]
      [`(*-out-k ,x^ ,env^ ,k^)(value-of-cps x^ env^ (*-in-k v k^))]
      [`(s1-in-k ,k^)(apply-k k^ (sub1 v))]
      [`(zr-in-k ,k^)(apply-k k^ (zero? v))]
      [`(if-in-k ,c^ ,a^ ,env^ ,k^)(if v (value-of-cps c^ env^ k^)(value-of-cps a^ env^ k^))]
      [`(thr-out-k ,e^ ,env^)(value-of-cps e^ env^ (thr-in-k v))]
      [`(thr-in-k ,v^) (apply-k v^ v)]
      [`(let-in-k ,b^ ,env^ ,k^)(value-of-cps b^ (extend-env v env^)k^)]
      [`(app-in-k ,c^ ,k^)(apply-closure c^ v k^)]
      [`(app-out-k ,ran^ ,env^ ,k^)(value-of-cps ran^ env^ (app-in-k v k^))]
      )))

(define apply-env
  (lambda (env y k^)
    (match env
      [`(empty-env)(error 'value-of-cps "Unbound Identifier")]
      [`(extend-env ,a^ ,env^)(if (zero? y) (apply-k k^ a^)(apply-env env^ (sub1 y) k^))])))
      


(define apply-closure
  (lambda (c y k^)
    (match c
      [`(closure ,body^ ,env^)(value-of-cps body^ (extend-env y env^) k^)])))


(define make-closure
  (lambda (body^ env^)
    `(closure ,body^ ,env^)))

(define extend-env
  (lambda (a^ env^)
    `(extend-env ,a^ ,env^)))

(define empty-env
  (lambda ()
    `(empty-env)))
            
(define empty-k
  (lambda ()
    `(empty-k)))

(define main 
  (lambda ()
    (value-of-cps 
     (expr_let 
      (expr_lambda
       (expr_lambda 
        (expr_if
         (expr_zero (expr_var 0))
         (expr_const 1)
         (expr_mult (expr_var 0) (expr_app (expr_app (expr_var 1) (expr_var 1)) (expr_sub1 (expr_var 0)))))))
      (expr_mult
       (expr_letcc
        (expr_app
         (expr_app (expr_var 1) (expr_var 1))
         (expr_throw (expr_var 0) (expr_app (expr_app (expr_var 1) (expr_var 1)) (expr_const 4)))))
       (expr_const 5)))
     (empty-env)
     (empty-k))))