#lang racket

(define value-of-cps
  (lambda (expr env-cps k)
    (match expr
      [`(const ,expr)(k expr)]
      [`(mult ,x1 ,x2) (value-of-cps x1 env-cps (lambda (v)(value-of-cps x2 env-cps (lambda (y)(k(* v y))))))]
      [`(sub1 ,x) (value-of-cps x env-cps (lambda (a)(k(sub1 a))))]
      [`(zero ,x)(value-of-cps x env-cps (lambda (a) (k (zero? a))))]
      [`(if ,test ,conseq ,alt)(value-of-cps test env-cps (lambda(t)
                                   (if t
                                         (value-of-cps conseq env-cps k)
                                         (value-of-cps alt env-cps k))))]
      [`(letcc ,body)(value-of-cps body (lambda(y k^)(if (zero? y) (k^ k) (env-cps (sub1 y)k^)))k)]
      [`(throw ,k-exp ,e-exp)(value-of-cps k-exp env-cps (lambda(x)(value-of-cps e-exp env-cps (lambda (a)(x a)))))]
      [`(let ,e ,body)(value-of-cps e env-cps (lambda (a)
                                                (value-of-cps body (lambda (y k^) (if (zero? y) (k^ a) (env-cps (sub1 y)k^)))k)))]
                                                          
      [`(var ,expr)(env-cps expr k)]
      [`(lambda ,body)(k(lambda (a k^)(value-of-cps body (lambda (y k^) (if (zero? y) (k^ a) (env-cps (sub1 y)k^)))k^)))]
      [`(app ,rator ,rand)(value-of-cps rator env-cps (lambda (c) (value-of-cps rand env-cps (lambda (y) (c y k)))))]
      )))


(define empty-env
  (lambda ()
    (lambda (y)
      (error 'value-of-cps "unbound identifier"))))
            
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
