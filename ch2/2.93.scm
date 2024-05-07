;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; solution
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "generic/generic.scm")

(load "generic/rational.scm") ;; <- modification to use generic ops made in here
(load "generic/polynomial.scm")
(install-rational-package)
(install-polynomial-package)

(define p1 (make-polynomial 'x '((2 1) (0 1))))
(define p2 (make-polynomial 'x '((3 1) (0 1))))
(define rf (make-rational p2 p1)) ;; (x^3 + 1) / (x^2 + 1)

(add rf rf) ;; cross-multiplied! (2x^5 + 2x^3 + 2x^2 + 2) / (x^4 + 2x^2 + 1)
