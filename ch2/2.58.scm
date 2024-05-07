(load "2.56.scm")

;; a) support infix notation, e.g. (x + (3 * (x + (y + 2))))
;; - assume + and * always take 2 arguments
;; - assume expressions are fully parenthesized 
;; - don't change the differentiation prodecdure


;; strategy:
;; - just have products/sums be lists of 3 items: (arg1 op arg2)
;; - everything else can stay the same...?

;; sum
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
	((=number? a2 0) a1)
	((and (number? a1) (number? a2))
	 (+ a1 a2))
	(else (list a1 '+ a2)))) ;; changed

(define (sum? x) (and (pair? x) (eq? (cadr x) '+))) ;; changed

(define (addend s) (car s)) ;; changed

(define (augend s) (caddr s))

;; products
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
	((=number? m1 1) m2)
	((=number? m2 1) m1)
	((and (number? m1) (number? m2)) (* m1 m2))
	(else (list m1 '* m2)))) ;; changed

(define (product? x) (and (pair? x) (eq? (cadr x) '*))) ;; changed

(define (multiplier p) (car p)) ;; changed

(define (multiplicand p) (caddr p))


;; testing
(deriv '(x + (3 * (x + (y + 2)))) 'x)
(deriv '(x + (3 * (x * x))) 'x)




;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; part b)
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; it's kinda hard. previously (above in this problem, or with prefix notation) each expression has
;; 1 operator in an obvious/unchanging location and the arguments follow. but with standard algebraic
;; notation, you have to do some work to determine the operator precedence and track the parentheses
;; and arguments.

;; take the below as an example:
;; (x + 3 * (x + y + 2))...

;; I feel fine parsing this into a non-ambiguous form like parenthesized prefix notation
;; going char by char:
;; 1. paren. so start parsing an expression and expect a closing paren later.
;; 2. see 'x. we know operator must be next
;; 3. see '+. we know this is a sum of x and the rest of the expression. so: (make-sum x "rest")
;; 4. see 3
;; 5. see '*. so: (make-product 3 "rest")
;; 6. paren. so start parsing an expression and expect a closing paren later.
;; 7. see x
;; 8. see +. so: (make-sum x "rest")
;; 9. see y
;; 10. see +. so: (make-sum y "rest")
;; 11. see 2
;; 12. close-paren. end current expression.
;; 13. close-paren. end current expression.
;; ...

;; this is a rough sketch but it's the core of the parsing idea.
;; the hard thing is that you need to do all that just to answer what kind of expression it is, e.g.
;; a product or a sum, which is equivalent to determining which operator comes last. e.g. the above example
;; is a sum (of x and 3 * (x + y + 2)).
;; from there you can take your derivatives since you can split the expression into addend and augend, etc.


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; post-solution
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yeah, people are converting to prefix notation. makes sense. anyhow. I don't feel like implementing
;; that right now, but this would be worth revisiting in the future.
