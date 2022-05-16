;; define a compose procedure for f(g(x))
(define (compose f g)
  (lambda (x) (f (g x))))


;; test
((compose square (lambda (x) (+ x 1))) 5) ;; 36

