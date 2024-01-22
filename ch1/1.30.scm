;; reference: recursive sum
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))

;; iterative sum
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
	result
	(iter (next a) (+ result (term a)))))
  (iter a 0))

;; TESTING
(define (identity n) n)
(define (inc n) (+ n 1))
(define (cube n) (* n n n))

(sum cube 1 inc 10) ;; -> 3025
(sum identity 1 inc 10) ;; -> 55
