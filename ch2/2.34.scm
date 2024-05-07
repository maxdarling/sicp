(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) (+ this-coeff (* x higher-terms)))
	      0
	      coefficient-sequence))

;; testing
;; f(x) = 1 + 3x + 5x^3 + x^5
;; f(2) = 79
(horner-eval 2 (list 1 3 0 5 0 1))

(define x 2)

(+ 1 (* x
	(+ 3 (* x
		( + 0 (* x
			 (+ 5 (* x
				 (+ 0 (* x
					 (+ 1 (* x
						 0))))))))))))

     
