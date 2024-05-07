(load "generic/generic.scm")    ;; <- generic greatest-common-divisor defined here
(load "generic/polynomial.scm") ;; <- gcd-poly implementation in here
(install-polynomial-package)

;; test
(define p1 (make-polynomial 'x '((4 1) (3 -1) (2 -2) (1 2))))

(define p2 (make-polynomial 'x '((3 1) (1 -1))))

(greatest-common-divisor p1 p2) ;; -x^2 + x
