
;; return the last element of the list
(define (last-pair l) 
  (if (or (null? l) (null? (cdr l)))
      l
      (last-pair (cdr l))))


;; testing
(last-pair (list 1 2 3 4))
(last-pair '())
