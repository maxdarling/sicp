(define (even? n)
  (= 0 (remainder n 2)))
(define (square n)
  (* n n)) 

(define (exp b n)
  ;; invariant from book: a*b^n is constant. a starts at 1. when n=0 a will have
  ;; answer.
  (define (exp-iter a b n)
    (cond ((= n 0) a)
	  ((even? n) (exp-iter a (square b) (/ n 2)))
	  (else (exp-iter (* a b) b (- n 1)))))

  (exp-iter 1 b n))


;; pretty clever design! I took the invariant hint from the book, looked at it.
;; wrote this alg (it can really only be this, given the invariant). and it works!
;; pretty surprising at first.
;;
;; but it makes sense. the rule b^n = (b^2)^(n/2) is the big driver of optimization.
;; that's easy enough to think to propagate through an iteration. the insight
;; is that the product with a is a clean way to offload a base when you
;; have an odd exponent. cool!
