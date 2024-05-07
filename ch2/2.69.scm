(load "2.67.scm")

;; given
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))


;; create a single huffman tree from a list of huffman nodes ("trees") sorted in increasing order by weight
(define (successive-merge nodes)
  ;; algorithm:
  ;; - if we have just 1 node, done
  ;; - else, take first 2 nodes (smallest)
  ;; - merge them into a new node and insert in correct position in list based on weight
  ;; - repeat
  (if (= 1 (length nodes))
      (car nodes)
      (let ((node1 (car nodes))
	    (node2 (cadr nodes))
	    (rest (cddr nodes)))
	(let ((new-set (adjoin-set (make-code-tree node1 node2)
				   rest)))
	  (successive-merge new-set)))))
