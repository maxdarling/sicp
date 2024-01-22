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


;; golden ratio φ is a fixed point of x → 1 + 1/x.
;; because taking the definition φ^2 = φ + 1, we divide by φ and get
;; φ = 1 + 1/φ

;; approximation of φ using fixed point:
(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0) ;; -> 1.618
