;; compute an infinite continued fraction via an approximation to k terms
;; n and d are procedures of 1 variable that yield the ith N and D terms.
(define (cont-frac n d k)
  ;; the cont-frac from 1 to k is (N1 / (D1 + C2,k)) where C2,k is the cont-frac
  ;; from 2 to k. And Ca,b where a>b = 0 (base case).
  (define (cf-rec n d k i)
    (if (> i k)
	0
	(/ (n i) (+ (d i) (cf-rec n d k (+ i 1))))))

  ;; iterative method: if the recursive approach is top-down, then this is bottom up.
  ;; We use the relation Ca,b = NA / (DA + Ca+1,b), just as above. The only
  ;; difference is that we start backwards by computing Cb,b then Cb-1,b, and so on.
  ;; Critically, this difference in order allows us to use a cumulative result
  ;; variable. And notice  that it's actually an invariant that for a given
  ;; cf-iter i started at K, result holds Ci+1,K. That's why when i = 0 we return
  ;; result, which holds C1,K. And, that's why you call the func like
  ;; (cf-iter n d k 0), because result must hold Ck+1,k, which is 0 (or should be,
  ;; sensically.)
  (define (cf-iter n d k result)
    (if (<= k 0)
	result
	(cf-iter n d (- k 1) (/ (n k) (+ (d k) result)))))

  (display "recursive sol: ") 
  (display (cf-rec n d k 1))
  (newline)
  (display "iterative sol: ")
  (display (cf-iter n d k 0))
  (newline))


;; tests
;; this should yield golden ratio eventually
(define N 40)
(cont-frac (lambda (x) 1.0)
	   (lambda (x) 1.0)
	   N)

