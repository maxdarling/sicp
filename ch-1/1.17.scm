;; compute a * b with doubling, halving, and multiplication in O(logn) time

;; this is easy using the following rules:
;; a * b = (2 * a) * (b / 2) -- if b is even
;; a * b = a + (a) * (b - 1) --- if b is odd
;; end condition: if b is 0, result is 0. if b is 1, result is a. 
;; strategy: recursively apply these rules until b is 0. 
;; note: if b is negative, we'll use rule -a + (a) * (b + 1) in order to get b to 0.

(define (fast-mult a b)
  (define (even? x)
    (= (remainder x 2) 0))
  (cond ((= b 0) 0)
	((= b 1) a)
	((even? b) (fast-mult (* a 2) (/ b 2) ))
	((< b 0) (+ (- a) (fast-mult a (+ b 1))))
	(else (+ a (fast-mult a (- b 1))))))

	  
