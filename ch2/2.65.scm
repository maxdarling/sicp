(load "2.63.scm")
(load "2.64.scm")
(define tree->list tree->list-2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Givens
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

;; (this is the code from 2.62)
(define (union-set-sorted-list set1 set2)
  (cond ((null? set1) set2)
	((null? set2) set1)
	(else
	 (let ((x (car set1))
	       (y (car set2)))
	   (cond ((< x y) (cons x (union-set-sorted-list (cdr set1) set2)))
		 ((> x y) (cons y (union-set-sorted-list set1 (cdr set2))))
		 (else    (cons y (union-set-sorted-list (cdr set1) (cdr set2)))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Solution
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; A U B, given a tree representation of sets. ϴ(n) time.
;; (should use list->tree and tree->list from 2.63 and 2.64)
(define (union-set set1 set2)
  ;; strategy: simply "serialize" each tree into a sorted list,
  ;; form the union, and turn the result back into a tree
  (let ((list1 (tree->list set1))
	(list2 (tree->list set2)))
    (list->tree (union-set-sorted-list list1 list2))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Testing
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define tree1 (list->tree '(1 3 5 7 9 11)))
(define tree2 (list->tree '(0 3 4 5 6 7 9)))

(union-set tree1 tree2)
(tree->list (union-set tree1 tree2))
