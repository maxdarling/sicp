;; copied fixed point function from text
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
	  next
	  (try next))))
  (try first-guess))


;; ex: show that the golden ratio is a fixed point of f(x) = 1 + 1/x

;; approx: clear that repeatedly applying x narrows its possible range. e.g. after
;; f^2(x) the range is [1,2], then [1.5, 2]. Golden ratio is ~1.6 if I remember
;; correcty so it seems pretty plausible. 

;; proof:
;; simply solve the equation f(x) = 1 + 1/x for x = (1 + sqrt(5)) / 2 which proves
;; its a fixed point

;; check:
(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1) ;Value: 1.618032786885246
