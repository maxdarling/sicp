;; return f(g(x)) where f and g are both 1-argument functions
(define (compose f g)
  (lambda (x) (f (g x))))


((compose square inc) 6) ;; -> 49
