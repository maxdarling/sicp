;; Implement A U B for two sets A and B
;; (assumes set is represented by a list of unique elems sorted in ascending order)
(define (union-set set1 set2)
  (cond ((null? set1) set2)
	((null? set2) set1)
	(else
	 (let ((x (car set1))
	       (y (car set2)))
	   (cond ((< x y) (cons x (union-set (cdr set1) set2)))
		 ((> x y) (cons y (union-set set1 (cdr set2))))
		 (else    (cons y (union-set (cdr set1) (cdr set2)))))))))



;; testing
(union-set (list 2 3 4 5) (list 1 3 5 7 9))
(union-set '() (list 1 2))
