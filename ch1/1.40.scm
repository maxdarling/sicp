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

(define (newtons-method g guess)
  (define (deriv g)
    (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))
  (define dx 0.00001)
  (define (newton-transform g)
    (lambda (x) (- x (/ (g x) ((deriv g) x)))))
  (fixed-point (newton-transform g) guess))



;; return the function x^3 + ax^2 + bx + c
(define (cubic a b c)
  (lambda (x) (+ (* x x x) (* a x x) (* b x) c)))


;; (x+1)(x+2)(x-1) = x^3 + 2x^2 - x - 2
(newtons-method (cubic 2 (- 1) (- 2)) -5) ;; -> -1.999...
(newtons-method (cubic 2 (- 1) (- 2)) -1.6) ;; -> -1.999...
(newtons-method (cubic 2 (- 1) (- 2)) -1.4) ;; -> -.999...
(newtons-method (cubic 2 (- 1) (- 2)) -0.2) ;; -> -.999...
(newtons-method (cubic 2 (- 1) (- 2)) 0.2) ;; -> -.999...
(newtons-method (cubic 2 (- 1) (- 2)) 0.3) ;; -> -1.00...
(newtons-method (cubic 2 (- 1) (- 2)) 3.6) ;; -> -1.00...
