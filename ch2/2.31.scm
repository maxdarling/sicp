;; apply "proc" to each leaf in the tree
(define (tree-map proc tree)
  (map (lambda (subtree)
	 (if (not (pair? subtree))
	     (proc subtree)
	     (tree-map proc subtree)))
       tree))
  

;; testing
(define (square-tree tree)
  (tree-map square tree))

(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7))) ;; -> (1 (4 (9 16) 25) (36 49))
