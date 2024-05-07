;; add terms (reference)
(define (add-terms L1 L2)
  (cond ((empty-termlist? L1) L2)
	((empty-termlist? L2) L1)
	(else
	 (let ((t1 (first-term L1))
	       (t2 (first-term L2)))
	   (cond ((> (order t1) (order t2))
		  (adjoin-term
		   t1 (add-terms (rest-terms L1) L2)))
		 ((< (order t1) (order t2))
		  (adjoin-term
		   t2 (add-terms L1 (rest-terms L2))))
		 (else
		  (adjoin-term
		   (make-term (order t1)
			      (add (coeff t1) (coeff t2)))
		   (add-terms (rest-terms L1)
			      (rest-terms L2)))))))))

;; reference
(define (add-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
		 (add-terms (term-list p1) (term-list p2)))
      (error "Polys not in same var: ADD-POLY" (list p1 p2))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; solution
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; idea: leverage add-terms, but just negate the second term argument.
;; for this, we will need a generic negation procedure (or a generic subtraction procedure,
;; same thing).

;; generic negation 
(define (negate x) (apply-generic 'negate x)) 

;; poly negation (inside poly package)
(define (negate-poly x)
  (define (negate-terms terms)
    (if (empty-termlist? terms)
	(the-empty-termlist)
	(let ((order (order (first-term terms)))
	      (coeff (coeff (first-term terms))))
	  (adjoin-term (make-term order (negate coeff))
		       (negate-terms (rest-terms terms))))))

  (make-poly (variable x) (negate-terms (term-list x))))

(put 'negate 'polynomial (lambda (p) (tag (negate-poly p))))

(define (sub-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
		 (add-terms (term-list p1) (term-list (negate p2))))
      (error "Polys not in same var: SUB-POLY" (list p1 p2)))))

(put 'sub '(polynomial polynomial) (lambda (p1 p2) (tag (sub-poly p1 p2))))

;; additional: install negate for other numeric types
(put 'negate 'scheme-number -)
(put 'negate 'rational (lambda (x) (make-rat (negate (numer x)) (denom x)))))
(put 'negate 'complex (lambda (x)
			(make-complex-real-imag (negate (real x)) (negate (imag x)))))



;; post-solution note:
;; Many people confusing when and when not to tag. but it's finally clear to me now:
;; - internal packages will define a private make-X procedure (untagged). they then provide
;; it, wrapped in a tag, via a (put 'make 'X (lambda (x) (tag (make-X ...))))
;; - THEN, there's a public constructor (define (make X ...) (apply-generic 'make 'X))
;;
;; this is important to understand. this keeps the tagging fully encapsulated by the package.
;; the people in the solutions are just getting confused that there's a public and private version
;; of each of these make functions.
