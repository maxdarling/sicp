(define (inc n) (+ n 1))
(define (cube n) (* n n n))
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))

(define (simpson f a b n)
  (define h (/ (- b a) n))
  (define (term k)
    (define y_k (f (+ a (* k h))))
    (* y_k
       (cond ((or (= k 0) (= k n)) 1)
	  ((even? k) 2)
	  (else 4))))

  (* (/ h 3.0)
     (sum term 0 inc n)))


(simpson cube 0 1 100) ;; -> 0.25
(simpson cube 0 1 1000) ;; -> 0.25

(define (cube-integral a b)
    (define (quart x) (square (square x)))
    (- (/ (quart b) 4)
       (/ (quart a) 4)))

(simpson cube 0.5035 64.50350 1000) ;; -> 0.25

(cube-integral 0.5035 64.5035)

;; it's very accurate! 
