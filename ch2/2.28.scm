;; return a list of the leaves of a tree, in order left-to-right
(define (fringe tree)
  ;; - all leaves of a tree = concatenation of all leaves of all subtrees of the tree
  ;; base case: empty list -> empty list
  ;; base case: leaf -> list of itself
  (cond ((null? tree) tree)
	((not (pair? tree)) (list tree))
	(else
	 ;; 	   (accumulate append '() (map iter tree))))) ;; the cleaner, bonus way
	 (append (fringe (car tree))
		 (fringe (cdr tree))))))

;; testing
(define x (list (list 1 2) (list 3 4)))
(fringe x) ;; -> (1 2 3 4)
(fringe (list x x)) ;; -> (1 2 3 4 1 2 3 4)


;; BONUS:
;; i got stuck trying to (append (map iter items)) but it didn't work because
;; (map iter items) returns a list of lists of leaves, and I couldn't figure out how to flat-map it.
;; just googled, you can do (accumulate append nil seq)

;; accumulate a list "sequence" by combining successive elements with "op", starting with "initial"
;; combined with element 1, then that with element 2, and so on.
(define (accumulate op initial sequence)
  (define (iter accum seq)
    (if (null? seq)
	accum
	(iter (op accum (car seq))
	      (cdr seq))))
  (iter initial sequence))

;; I only glanced at the signature, then implemented this nice and quick.


;; here's a recursive one (saw solutions).
;; note that this works in reverse order to the iterative approach above. this combines elements starting
;; from the initial value working backwards through the sequence.
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
	  (accumulate op initial (cdr sequence)))))
