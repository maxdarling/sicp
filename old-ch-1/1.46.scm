(load "utils/average.scm")
(load "utils/average-damp.scm")

;; iterative improvement func builder
(define (iterative-improve good-enough? improve)
  (lambda (guess)
      (if (good-enough? guess)
	  guess
	  ((iterative-improve good-enough? improve)
	   (improve guess)))))


;; alg: iteratively avg guess y with x/y
(define (sqrt-i x)
  ((iterative-improve
    (lambda (y)
      (< (abs (- (square y) x))
	 0.0001))
    (lambda (y)
      (average y (/ x y))))
   1.0))


;; alg: iterative fixed-point sol
(define (fixed-point f first-guess)
  (define (close-enough? guess)
    (define tolerance 0.00001)
    (< (abs (- guess (f guess)))
       tolerance))
  ((iterative-improve close-enough? f) first-guess))


;; test
(sqrt-i 36) ;; 6.0002...

(define (sqrt-f x)
  (fixed-point (average-damp (lambda (y) (/ x y)))
		1.0))

(sqrt-f 36) ;; 6.0000...
