(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
	(else else-clause)))

;; (new-if (= 2 3) 0 5)
;; 5
;; (new-if (= 1 1) 0 5)
;; 0

(define (sqrt-iter guess x)
  (define (improve guess x)
    (average guess (/ x guess)))
  (define (average x y)
    (/ (+ x y) 2))
  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))

  (new-if (good-enough? guess x)
	  guess
	  (sqrt-iter (improve guess x) x)))

(sqrt-iter 1.0 2)


;; 'new-if', being an ordinary procedure, will be
;; evaluated in applicative-order, i.e. all 3 arguments will be evaluated, then
;; the operator will be expanded.
;; this is in stark contrast to 'if', a special-form, for which the predicate is
;; evaluated and then *either* the first or second clause is evaluated. 

;; programs in which an "if" is used as a check to stop recursion rely on this
;; behavior. using "new-if" will result in non-stop recursion because the
;; consequent and alternate clauses are evaluated regardless of the predicate.
