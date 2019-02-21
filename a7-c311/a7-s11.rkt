#lang racket

(define value-of-cps
  (lambda (expr env-cps k)
    (match expr
      [`(const ,expr)(apply-k k expr)]
      [`(mult ,x1 ,x2) (value-of-cps x1 env-cps (*-out-k x1 env-cps k))]
      [`(sub1 ,x) (value-of-cps x env-cps (s1-in-k k))]
      [`(zero ,x)(value-of-cps x env-cps (zr-in-k k))]
      [`(if ,test ,conseq ,alt)(value-of-cps test env-cps (if-in-k conseq alt env-cps k))]
      [`(letcc ,body)(value-of-cps body (extend-env k env-cps) k)]
      [`(throw ,k-exp ,e-exp)(value-of-cps k-exp env-cps (thr-out-k e-exp env-cps))]
      [`(let ,e ,body)(value-of-cps e env-cps (let-in-k body env-cps k))]                                                    
      [`(var ,expr)(apply-env env-cps expr k)]
      [`(lambda ,body)(apply-k k (make-closure body env-cps))]
      [`(app ,rator ,rand)(value-of-cps rator env-cps (app-out-k rand env-cps k))]
      )))


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
      [`(*-in-k ,y^ ,k^)(apply-k k^ (* v y^))]
      [`(*-out-k ,x^ ,env^ ,k^)(value-of-cps x^ env^ (*-in-k v k^))]
      [`(s1-in-k ,k^)(apply-k k^ (sub1 v))]
      [`(zr-in-k ,k^)(apply-k k^ (zero? v))]
      [`(if-in-k ,c^ ,a^ ,env^ ,k^)(if v (value-of-cps c^ env^ k^)(value-of-cps a^ env^ k^))]
      [`(thr-in-k ,v^)(v^ v)]
      [`(thr-out-k ,e^ ,env^)(value-of-cps e^ env^ (thr-in-k v))]
      [`(let-in-k ,b^ ,env^ ,k^)(value-of-cps b^ (extend-env v env^)k^)]
      [`(app-in-k ,c^ ,k^)(apply-closure c^ v k^)]
      [`(app-out-k ,ran^ ,env^ ,k^)(value-of-cps ran^ env^ (app-in-k v k^))]
      [else (k v)])))

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
    (lambda (v)
      v)))

(value-of-cps '(const 5) (empty-env) (empty-k)) 
(value-of-cps '(mult (const 5) (const 5)) (empty-env) (empty-k)) ;25)
(value-of-cps '(zero (const 5)) (empty-env) (empty-k)) ;#f)
(value-of-cps '(sub1 (const 5)) (empty-env) (empty-k)) ;4)
(value-of-cps '(sub1 (sub1 (const 5))) (empty-env) (empty-k)) ;3)
(value-of-cps '(zero (sub1 (const 6))) (empty-env) (empty-k)) ;#f)
(value-of-cps '(if (zero (const 5)) (const 3) (mult (const 2) (const 2))) (empty-env) (empty-k)) ;4)
(value-of-cps '(if (zero (const 0)) (mult (const 2) (const 2)) (const 3)) (empty-env) (empty-k)) ;4)
(value-of-cps '(app (lambda (const 5)) (const 6)) (empty-env) (empty-k)) ;5) 
(value-of-cps '(app (lambda (var 0)) (const 5)) (empty-env) (empty-k)) ;5)
(value-of-cps '(app (app (lambda (lambda (var 1))) (const 6)) (const 5)) (empty-env) (empty-k)) ;6)
(value-of-cps '(app (lambda (app (lambda (var 1)) (const 6))) (const 5)) (empty-env) (empty-k)) ;5)
(value-of-cps '(app (lambda (if (zero (var 0)) (const 4) (const 5))) (const 3)) (empty-env) (empty-k)) ;5)
(value-of-cps '(let (const 6) (const 4)) (empty-env) (empty-k)) ;4)
(value-of-cps '(let (const 5) (var 0)) (empty-env) (empty-k)) ;5)
(value-of-cps '(mult (const 5) (let (const 5) (var 0))) (empty-env) (empty-k)) ;25)
(value-of-cps '(app (if (zero (const 4)) (lambda (var 0)) (lambda (const 5))) (const 3)) (empty-env) (empty-k)) ;5)
(value-of-cps '(app (if (zero (const 0)) (lambda (var 0)) (lambda (const 5))) (const 3)) (empty-env) (empty-k)) ;3)
(value-of-cps '(letcc (const 5)) (empty-env) (empty-k)) ;5)
(value-of-cps '(letcc (throw (var 0) (const 5))) (empty-env) (empty-k)) ;5)
(value-of-cps '(letcc (throw (var 0) (mult (const 5) (const 5)))) (empty-env) (empty-k)) ;25)
(value-of-cps '(letcc (throw (app (lambda (var 0)) (var 0)) (mult (const 5) (const 5)))) (empty-env) (empty-k)) ;25)
(value-of-cps '(letcc (sub1 (throw (var 0) (const 5)))) (empty-env) (empty-k)) ;5)
(value-of-cps '(letcc (throw (throw (var 0) (const 5)) (const 6))) (empty-env) (empty-k)) ;5)
(value-of-cps '(letcc (throw (const 5) (throw (var 0) (const 5)))) (empty-env) (empty-k)) ;5)
(value-of-cps '(mult (const 3) (letcc (throw (const 5) (throw (var 0) (const 5))))) (empty-env) (empty-k)) ;15)
(value-of-cps '(if (zero (const 5)) (app (lambda (app (var 0) (var 0))) (lambda (app (var 0) (var 0)))) (const 4))(empty-env)(empty-k));4)
(value-of-cps '(if (zero (const 0)) (const 4) (app (lambda (app (var 0) (var 0))) (lambda (app (var 0) (var 0)))))(empty-env)(empty-k));4)
(value-of-cps '(app (lambda (app (app (var 0) (var 0)) (const 2)))
                             (lambda
                               (lambda 
                                 (if (zero (var 0))  
                                     (const 1)
                                     (app (app (var 1) (var 1)) (sub1 (var 0)))))))
                       (empty-env)
                       (empty-k))
         ;1)
