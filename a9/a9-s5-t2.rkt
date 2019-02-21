#lang racket

(require "parenthc.rkt")

;;apply-closure cl^ cy ck^
;;apply-env envr^ ey ek^
;;apply-k k^ v

(define value-of-cps
  (lambda (expr^ env-cps k)
    (union-case expr^ expr
      [(const expr)(let* ([k^ k]
                         [v expr])
                     (apply-k k^ v))]
      [(mult x1 x2) (let* ([k (kt_*-out-k x2 env-cps k)]
                          [expr^ x1])
                      (value-of-cps expr^ env-cps k))]
      [(sub1 x) (let* ([k (kt_s1-in-k k)]
                       [expr^ x])
                  (value-of-cps expr^ env-cps k))]
      [(zero x)(let* ([k (kt_zr-in-k k)]
                      [expr^ x])
                 (value-of-cps expr^ env-cps k))]
      [(if test conseq alt)(let* ([k (kt_if-in-k conseq alt env-cps k)]
                                  [expr^ test])
                             (value-of-cps expr^ env-cps k))]
      [(letcc body)(let* ([env-cps (envr_extend-env k env-cps)]
                          [expr^ body])
                     (value-of-cps expr^ env-cps k))]
      [(throw k-exp e-exp)(let* ([k (kt_thr-out-k e-exp env-cps)]
                                 [expr^ k-exp])
                            (value-of-cps expr^ env-cps k))]
      [(let e body)(let* ([k (kt_let-in-k body env-cps k)]
                          [expr^ e])
                     (value-of-cps expr^ env-cps k))]                                                    
      [(var expr)(let* ([ek^ k]
                        [envr^ env-cps]
                        [ey expr])
                   (apply-env envr^ ey ek^))]
      [(lambda body)(let* ([k^ k]
                           [v (clos_closure body env-cps)])
                      (apply-k k^ v))]
      [(app rator rand)(let* ([k (kt_app-out-k rand env-cps k)]
                              [expr^ rator])
                         (value-of-cps expr^ env-cps k))]
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
  (lambda (k^ v)
    (union-case k^ kt
      [(empty-k) v]
      [(*-in-k y^ k^)(let* ([v (* v y^)])
                       (apply-k k^ v))]
      [(*-out-k x^ env^ k^)(let* ([k (kt_*-in-k v k^)]
                                  [expr^ x^]
                                  [env-cps env^])
                             (value-of-cps expr^ env-cps k))]
      [(s1-in-k k^)(let* ([v (sub1 v)])
                     (apply-k k^ v))]
      [(zr-in-k k^)(let* ([v (zero? v)])
                     (apply-k k^ v))]
      [(if-in-k c^ a^ env^ k^)(if v (let* ([k k^]
                                           [expr^ c^]
                                           [env-cps env^])
                                      (value-of-cps expr^ env-cps k))
                                  (let* ([k k^]
                                         [env-cps env^]
                                         [expr^ a^])
                                    (value-of-cps expr^ env-cps k)))]
      [(thr-out-k e^ env^)(let* ([k (kt_thr-in-k v)]
                                 [expr^ e^]
                                 [env-cps env^])
                            (value-of-cps expr^ env-cps k))]
      [(thr-in-k v^)(let* ([k^ v^])
                      (apply-k k^ v))]
      [(let-in-k b^ env^ k^)(let* ([k k^]
                                   [expr^ b^]
                                   [env-cps (envr_extend-env v env^)])
                              (value-of-cps expr^ env-cps k^))]
      [(app-in-k c^ k^)(let* ([ck^ k^]
                              [cl^ c^]
                              [cy v])
                         (apply-closure cl^ cy ck^))]
      [(app-out-k ran^ env^ k^)(let* ([k (kt_app-in-k v k^)]
                                      [expr^ ran^]
                                      [env-cps env^])
                                 (value-of-cps expr^ env-cps k))]
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
  (lambda (envr^ ey ek^)
    (union-case envr^ envr
      [(empty-env)(error 'value-of-cps "Unbound Identifier")]
      [(extend-env a^ env^)(if (zero? ey)
                               (let* ([k^ ek^]
                                      [v a^])
                               (apply-k k^ v))
                               (let* ([envr^ env^]
                                      [ey (sub1 ey)])
                                 (apply-env envr^ ey ek^)))])))
      


(define apply-closure
  (lambda (cl^ cy ck^)
    (union-case cl^ clos
      [(closure body^ env^)(let* ([k ck^]
                                  [expr^ body^]
                                  [env-cps (envr_extend-env cy env^)])
                             (value-of-cps expr^ env-cps k))])))

(define-union clos
  (closure body^ env^))

(define-union envr
    (empty-env)
    (extend-env a^ env^))
            
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
     (envr_empty-env)
     (kt_empty-k))))
(time (main))