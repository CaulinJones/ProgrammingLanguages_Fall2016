#lang racket
(require "monads.rkt")


;;         Caulin Jones       |      Assignment 12            |      November 30 2016

;;assv-maybe



(define assv-maybe
  (lambda (sym ls)
    (cond
      [(null? ls) (fail)]
      [(eqv? (car (car ls)) sym)(return-maybe (car (car ls)))]
      [else (bind-maybe (assv-maybe sym (cdr ls))
                        (lambda (a) (return-maybe a)))])))



;;partition-writer
(define partition-writer
  (lambda (pr ls)
    (cond
      [(null? ls) (return-writer '())]
      [(pr (car ls))
       (bind-writer (tell-writer (car ls))
                    (lambda (a)
                      (partition-writer pr (cdr ls))))]
      [else
       (bind-writer (return-writer (car ls))
                    (lambda (a)
                      (bind-writer (partition-writer pr (cdr ls))
                                   (lambda (b)
                                     (return-writer (cons a b))))))])))



;;powerXpartial


(define powerXpartials
  (lambda (x n)
    (cond
      [(zero? n) (return-writer 1)]
      [(= n 1) x]
      [(odd? n)
       (bind-writer (tell-writer x)
                    (lambda (a)
                      (bind-writer (* x (powerXpartials x (sub1 n)))
                                   (lambda (b) (return-writer b)))))]
      [(even? n)(bind-writer
                 (tell-writer x)
                 (lambda (a)
                   (bind-writer
                 (let ((nhalf (/ n 2)))
                  (let ((y (powerXpartials x nhalf)))
                    (* y y)))
                 (lambda (b)
                   (return-writer b)))))])))



(define traverse
    (lambda (return bind f)
      (letrec
        ((trav
           (lambda (tree)
             (cond
               [(pair? tree)
                (do bind
                  (a <- (trav (car tree)))
                  (d <- (trav (cdr tree)))
                  (return (cons a d)))]
               [else (f tree)]))))
        trav)))
;;reciprical
(define reciprocal
  (lambda (n)
    (cond
      [(zero? n)(fail)]
      [else (return-maybe (/ 1 n))])))

(define traverse-reciprocal
  (traverse return-maybe bind-maybe reciprocal))
;;halve

(define halve
  (lambda (n)
    (cond
      [(even? n) (bind-writer (tell-writer '())
                  (lambda (a) (return-writer (/ n 2))))]
      [else (bind-writer (tell-writer n)
                         (lambda (a) (return-writer n)))])))

(define traverse-halve
  (traverse return-writer bind-writer halve))
