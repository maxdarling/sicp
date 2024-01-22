(define (double f)
  (lambda (x) (f (f x))))


((double inc) 1) ;; -> 3

(((double double) inc) 5) ;; -> 9
;; (double double)
;; (lambda (x) (double (double x)))
;;
;; this is 2 doublings, or 4x

(((double (double double)) inc) 5) ;; -> 21
;; (double (double double))
;; (double (lambda (x) (double (double x))))
;; (lambda (y)
;;   ((lambda (x) (double (double x))) ((lambda (x) (double (double x))) y)))
;;
;; this is 8 doublings, or 16x


