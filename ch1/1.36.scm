(define tolerance 0.00001)
(define (fixed-point f first-guess)
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

(define (average x y) (/ (+ x y) 2))


;; find a solution to x^x = 1000 via the fixed-point method on x -> log(1000)/log(x)

;; no average-damping: 36 iterations
(fixed-point (lambda (x) (/ (log 1000) (log x))) 1.1) ;; -> 4.555

;; with average-damping: 12 iterations
(fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) 1.1) ;; -> 4.555
