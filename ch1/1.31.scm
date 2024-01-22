(define (inc n) (+ n 1)) 
(define (identity n) n)

(define (product term a next b)
  (if (> a b)
      1
      (* (term a) (product term (next a) next b))))

(define (product term a next b)
  (define (product-iter a product)
    (if (> a b)
	product
	(product-iter (next a) (* product (term a)))))
  (product-iter a 1))

(define (factorial n)
  (product identity 1 inc n))

;; approximate pi up to n, using the formula:
;; π/4 = (2 * 4 * 4 * 6 * 6 * 8 ... * n) /
;;       (3 * 3 * 5 * 5 * 7 * 7 ... * n-1)
(define (pi-approx n)
  (define (term i) ;; 1-indexed
    (/ (* 2 (+ 1 (quotient i 2)))
       (+ 3 (* 2 (quotient (- i 1) 2)))))

  (* 4.0 (product term 1 inc n)))

;; TESTING
(factorial 5) ;; -> 5!
(factorial 6) ;; -> 6!

(pi-approx 1000)  ;; -> 3.143
(pi-approx 10000) ;; -> 3.1417


