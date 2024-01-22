(define (A x y)
  (cond ((= y 0) 0)
	((= x 0) (* 2 y))
	((= y 1) 2)
	(else (A (- x 1) (A x (- y 1))))))

;; (A 1 10) -> 2^10
;; (A 2 4) -> 2^16
;; (A 3 3) -> 2^16


;; for positive integer values of n: 
;; (define (f n) (A 0 n)) -> f(n) = 2n
;; (define (g n) (A 1 n)) -> g(n) = 0 for n = 0, 2^n for n > 0
;; (define (h n) (A 2 n)) -> h(n) = 0 for n = 0, 2 for n = 1, 2^(2^(2...(n times)))
;; for n > 1
