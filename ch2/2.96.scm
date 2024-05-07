(load "generic/generic.scm")
(load "generic/polynomial.scm") ;; <- modifications for part a) and b) in here
(install-polynomial-package)

(define p1 (make-polynomial 'x '((2 1) (1 -2) (0 1))))
(define p2 (make-polynomial 'x '((2 11) (0 7))))
(define p3 (make-polynomial 'x '((1 13) (0 5))))

(define q1 (mul p1 p2))
(define q2 (mul p1 p3))

(define res (greatest-common-divisor q1 q2))

;; res in 2.94: (polynomial x (2 1458/169) (1 -2916/169) (0 1458/169))

;; a)
res ;; (polynomial x (2 1458) (1 -2916) (0 1458))

;; b)
res ;; (polynomial x (2 1) (1 -2) (0 1))

