(define (equal? list1 list2)
  (cond ((or (null? list1) (null? list2)) (eq? list1 list2))
	((or (not (list? list1)) (not (list? list2))) (eq? list1 list2))
	(else (and (eq? (car list1) (car list2))
		   (equal? (cdr list1) (cdr list2))))))


;; alternative. makes use of the fact that '() is not a pair. so pair? handles non-lists and empty lists.
(define (equal? list1 list2)
  (cond ((and (not (pair? list1)) (not (pair? list2))) (eq? list1 list2))
	((and (pair? list1) (pair? list2))
	 (and (eq? (car list1) (car list2)) (equal? (cdr list1) (cdr list2))))
	(else #f)))


;; testing
(equal? '(this is a list) '(this is a list)) ;; -> #t
(equal? '(this is a list) '(this (is a) list)) ;; -> #f
