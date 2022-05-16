;; original sum algorithm (linear recursive process)
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
	 (sum term (next a) next b))))

;; iterative version of above
(define (iter-sum term a next b)
  (define (iter a result)
    (if (> a b) 
	result
	(iter (next a) (+ (term a) result)))) 
  (iter a 0)) 


;; helpers
(define (identity x) x)
(define (inc x) (+ x 1))

;; tests
(iter-sum identity 1 inc 10)

(sum identity 1 inc 10)
