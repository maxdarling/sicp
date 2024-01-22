(define (even? n) (= 0 (remainder n 2)))
(define (double n) (* 2 n))
(define (halve n) (/ n 2))

;; multiplies integers
(define (mult a b)
  (define (fast-mult a b)
    (cond ((= b 0) 0)
	  ((= b 1) a)
	  ((even? b) (fast-mult (double a) (halve b)))
	  (else (+ a (fast-mult a (- b 1))))))
