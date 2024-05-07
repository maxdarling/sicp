(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
	(let ((left-result
	       (partial-tree elts left-size)))
	  (let ((left-tree (car left-result)) (non-left-elts (cdr left-result))
		(right-size (- n (+ left-size 1))))
	    (let ((this-entry (car non-left-elts))
		  (right-result
                   (partial-tree
                    (cdr non-left-elts)
                    right-size)))
	      (let ((right-tree (car right-result))
		    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry
				 left-tree
                                 right-tree)
                      remaining-elts))))))))


;; (f '(1 3 5 7 9 11) 6)
;; left: (f '(1 3 5 7 9 11) 2) -> (1 -> 3)
;; curr:  5
;; right: (f '(7 9 11) 3)

;; (f '(1 3 5 7 9 11) 2)
;; left: (f '(1 3 5 7 9 11) 0) -> ('() '(1 3 5 7 9 11))
;; curr: 1
;; right: (f '(3 5 7 9 11) 1) -> ((T:3:():()) '(5 7 9 11))

;; (f '(3 5 7 9 11) 1)
;; left: '()
;; curr: 3
;; right: '()

;; resulting tree:
;;                       5
;;                      / \
;;                     1   9
;;                      \ / \
;;                      5 7  11
;;
;; a)
;; as given, 'partial-tree' constructs a balanced binary tree of the first n
;; list elements given. this leads to an easy recursive definition: the problem
;; on list 'e' and len 'n' equals the tree made from left subtree equal to
;; subproblem on 'e' and ~n/2, root of the next smallest unused elem, and
;; right subtree equal to the rest of unused elems and last ~n/2.
;;
;; this produces valid sorted trees due to the in-order list argument and the
;; left->node->right ordering. but why is it balanced? well:
;; - n=0 -> balanced
;; - n=1 -> balanced
;; - n=2 -> balanced
;; - n=3 -> balanced
;; - inductive case for n: a root and 2 balanced subtrees of size ~n/2 produces
;; a balanced tree.
;;
;; pretty cool! amazingly simple. it feels like there should be some more magic,
;; it feels like this is too simple and that it must not work, but...it works!
;; the inductive case is the only way I can prove it to myself.


;; b) each call does constant work and there are ϴ(n) calls since each call
;; selects an element from the list (or none, i.e. leaf subtrees), so the
;; time complexity is O(n).
