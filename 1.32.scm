;; define an accumulator that can generalize sums and products
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value ;; (e.g. 0 or 1 for sum or product)
      (combiner ;; (e.g. + or *)
       (term a)
       (accumulate combiner null-value term (next a) next b))))

(define (accumulate-iter combiner null-value term a next b)
  (define (acc-iter a result)
    (if (> a b)
	result
	(acc-iter (next a) (combiner (term a) result))))
  (acc-iter a null-value))

  


(define (product term a next b)
  (accumulate * 1 term a next b))

(define (sum term a next b)
  (accumulate + 0 term a next b))


;; helpers
(define (inc x) (+ x 1))
(define (identity x) x)

;; tests
(product identity 1 inc 5) ;; 120
(sum identity 1 inc 5) ;; 15
