;; f (n) =
;;   n if n < 3,
;;   f (n − 1) + 2f (n − 2) + 3f (n − 3) if n ≥ 3.

(define (f n)
  (if (< n 3)
      n
      (+ (- n 1)
	 (* 2 (f (- n 2)))
	 (* 3 (f (- n 3))))))


;; idea: keep track of last 3 values for the func.
(define (g n)
  ;; invariant: for i >= 3, l1 = g(i-1), l2 = g(i-2), l3 = g(i-3)
  (define (g-iter i l1 l2 l3)
    (if (= i n)
	(+ (- n 1)
	   (* 2 l2)
	   (* 3 l3))
	(g-iter (+ i 1)
		(+
		 (- i 1)
		 (* 2 l2)
		 (* 3 l3))
		l1
		l2)))

  (if (< n 3)
      n
      (g-iter 3 2 1 0)))
  

;; attempt at further cleanup.
;; - don't recompute answer in first if clause
;; - pull n<3 cond into iter
(define (h n)
  (define (h-iter i l1 l2 l3)
    (cond
     ((< n 3) n)
     ((= i (+ n 1)) l1)
     (else (h-iter (+ i 1)
		   (+
		    (- i 1)
		    (* 2 l2)
		    (* 3 l3))
		   l1
		   l2))))

      (h-iter 3 2 1 0))
  
