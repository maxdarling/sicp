;; import: summation func
  (define (sum term a next b)
    (if (> a b)
	0
	(+ (term a)
	   (sum term (next a) next b))))

;; calculate the integral f(x) from a,b using simpson's rule (see book).
;; n is an even integer. higher n => more accurate estimate
(define (simpson-integral f a b n)
  (define (h) (/ (- b a) n))
  (define (y k) (f (+ a (* k (h)))))
  (define (term x)
    (* (y x)
       (cond ((or (= x 0) (= x n)) 1)
	     ((even? x) 2)
	     (else 4))))
  (define (next x) (+ x 1))

  (* (/ (h) 3) (sum term 0 next n)))



;; testing:
(define (cube x) (* x x x))

(simpson-integral cube 0 1 100) ;; 1/4
(simpson-integral cube 0 1 1000) ;; 1/4

