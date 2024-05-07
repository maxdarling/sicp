(load "2.56.scm")

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sum
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; old: ('+ x 2)
;; new: ('+ x 2 3 ('+ 4 x...) 5...)

;; sum: a list with a leading plus, a first term (addend), and optional additional term(s) (augend).
;; a2 can be:
;; - empty
;; - an atom (a number/symbol or a sum/product)
;; - a list of atoms
(define (make-sum a1 a2)
  (cond ((and (null? a1) (null? a2)) 0)
	((null? a2) a1)
	((=number? a1 0) a2)
	((=number? a2 0) a1)
	((and (number? a1) (number? a2))
	 (+ a1 a2))
	(else
	 (if (or (not (pair? a2)) (sum? a2) (product? a2)) ;; slightly messy...?
	     (list '+ a1 a2)
	     (append (list '+ a1) a2)))))


;; no change
(define (sum? x) (and (pair? x) (eq? (car x) '+)))

;; no change
(define (addend s) (cadr s))

;; result must be a sum since we will be taking derivatives of it.
(define (augend s) (make-sum (caddr s) (cdddr s)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; product
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; old: ('* 1 2)
;; new: ('* 1 2 3 ('* 4 5...) 6...)

;; product: same scheme as sum above.
(define (make-product m1 m2)
  (cond ((and (null? m1) (null? m2)) 0)
	((null? m2) m1)
	((or (=number? m1 0) (=number? m2 0)) 0)
	((=number? m1 1) m2)
	((=number? m2 1) m1)
	((and (number? m1) (number? m2)) (* m1 m2))
	(else
	 (if (or (not (pair? m2)) (product? m2) (sum? m2))
	     (list '* m1 m2)
	     (append (list '* m1) m2)))))

(define (product? x) (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))

(define (multiplicand p) (make-product (caddr p) (cdddr p)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; testing
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(deriv '(+ x x y (+ x 3 4 5 6)) 'x) ;; works
(deriv '(* x x) 'x) ;; works
(deriv '(* x x x) 'x) ;; works
(deriv '(* x y (+ x 3)) 'x) ;; works


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; notes
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; the solutions are pretty clean. they do all the work in the selectors by checking
;; if the product is just 2 items or is longer. I thought about this but decided
;; not to, since then I could make my make-{sum,product} procedures more general by
;; having them be able to handle null args. but alas. below is much better, though.
(define (augend s) 
   (if (> (length s) 3) 
       (cons '+ (cddr s)) 
       (caddr s))) 
  
 (define (multiplicand p) 
   (if (> (length p) 3) 
       (cons '* (cddr p)) 
       (caddr p))) 

;; or
 (define (augend s) 
   (if (> (length s) 3) 
       (make-sum (caddr s) (cdddr s))
       (caddr s)))

(define (multiplicand p) 
   (if (> (length p) 3) 
       (make-product (caddr p) (cdddr p))
       (caddr p)))
  


;; this really should have been clear from the start. I was thinking about it wrong.
;; it's quite simple:
;; - a sum/product is a leading operator and a list of arguments
;; - in the original problem statement it was only 2 arguments
;; - in this problem it was generalized to n>=2 arguments
;; - if there's only 2 arguments, the "rest" (augend/multiplicand) is just an atom
;; and you can return it directly
;; - if there's >2 arguments, the "rest" is a sum/product of the "rest". you need to
;; remember to make it a sum/product before you return it.
