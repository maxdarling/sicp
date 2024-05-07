;; givens
(define (element-of-set? x set)
  (cond ((null? set) false)
	((equal? x (car set)) true)
	(else (element-of-set? x (cdr set)))))

;; Implement the union-set operation for the unordered-list representation of sets.
(define (union-set set1 set2)
  (cond ((null? set1) set2)
	((null? set2) set1)
	(else
	 (if (element-of-set? (car set2) set1)
	     (union-set set1 (cdr set2))
	     (union-set (cons (car set2) set1) (cdr set2))))))



;; testing
(union-set '(1 2 3 4) '(1 5 2))
(union-set '(1 2) '())
(union-set '() '(3 4))

;; super clean solution using accumulate
(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (union set1 set2) 
  (accumulate adjoin-set set2 set1)) 
