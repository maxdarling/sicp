(load "generic/generic.scm")
(load "generic/polynomial.scm")
(install-polynomial-package)

(define p1 (make-polynomial 'x '((2 1) (1 -2) (0 1))))
(define p2 (make-polynomial 'x '((2 11) (0 7))))
(define p3 (make-polynomial 'x '((1 13) (0 5))))

(define q1 (mul p1 p2))
(define q2 (mul p1 p3))

(define res (greatest-common-divisor q1 q2))

q1  ;; (polynomial x (4 11) (3 -22) (2 18) (1 -14) (0 7))
q2  ;; (polynomial x (3 13) (2 -21) (1 3) (0 5))
res ;; (polynomial x (2 1458/169) (1 -2916/169) (0 1458/169))

;; commentary:
;; i'm confused. the result's coefficients are not even close to p1. I thought the authors
;; were setting up a precision issue, or something, but that's not what seems to be going on --
;; this seems more like a bug? sadly the solution is not helpful, they only justify why the
;; result has rational coefficients, not why it's so different than p1. huh. I just tried to
;; compute 'res' using a gcd calculator online and got (x-1)^2, which is p1.
;;
;; oh, after completing 2.95 it seems that the size of the coeffs were never a concern - we only
;; address that in 2.95 b in which we reduce them all down to the smallest possible.
