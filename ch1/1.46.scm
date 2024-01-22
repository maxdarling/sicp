(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (display next) (newline)
      (if (close-enough? guess next)
	  next
	  (try next))))
  (try first-guess))


(define (iterative-improve good-enough? improve-guess)
  (define (iter guess)
    (if (good-enough? guess)
	guess
	(iter (improve-guess guess))))
  iter)

(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))

  ((iterative-improve
    (lambda (x) (close-enough? x (f x)))
    f)
    first-guess))


;; TESTING
(fixed-point (lambda (y) (+ (sin y) (cos y))) 1.0)

(define (sqrt x)
  (fixed-point (lambda(y) (/ (+ y (/ x y)) 2)) 1.0))
(sqrt 49)
