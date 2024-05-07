(load "2.38.scm")

;; from right to left, starting with an empty list, put the current element at the end of the list.
(define (reverse sequence)
  (fold-right (lambda (elem rest) (append rest (list elem))) '() sequence))

;; start with an empty list, and for each elem left to right, put that element at the front of the list.
(define (reverse sequence)
  (fold-left (lambda (rest elem) (cons elem rest)) '() sequence))


(reverse (list 1 2 3))

;; very cool! pretty clean
