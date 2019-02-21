#lang racket

(require "mk.rkt")
(require "numbers.rkt")


;;            Caulin Jones            |         a13





;;listo


(define listo
  (lambda (x)
    (conde
      [(== x '())]
      [(fresh (a b) (=/= `(,a . ,b) x))]
      [(fresh (a b res)
              (== `(,a  ,b) x)
              (== x res)
              (listo res))]
      )))


;;facto
(define facto
  (lambda (x y)
    (conde
     ((== x)))))


;;fibso
(define fibs
    (lambda (n)
      (cond
        ((eqv? n 0) (values 1 1))
        (else
         (let ((n- (- n 1)))
           (let-values (((u v) (fibs n-)))
             (let ((u+v (+ u v)))
               (values v u+v))))))))
#|
(define fibso
  (lambda (x o1 o2)
    (conde
     ((== x 0)(== o1 1)(== o2 1))
     (fresh (n-)
            (== n- (minuso x 1))
            (fresh (u v)
                   (== u o2)
                   (== o1 x)
                   (== o2 (pluso u v))
                   (fibso n- o1 o2)
            )))))
|#



;;of-lavo

#|
(define (lookup x vars vals o)
  (fresh (y vars^ a vals^)
    (== `(,y . ,vars^) vars)
    (== `(,a . ,vals^) vals)
    (conde
      ((== x y) (== o a))
      ((=/= x y) (lookup x vars^ vals^ o)))))

(define (valof* es vars vals o)
  (conde
    [(== es `()) (== '() o)]
    [(fresh (e es^)
       (== es `(,e . ,es^))
       (fresh (v vs)
         (== `(,v . ,vs) o)
         (valof e vars vals v)
         (valof* es^ vars vals vs)))]))

(define (valof e vars vals o)
  (conde
    [(symbolo e) (lookup e vars vals o)]
    [(== e `(quote ,o))
     (absento 'quote vars)
     (absento 'closure e)]
    [(fresh (es)
       (== e `(list . ,es))
       (absento 'list vars)
       (valof* es vars vals o))]
    [(fresh (x b)
       (== e `(λ (,x) ,b))
       (symbolo x)
       (absento 'λ vars)
       (== `(closure ,x ,b ,vars ,vals) o))]
    [(fresh (rator rand)
       (== e `(,rator ,rand))
       ;; (=/= rator 'quote)
       ;; (=/= rator 'list)
       (fresh (x b vars^ vals^ a)
         (valof rator vars vals `(closure ,x ,b ,vars^ ,vals^))
         (valof rand vars vals a)
         (valof b `(,x . ,vars^) `(,a . ,vals^) o)))]))

(define (dano a b)
  (valof a '() '() b))
|#


(define lookupo
  (lambda (env x b)
    (fresh (aa da d)
           (== env `((,aa . ,da) . ,d))
           (conde
            ((== aa x)(== da b))
            ((=/= aa x)(lookupo d x b))))))
