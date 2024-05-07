;; polynomial package. for use with rational-poly problems 2.93 - 2.97
(define (install-polynomial-package)
  ;; representation of poly
  (define (make-poly variable term-list) (cons variable term-list))
  (define (variable p) (car p))
  (define (term-list p) (cdr p))

  ;; representation of terms and term lists
  (define (adjoin-term term term-list)
    (if (=zero? (coeff term))
	term-list
	(cons term term-list)))
  (define (the-empty-termlist) '())
  (define (first-term term-list) (car term-list))
  (define (rest-terms term-list) (cdr term-list))
  (define (empty-termlist? term-list) (null? term-list))
  (define (make-term order coeff) (list order coeff))
  (define (order term) (car term))
  (define (coeff term) (cadr term))

  ;; term list procedures
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
  (define (mul-terms L1 L2)
    (if (empty-termlist? L1)
	(the-empty-termlist)
	(add-terms (mul-term-by-all-terms (first-term L1) L2)
		   (mul-terms (rest-terms L1) L2))))
  (define (mul-term-by-all-terms t1 L)
    (if (empty-termlist? L)
	(the-empty-termlist)
	(let ((t2 (first-term L)))
	  (adjoin-term
	   (make-term (+ (order t1) (order t2))
		      (mul (coeff t1) (coeff t2)))
	   (mul-term-by-all-terms t1 (rest-terms L))))))

  ;; poly procedures
  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
	(make-poly (variable p1)
		   (add-terms (term-list p1) (term-list p2)))
	(error "Polys not in same var: ADD-POLY" (list p1 p2))))

  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
	(make-poly (variable p1)
		   (mul-terms (term-list p1) (term-list p2)))
	(error "Polys not in same var: MUL-POLY" (list p1 p2))))

  ;; 2.88
  (define (negate-terms terms)
    (if (empty-termlist? terms)
	(the-empty-termlist)
	(let ((order (order (first-term terms)))
	      (coeff (coeff (first-term terms))))
	  (adjoin-term (make-term order (negate coeff))
		       (negate-terms (rest-terms terms))))))

  (define (sub-terms L1 L2)
    (add-terms L1 (negate-terms L2)))

  (define (negate-poly x)
    (make-poly (variable x) (negate-terms (term-list x))))

  (define (sub-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
	(make-poly (variable p1)
		   (sub-terms (term-list p1) (term-list p2)))
	(error "Polys not in same var: SUB-POLY" (list p1 p2))))

  ;; 2.91
  (define (div-terms L1 L2)
    (if (empty-termlist? L1)
	(list (the-empty-termlist) (the-empty-termlist))
	(let ((t1 (first-term L1))
	      (t2 (first-term L2)))
	  (if (> (order t2) (order t1))
	      (list (the-empty-termlist) L1)
	      (let ((new-c (div (coeff t1) (coeff t2)))
		    (new-o (- (order t1) (order t2))))
		(let ((rest-of-result
		       (div-terms (sub-terms L1
					     (mul-term-by-all-terms (make-term new-o new-c) L2))
				  L2)))
		  (list (adjoin-term (make-term new-o new-c) (car rest-of-result))
			(cadr rest-of-result))))))))
  (define (div-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
	(let ((div-terms-result (div-terms (term-list p1) (term-list p2))))
	  (list (make-poly (variable p1) (car div-terms-result))
		(make-poly (variable p1) (cadr div-terms-result))))
	(error "Polys not in same var: DIV-POLY" (list p1 p2))))

  ;; 2.94
  (define (remainder-terms a b)
    (cadr (div-terms a b))) 

  ;; (define (gcd-terms a b)
  ;;   (if (empty-termlist? b)
  ;; 	a
  ;; 	(gcd-terms b (remainder-terms a b))))

  (define (gcd-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
	(make-poly (variable p1)
		   (gcd-terms (term-list p1) (term-list p2)))
	(error "Polys not in same var: GCD-POLY" (list p1 p2))))

  ;; 2.96
  (define (pseudoremainder-terms a b)
    (let ((integerizing-factor (expt (coeff (first-term b))
				     (+ 1 (- (order (first-term a)) (order (first-term b)))))))
      (cadr (div-terms
	     (mul-term-by-all-terms (make-term 0 integerizing-factor) a)
	     b))))

  (define (gcd-terms a b)
    (if (empty-termlist? b)
	;; a
	(let ((gcd-of-coeffs (apply gcd (map cadr a)))) ;; 2.96 b)
	  (mul-term-by-all-terms (make-term 0 (/ 1 gcd-of-coeffs)) a))
	(gcd-terms b (pseudoremainder-terms a b)))) ;; 2.96 a)

  ;; 2.97
  (define (reduce-terms n d)
    ;; 1. mul by integerizing factor
    ;; 2. div by term GCD
    ;; 3. div by integer GCD
    (let* ((term-gcd (gcd-terms n d))
	   (c (coeff(first-term term-gcd)))
	   (O1 (max (order (first-term n)) (order (first-term d))))
	   (O2 (order (first-term term-gcd)))
	   (factor (expt c (+ 1 (- O1 O2))))
	   (int-gcd (apply gcd (append (map cadr n) (map cadr d)))))
      (map (lambda (terms) (mul-term-by-all-terms (make-term 0 (/ 1 int-gcd)) terms))
	   (map (lambda (terms) (car (div-terms terms term-gcd)))
		(map (lambda (terms) (mul-term-by-all-terms (make-term 0 factor) terms))
		     (list n d))))))

  (define (reduce-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
	(let ((reduced-terms (reduce-terms (term-list p1) (term-list p2))))
	  (list (make-poly (variable p1) (car reduced-terms))
		(make-poly (variable p1) (cadr reduced-terms))))
	(error "Polys not in same var: REDUCE-POLY" (list p1 p2))))

  ;; interface to rest of the system
  (define (tag p) (attach-tag 'polynomial p))
  (put 'add '(polynomial polynomial)
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put 'mul '(polynomial polynomial)
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  (put 'sub '(polynomial polynomial)
       (lambda (p1 p2) (tag (sub-poly p1 p2))))
  (put 'div '(polynomial polynomial)
       (lambda (p1 p2) (tag (div-poly p1 p2))))
  (put 'negate '(polynomial)
       (lambda (p) (tag (negate-poly p))))
  (put 'greatest-common-divisor '(polynomial polynomial)
       (lambda (p1 p2) (tag (gcd-poly p1 p2))))
  (put 'reduce '(polynomial polynomial)
       (lambda (p1 p2) (map tag (reduce-poly p1 p2))))
  (put 'make 'polynomial
       (lambda (var terms) (tag (make-poly var terms))))
  'done)

;; external users:
(define (make-polynomial var terms)
  ((get 'make 'polynomial) var terms))


;; testing
;; (load "generic.scm")
;; (install-polynomial-package)
;; (define p1 (make-polynomial 'x '((1 2) (0 1))))  ;; 2x + 1
;; (define p2 (make-polynomial 'x '((3 1) (0 -1)))) ;; x^3 - 1

;; (define p3 (add p1 p2)) ;; x^3 + 2x
;; (define p4 (mul p1 p2)) ;; 2x^4 + x^3 - 2x - 1
;; p4
