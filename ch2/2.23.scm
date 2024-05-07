(define (for-each proc items)
  (map proc items)
  #t)

;; testing
(for-each (lambda (x)
(newline)
(display x))
(list 57 321 88))


(display (cons 1 (cons 2 '())))
(display (cons 1 (cons 2 (cons 3 '()))))
(display (list 1 2 3))

(display (cons (list 1 2) (list 3 4)))
