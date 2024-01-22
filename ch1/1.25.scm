;; original procedure:
(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((even? exp)
	 (remainder
	  (square (expmod base (/ exp 2) m))
	  m))
	(else
	 (remainder
	  (* base (expmod base (- exp 1) m))
	  m))))

;; proposed procedure:
(define (expmod base exp m)
  (remainder (fast-expt base exp) m))
(define (fast-expt b n)
  (cond ((= n 0) 1)
	((even? n) (square (fast-expt b (/ n 2))))
	(else (* b (fast-expt b (- n 1))))))


;; Discussion:
;; indeed the proposed procedure has less steps. however, the
;; massive advantage of the original is that repeated application
;; of mod m keeps the intermediate numbers (that get squared) small - 
;; precisely, intermediate results never exceed m. the latter solution, on the
;; other hand, squares numbers on huge numbers of ~a^n size. and computation on
;; arbitrarily large numbers is computationally expensive.
