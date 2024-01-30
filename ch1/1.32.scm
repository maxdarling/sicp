(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
		(accumulate combiner null-value term (next a) next b))))

(define (accumulate combiner null-value term a next b)
  (define (iter a total)
    (if (> a b)
	total
	(iter (next a) (combiner total (term a)))))
  (iter a null-value))


(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))


;; TESTING
(define (identity x) x)
(define (inc x) (+ 1 x))

(sum identity 1 inc 10)

(product identity 1 inc 5)


;; what a wonderful exercise. so easy + automatic. but really nice to see the
;; pattern laid out here explicitly. the 2 character difference between sum and
;; product is nice of course. but so is the subtle difference between the iterative
;; and recursive implemenations of accumulate.
