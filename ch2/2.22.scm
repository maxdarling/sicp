(define (square-list items)
  (define (iter things answer)
    (if (null? things)
	answer
	(iter (cdr things)
	      (cons (square (car things))
		    answer))))
  (iter items '()))


(square-list (list 1 2 3 4))
;; this returns items in reverse order because it's simply popping down one stack into a new stack.



(define (square-list items)
  (define (iter things answer)
    (if (null? things)
	answer
	(iter (cdr things)
	      (cons answer
		    (square (car things))))))
  (iter items '()))


(cdr (square-list (list 1 2 3 4)));; -> ((((() . 1) . 4) . 9) . 16)

;; this naively tries to address the above issue by swapping the order, but is also broken.
;; the list is just "backwards", in that instead of nested pairs of (data, rest-of-list), it's
;; (rest-of-list, data). but the first "data" element is still 16, i.e. it's still in reverse order.
