#lang racket
(require "mk.rkt")
(require "numbers.rkt")

;; Part I Write the answers to the following problems using your
;; knowledge of miniKanren.  For each problem, explain how miniKanren
;; arrived at the answer.  You will be graded on the quality of your
;; explanation; a full explanation will require several sentences.

;; 1 What is the value of 

(run 2 (q)
  (== 5 q)
  (conde
   [(conde 
     [(== 5 q)
      (== 6 q)])
    (== 5 q)]
   [(== q 5)]))
#|
The answer is a list containing the single element 5. Our run shows that we are looking for single results because
only one variable, q , is in the run section. The result will be a maximun of 2 answers because run is taking 2 as a
parameter. Immediatly we find that q is associated with 5 by the ==, so all answers must involve q being associated wiht 5.
Next we see conde, so we must exaluate the cases inside if they are logically acceptable with (== q 5). each case in the conde
is treated list a conj expression,so all expression inside a case must be logically valid for any expression in the case to be valid.
The first case in the conde is another conde so now we exaluate for that conde's cases. The only case in this inner conde
set (== q 6) (== q 6) which is invalid. Since our answers involve only one q and q already is required to be 5, the first expression (== 5 q) is valid
but the second expression in the case (== q 6) is invalid because q cannot be both 5 and 6, so this conde case is invalid, therfor not applied to our results.
The inner-conde is part of a single case of the outer conde, though since the conde, expression was invalid,
the (== 5 q) which is part of the same case cannot be valid since it is in the same case with an invalid expression.
Now we can evaluate our last case of the outer conde (== 5 q) which is valid, and the only expression in its case so the case is valid.
This case is valid because (== q 5) and (== 5 q) becasuse of the law of ==, which shows communitivity amongst == expressions.
So when run 2 (q) run a mximum of 2 answers tha satisfies our two valid expressions (== q 5) (== 5 q) we get a list of only one answer, 5.
|#

;; 2 What is the value of
(run 1 (q) 
  (fresh (a b) 
    (== `(,a ,b) q)
    (absento 'tag q)
    (symbolo a)))

#|
In this function we have run 1  which means that we will be running for 1 answer that is for value q.
 We now have the fresh operator which defines two new variables a and b. In the first like we set equivalence to q
as being a tagged list with values with variables a and b. So as of now our result will be a lagged list with two variables.
Next we have and expression with absento, which takes the symbol 'tag and maks sure that this symbol does not appear in the term q.
Since q is our output variable, the sybol 'tag cannot apprear in valid answers. Next we  have an expression with symbolo
which takes a and indicates that valid answers containing variable a must have a as type symbol.
We get our 1 result for being the tagged list of variables a and b. so the result is '(((_.0 _.1)(=/= ((_.0 tag))) (sym _.0)(absento (tag _.1)))
We the ist (_.0 _.1) is our result for q. We associate q with the taged list that includes fresh variables a and b. WE nexer bind a and b to any value,
so we get the default unboudned results _.0 and _.1. Since we never bind these to anything we get the explination that
our results are two items such that a does not equal the value 'tag as explained by (=/= _.0 tag) and since a was with symbolo
we see that a is unbounded but it is also a symbol, as explained by (sym _.0). Absento makes sure that a symbol does not exist in a valid answers
so the (absento (tag _.1))) simple says that _.1 is not the sybmbol tag simply because _.1 is not a sybbol. This is also why it was not discloded in the =/= part of the result be cause that expression
only contains things properly evaluated by absento, so if something is not a symbol, it does not need to be exaluated in absento.
|#

;; 3 What do the following miniKanren constraints mean?
;; a ==
;Equality constraint. This constraint sets equivalence between two items, typically a value to a variable. This sets a new "goal" for the run to acheive when building its list of results.
;; b =/=
;;Disequality constrait. This constraint says that two items cannot be equivalent in a valid answer. 
;; c absento
;;Absento is a constraint that take a symbol and a term and says that any thing within the term cannot also be the symbol given in absento.
;; d numbero
;;Numbero is a constraint that says a value must be a number in order to be a valid answer.
;; e symbolo
;;symbolo is a constraint that say a value must be a symbol in order to be a valid answer

;; Part II goes here.
;assoco
(define assoc
  (lambda (x ls)
    (match-let* ((`(,a . ,d) ls)
                 (`(,aa . ,da) a))
      (cond
        ((equal? aa x) a)
        ((not (equal? aa x)) (assoc x d))))))

(define assoco
  (lambda (x ls out)
    (fresh (a d aa da)
           (== `(,a . ,d) ls)
           (== `(,aa . ,da)a)
      (conde
        ((== aa x)(== a out))
        ((=/= aa x)(assoco a ls out))
        ))))

;;reverso
(define reverse
  (lambda (ls)
    (cond
      ((equal? '() ls) '())
      (else
       (match-let* ((`(,a . ,d) ls)
                    (res (reverse d)))
         (append res `(,a)))))))

(define reverseo
  (lambda (ls out)
    (conde
     ((== ls '())(== out '()))
      ((fresh (a d)
             (== `(,a . ,d) ls)
             (fresh (res)
                    (appendo res '(,a) out)
                    (reverseo d res)
                    ))))))
             
             
             
;;stuttero

(define stutter
  (lambda (ls)
    (cond
      ((equal? '() ls) '())
      (else 
        (match-let* ((`(,a . ,d) ls)
		     (res (stutter d)))
          `(,a ,a . ,res))))))

(define stuttero
  (lambda (ls out)
    (conde
     [(== ls '())(== out '())]
     [(fresh (a d)
             (== ls '(,a . ,d))
             (fresh (res)
                    (== out '(,a ,a . ,res))))])))



;;membero

(define membero
  (lambda (x ls out)
    (conde
     [(== ls '())(== out #f)]
     [(fresh (a d)
             (== ls `(,a . ,d))
             
             (fresh (res))
             ]