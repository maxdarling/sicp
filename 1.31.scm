;; create a general product procedure (like sum). a iterated up to b, w/ a 'next'
;; function to determine next a value, and a 'term' func to yield f(a).
(define (product a next b term)
  (if (> a b)
      1
      (* (term a) (product (next a) next b term))))

(define (product-iter a next b term)
  (define (prod-it a result)
    (if (> a b)
	result
	(prod-it (next a) (* (term a) result))))
  (prod-it a 1))

  
;; helpers
(define (inc x) (+ x 1))
(define (identity x) x)
(define (factorial n) (product 1 inc n identity))
	
;; approx pi, where higher n => higher accuracy
;;using rule: π/4 =2·4·4·6·6·8··· / 
;;                 3·3·5·5·7·7···
;; obs: f(i) = (i + 2) / (i + 1) if i even,
;;             (i + 1) / (i + 2) if i odd
(define (pi-approx n)
  (define (f i)
    (if (even? i)
	(/ (+ i 2) (+ i 1))
	(/ (+ i 1) (+ i 2))))
  (exact->inexact (* 4 (product 1 inc n f))))


;; tests
(product 1 inc 4 identity) ;; 24

(product-iter 1 inc 4 identity) ;; 24

(factorial 5) ;; 5! = 120

(pi-approx 200) ;; ~pi
