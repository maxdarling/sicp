(define (make-rat n d)
  (let ((g (gcd n d)))
    ;; normalize signs
    (if (< d 0)
	(cons (/ (- n) g)
	      (/ (- d) g))
	(cons (/ n g)
	      (/ d g)))))

;; boilerplate
(define (numer x) (car x))
(define (denom x) (cdr x))

;; n1 / d1) + (n2 / d2) 
(define (add-rat a b)
  (make-rat (+ (* (numer a) (denom b))
	       (* (numer b) (denom a)))
	    (* (denom a) (denom b))))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))



(define one-half (make-rat 1 2))
(define one-third (make-rat 1 3))
(print-rat one-half)
(print-rat one-third)
(print-rat (add-rat one-half one-half))

(print-rat (make-rat 1 (- 2)))
(print-rat (make-rat (- 1) (- 2)))
(print-rat (make-rat (- 1) 2))
