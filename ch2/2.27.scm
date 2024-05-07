;; helper
(define (reverse-list items)
  (define (rev-iter list1 list2)
    ;; cdr down list 1 and cons up list 2
    (if (null? list1)
	list2
	(rev-iter (cdr list1) (cons (car list1) list2))))
  (rev-iter items '()))



;; returns the list with its elements reversed and all sublists deep-reversed as well.
;; x
;; ((1 2) (3 4))
;; (reverse x)
;; ((3 4) (1 2))
;; (deep-reverse x)
;; ((4 3) (2 1))
(define (deep-reverse items)
  (if (not (pair? items))
      items
      (reverse-list (map deep-reverse items))))


;; testing
(define x (list (list 1 2) (list 3 4)))
x ;; -> ((1 2) (3 4))
(reverse x) ;; -> ((3 4) (1 2))
(deep-reverse x) ;; -> ((4 3) (2 1))


;; what a beauty! this came to me immediately but still feels quite quite elegant. illuminating.
