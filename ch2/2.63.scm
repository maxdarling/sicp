;; # 1
(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1
		     (right-branch tree))))))


;; # 2
(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
	result-list
	(copy-to-list (left-branch tree)
		      (cons (entry tree)
			    (copy-to-list
			     (right-branch tree)
			     result-list)))))
  (copy-to-list tree '()))


;; a)
;; #2 only uses 'cons' operations (one per node) and builds up a list
;; of nodes in order from largest to smallest (rightmost to leftmost).
;;
;; #1 builds up two lists by solving the subproblem on each of the
;; right and left subtrees, and then uses an 'append' to merge the 2
;; lists together.
;;
;; I really don't think the results can be different...
;;

;; b) it depends. the big operation in #1 is 'append', and in #2 it's
;; passing the result list. a linked-list representation could mean
;; 'append' is O(1), but with a different representation could be O(n),
;; and likewise with the argument passing (by reference or by copy).



;; solutions:
;; - people justify that the results are the same in a) because they are
;; both in-order traversals. yes, can't argue with that.
;; - people are assuming 'append' is O(n) and param passing is O(1), as
;; expected, so they say #1 is slower. but it's nice to see that one
;; guy said "it depends" like me too, which is nice to see.
