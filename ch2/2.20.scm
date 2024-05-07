;; return items with the same parity as the first argument
(define (same-parity first . rest)
  (define (iter items)
    (if (null? items)
	'()
	(if (= (remainder first 2) (remainder (car items) 2))
	    (cons (car items) (iter (cdr items)))
	    (iter (cdr items)))))
  (cons first (iter rest)))


;; testing
(same-parity 1 2 3 4 5 6 7) ;; (1 3 5 7)


ss 
