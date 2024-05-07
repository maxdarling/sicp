;; return the kth from last element in a list (1-indexed, e.g. 1th from last is last)
(define (kth-from-last-elem items k)
  ;; strategy: return (node, dist-from-last) pair.
  ;; you reach the end of the list and start incrementing dist-from-last until you reach
  ;; k, and then you return the node
  (define (helper items)
    (if (null? items)
	(cons 0 '())
	(let ((data (helper (cdr items))))
	  (if (= k (+ 1 (car data)))
	      (cons k items) ;; return case
	      (cons (+ 1 (car data)) (cdr data))))))
  (cdr (helper items)))


;; testing
(kth-from-last-elem (list 1 2 3 4 5) 2)
(kth-from-last-elem (list 1 2 3 4 5) 1)
;; (kth-from-last-elem (list 1 2 3 4 5) 4)


	      


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; filter function
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; i decided i wanna implement before peeking at how the book does it. tee hee.

;; return items from sequence only for which the predicate passes
(define (filter pred sequence)
  ;; (define (iter result seq)
  ;;   (cond ((null? seq) result)
  ;; 	  ((not (pred (car seq))) (iter result (cdr seq)))
  ;; 	  (else                   (iter (cons (car seq) result) (cdr seq)))))
  ;; (iter '() sequence))
  (cond ((null? sequence) '())
	((not (pred (car sequence))) (filter pred (cdr sequence)))
	(else (cons (car sequence) (filter pred (cdr sequence))))))


(filter (lambda (x) (even? x)) (list 1 2 3 4 5 6))
