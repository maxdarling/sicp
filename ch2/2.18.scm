;; reverse the given list
(define (reverse items)
  (define (rev list1 list2)
    ;; car up list 2 while cdring down list 1
    (if (null? list1)
	list2
	(rev (cdr list1) (cons (car list1) list2))))
  (rev items '()))

;; testing
(reverse (list 1 2 3 4))
