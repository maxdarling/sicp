(define tolerance 0.00001)

;; modify fixed-point to print successive guesse
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (newline)
      (display guess)
      (if (close-enough? guess next)
	  next
	  (try next))))
  (try first-guess))


;; goal: solve x^x = 1000 with the fixed point method.

(define (f x) (/ (log 10.0) (log x)))
(fixed-point f 1.1) ;; ans: x=4.555530807938518 guesses=36

;; do it again, but with average damping (e.g. x = 1/2(x + f(x)))
(define (g x) (average x (f x)))
(fixed-point g 1.1) ;; ans: x=4.555536364911781 guesses=13

;; average damping helps convergance a lot!
