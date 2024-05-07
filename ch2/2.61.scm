;; add element x to the set
;; (assumes set is represented by a list of unique elems sorted in ascending order)
(define (adjoin-set x set)
  (cond ((null? set) (list x))
	((= x (car set)) set)
	((< x (car set)) (cons x set))
	(else (cons (car set) (adjoin-set x (cdr set))))))


;; testing
(adjoin-set 3 '())
(adjoin-set 3 (list 1 2 4))
(adjoin-set 3 (list 1 2 3 4))
  

;; this takes on average half the operations as the unordered unique list representation of sets,
;; for the same reason as element-of-set? as described in the book: the sorting allows us to know
;; if an element is in not in the list once we encounter a greater element, and that is equally likely
;; to happen at any position in the set, which averages to the middle.
