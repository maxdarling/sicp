;; original procedure using type dispatch
(define (deriv exp var)
  (cond ((number? exp) 0)
	((variable? exp)
	 (if (same-variable? exp var) 1 0))
	((sum? exp)
	 (make-sum (deriv (addend exp) var)
		   (deriv (augend exp) var)))
	((product? exp)
	 (make-sum (make-product
		    (multiplier exp)
		    (deriv (multiplicand exp) var))
		   (make-product
		    (deriv (multiplier exp) var)
		    (multiplicand exp))))
	;; ⟨more rules can be added here⟩
	(else (error "unknown expression type: DERIV" exp))))


;; new procedure using data-directed dispatch
(define (deriv exp var)
  (cond ((number? exp) 0)
	((variable? exp) (if (same-variable? exp var) 1 0))
	(else ((get 'deriv (operator exp))
	       (operands exp) var))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))


;; a)
;; - we used the data-directed dispatch style instead of type dispatch. that is, we use the
;; type+operation table to lookup and apply the derivative procedure that matches the type of
;; the expression.
;; - you can't apply the data-directed dispatch technique for 'number?' and 'same-variable?'
;; because the expressions they act on have no types (operators) E.g. the expression '1' or 'x'.

;; b + c)
;; note: all solutions are assuming the generic 'deriv take args <exp> <var>, but the book
;; code above is passing **<operands> <var>**. Idk why. I'm going to assume it's passing the
;; expression though, which lets me leverage the existing the procedures like augend, addend and
;; their analogs which are defined for *expressions*.

;; note 2: we are just tasked with using data-dispatch to make taking derivatives generic. we are
;; not attempting to make expressions generic, i.e. using data-dispatch to unify selectors across
;; all types of expressions like sums, products, etc. I'm not even sure that would be very useful.
;; some guy in the solutions did it for make, and it seems dumb.
(define (install-basic-deriv-package)
  ;; provides derivs for sums, product, and exponents
  (define (deriv-sum exp var)
    (make-sum (deriv (addend exp) var)
	      (deriv (augend exp) var)))
  (define (deriv-product exp var)
    (make-sum (make-product
	       (multiplier exp)
	       (deriv (multiplicand exp) var))
	      (make-product
	       (deriv (multiplier exp) var)
	       (multiplicand exp))))
  (define (deriv-exponent exp var)
    (make-product
     (make-product (exponent exp)
		   (make-exponentiation (base exp) (make-sum (exponent exp) (- 1))))
     (deriv (base exp) var)))

  (put 'deriv '+ deriv-sum)
  (put 'deriv '* deriv-product)
  (put 'deriv '^ deriv-exponent))


;; d)
;; if you decide to change the way you index the table from <op> <type> to <type> <op>, then
;; you simply need to change all the 'get' and 'put' calls in the system to have their args
;; flipped. which is not too hard with a refactoring tool, etc.


;; post-solution note: people were absolutely going nuts on this one. to be fair, I was also
;; confused a bit. but yes, I'm pretty positive that you have to leave all the constructors and
;; selectors as top-level functions. those should never be private as all but 1 solution did, that
;; makes no sense (those are the core expression interfaces, why should they be internal to deriv).
