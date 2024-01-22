;; proposed expmod
(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((even? exp)
	 (remainder (* (expmod base (/ exp 2) m)
		       (expmod base (/ exp 2) m))
		    m))
	(else
	 (remainder (* base
		       (expmod base (- exp 1) m))
		    m))))

;; original expmod
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


;; Discussion:
;; the original is a linear recursion. the proposed is *tree* recursion, meaning
;; execution time grows exponentially with depth of the tree. the depth of both
;; computations is logarithmic (since 'exp' is successively halved on each
;; iteration). therefore the original is logarithmic in the exponent N, and the
;; proposed is linear in N.
