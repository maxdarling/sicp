(define (even? n) (= 0 (remainder n 2)))
(define (double n) (* 2 n))
(define (halve n) (/ n 2))

;; iterative integer multiplication
(define (mult a b )
  (define (mult-iter a b c)
    ;; invariant: a*b + c. 
    ;; rules:
    ;; - if b is even: a*b + c -> (2a)(b/2) + c
    ;; - if b is odd:  a*b + c -> a*(b-1) + (c+a)
    ;; idea: c=0 to start. when b=0, c will be equal to the original a*b.
    (cond ((= b 0) c)
	  ((even? b) (mult-iter (double a) (halve b) c))
	  (else (mult-iter a (- b 1) (+ c a)))))
