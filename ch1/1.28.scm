;; modified to return 0 to signal a non-trivial square root of 1.
(define (expmod base exp m)
  (define (squaremod-check x)
    (define y (remainder (square x) m))
    (if (and (not (= x 1)) (not (= x (- m 1))) (= y 1))
	0 ;; non-trivial root!
	y))

  (cond ((= exp 0) 1)
	((even? exp) (squaremod-check (expmod base (/ exp 2) m)))
	(else
	 (remainder
	  (* base (expmod base (- exp 1) m))
	  m))))


(define (fast-prime? n tries)
  ;; miller-rabin test for a random a<n
  (define (mr-test n)
    (define a (+ 1 (random (- n 1))))
    (= (expmod a n n) a))

  (cond ((= tries 0) true)
	((not (mr-test n)) false)
	(else (fast-prime? n (- tries 1)))))


(define (prime? n)
  (fast-prime? n 100))


;; carmichael numbers don't fool the test. woohoo!
(prime? 1103)
(prime? 1105)
