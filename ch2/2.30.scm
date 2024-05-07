(define (scale-tree items factor)
  ;; scaled tree = scaling all subtrees
  (cond ((null? items) '()) ;; case: empty tree
	((not (pair? items)) (* items factor)) ;; case: leaf
	(else (map (lambda (x) (scale-tree x factor)) items))))


;; testing
(scale-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)) 10)

;; super clean book version: just define a mapping over sublist! this also handles null implicitly
;; (map handles it!) wow! suuuuper clean.
(define (scale-tree items factor)
  (map (lambda (subtree)
	 (if (not (pair? subtree))
	     (* factor subtree)
	     (scale-tree subtree factor)))
       items))

(scale-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)) 10)


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Start of 2.30
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (square-tree items)
  (cond ((null? items) '())
	((not (pair? items)) (square items))
	(else (cons (square-tree (car items))
		    (square-tree (cdr items))))))

(define (square-tree items)
  (map (lambda (subtree)
	 (if (not (pair? subtree))
	     (square subtree)
	     (square-tree subtree)))
       items))


;; testing
(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7))) ;; -> (1 (4 (9 16) 25) (36 49))
