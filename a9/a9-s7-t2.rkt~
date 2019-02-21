#lang racket

(require "parenthc.rkt")
(define-registers expr^ env-cps k cl^ cy ck^ envr^ ey ek^ ak^ v)
;;apply-closure cl^ cy ck^
;;apply-env envr^ ey ek^
;;apply-k ak^ v


(define value-of-cps
  (lambda ()
    (union-case expr^ expr
      [(const expr)(begin (set! ak^ k)
                         (set! v expr);;;;;;;;;;
                     (apply-k))]
      [(mult x1 x2) (begin
                      (set! k (kt_*-out-k x2 env-cps k))
                      (set! expr^ x1)
                      (value-of-cps))]
      [(sub1 x) (begin
                  (set! k (kt_s1-in-k k))
                  (set! expr^ x)
                  (value-of-cps))]
      [(zero x)(begin (set! k (kt_zr-in-k k))
                      (set! expr^ x)
                 (value-of-cps))]
      [(if test conseq alt)(begin (set! k (kt_if-in-k conseq alt env-cps k))
                                  (set! expr^ test)
                             (value-of-cps))]
      [(letcc body)(begin (set! env-cps (envr_extend-env k env-cps))
                          (set! expr^ body)
                     (value-of-cps))]
      [(throw k-exp e-exp)(begin (set! k (kt_thr-out-k e-exp env-cps))
                                 (set! expr^ k-exp)
                            (value-of-cps))]
      [(let e body)(begin (set! k (kt_let-in-k body env-cps k))
                          (set! expr^ e)
                     (value-of-cps))]                                                    
      [(var expr)(begin (set! ek^ k)
                        (set! envr^ env-cps)
                        (set! ey expr)
                   (apply-env))]
      [(lambda body)(begin (set! ak^ k)
                           (set! v (clos_closure body env-cps));;;;;;;
                      (apply-k))]
      [(app rator rand)(begin (set! k (kt_app-out-k rand env-cps k))
                              (set! expr^ rator)
                         (value-of-cps))]
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
 


(define apply-k
  (lambda ()
    ;;(display v)(newline)
    ;;(display k)(newline)(newline)
    (union-case ak^ kt
      [(empty-k) v];;;;;;;
      [(*-in-k y^ k^)(begin
                       (set! ak^ k^)

                       (set! v (* v y^));;;;;;;;;
                       (apply-k))]
      [(*-out-k x^ env^ k^)(begin (set! k (kt_*-in-k v k^))
                                  (set! expr^ x^)
                                  (set! env-cps env^)
                             (value-of-cps))]
      [(s1-in-k k^)(begin
                     (set! ak^ k^)
                     (set! v (sub1 v));;;;;;;;;;;
                     (apply-k))]
      [(zr-in-k k^)(begin (set! ak^ k^)
                        (set! v (zero? v))
                     (apply-k))]
      [(if-in-k c^ a^ env^ k^)(if v (begin (set! k k^)
                                           (set! expr^ c^)
                                           (set! env-cps env^)
                                      (value-of-cps))
                                  (begin (set! k k^)
                                         (set! env-cps env^)
                                         (set! expr^ a^)
                                    (value-of-cps)))]
      [(thr-out-k e^ env^)(begin (set! k (kt_thr-in-k v))
                                 (set! expr^ e^)
                                 (set! env-cps env^)
                            (value-of-cps))]
      [(thr-in-k v^)(begin (set! ak^ v^)
                      (apply-k))]
      [(let-in-k b^ env^ k^)(begin (set! k k^)
                                   (set! expr^ b^)
                                   (set! env-cps (envr_extend-env v env^))
                              (value-of-cps))]
      [(app-in-k c^ k^)(begin (set! ck^ k^)
                              (set! cl^ c^)
                              (set! cy v)
                         (apply-closure))]
      [(app-out-k ran^ env^ k^)(begin (set! k (kt_app-in-k v k^))
                                      (set! expr^ ran^)
                                      (set! env-cps env^)
                                 (value-of-cps))]
      )))


(define-union kt
  (empty-k)
  (*-in-k y^ k^)
  (*-out-k x^ env^ k^)
  (s1-in-k k^)
  (zr-in-k k^)
  (if-in-k c^ a^ env^ k^)
  (thr-out-k e^ env^)
  (thr-in-k v^)
  (let-in-k b^ env^ k^)
  (app-in-k c^ k^)
  (app-out-k ran^ env^ k^))

(define apply-env
  (lambda ()
    (union-case envr^ envr
      [(empty-env)(error 'value-of-cps "Unbound Identifier")]
      [(extend-env a^ env^)(if (zero? ey)
                               (begin (set! ak^ ek^)
                                      
                                      (set! v a^)
                                      
                               (apply-k))
                               (begin (set! envr^ env^)
                                      (set! ey (sub1 ey))
                                 (apply-env)))])))
      


(define apply-closure
  (lambda ()
    ;(display cl^)(newline)(newline)
    (union-case cl^ clos
      [(closure body^ env^)(begin (set! k ck^)
                                  (set! expr^ body^)
                                  (set! env-cps (envr_extend-env cy env^))
                             (value-of-cps))])))

(define-union clos
  (closure body^ env^))

(define-union envr
    (empty-env)
    (extend-env a^ env^))
            
(define main 
  (lambda ()
    (begin
      (set! expr^
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
       (expr_const 5))))
     (set! env-cps (envr_empty-env))
     (set! k (kt_empty-k))
     (value-of-cps))))
