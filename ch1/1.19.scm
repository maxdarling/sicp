;; T_{p,q}(T_{p,q}(a,b)) = T_{p',q'}(a,b)
;; solve for p' and q' by applying T_{p,q} twice and doing some simple expanding
;; and rearranging.
;;
;; here's how to solve for b:
;; - given: a' = bq + aq + ap, b' = bp + aq
;; - expand: b' <- b'p + a'q = p(bp + aq) + q(bq + aq + ap) = ...<basic expanding>...
;;           = b(p^2 + q^2) + a(2pq + q^2)
;;           = bp' + aq'
;;
;; this works out for a as well.


;; what a cool problem!!!


(define (fib n)
  (fib-iter 1 0 0 1 n))
(define (fib-iter a b p q count)
  (cond ((= count 0) b)
	((even? count)
	 (fib-iter a
		   b
		   (+ (* p p) (* q q))
		   (+ (* 2 p q) (* q q))
		   (/ count 2)))
	(else (fib-iter (+ (* b q) (* a q) (* a p))
			(+ (* b p) (* a q))
			p
			q
			(- count 1)))))
