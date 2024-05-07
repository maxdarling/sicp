(load "generic/generic.scm")
(load "generic/rational.scm") ;; <- modifications for part b) in here
(load "generic/polynomial.scm") ;; <- modifications for part a) in here
(install-rational-package)
(install-polynomial-package)

;; testing
(define p1 (make-polynomial 'x '((1 1) (0 1))))
(define p2 (make-polynomial 'x '((3 1) (0 -1))))
(define p3 (make-polynomial 'x '((1 1))))
(define p4 (make-polynomial 'x '((2 1) (0 -1))))
(define rf1 (make-rational p1 p2))
(define rf2 (make-rational p3 p4))

rf1 ;; (rational (polynomial x (1 1) (0 1)) polynomial x (3 1) (0 -1))

(add rf1 rf2) ;; (rational (polynomial x (3 1) (2 2) (1 3) (0 1)) polynomial x (4 1) (3 1) (1 -1) (0 -1))

;; it works! yay!


;; editor's note: it was so fun to test everything for 2.93-2.97! The reason I didn't do this
;; before (for ~all of section 2.4, starting from exercise ~2.73) is that the book introduces
;; the get/put procedures, which aren't builtin to MIT scheme. so I went along with it and just
;; checked my code in my head before comparing to the solutions. but then 2.93 specifically calls
;; for checking your code, and there's nothing else in the exercise but that, so I figured I'd
;; implement get/put myself, it shouldn't be that hard, but then I was missing the knowledge
;; (keyed structures, assignment) so I found an easy solution on SO. And then I got to redeem
;; myself a little bit and organize all of the generic number and arithmetic packages. Not hard,
;; but crucial to do to see how things work. (E.g. it was illuminating to figure out how to
;; load and install the number packages correctly based on the discovery that you can define
;; an install-X-package procedure that uses get/put without get/put being bound yet, which
;; means you don't need to import/load generic.scm in the X.scm file. Is this called late-binding?
;; I quickly googled and it seems scheme doesn't use "late-binding", but maybe it's called
;; something else then. lazy evaluation?). And the debugging and running of everything was a
;; blast. I hacked on a basic type system for arithmetic! Pretty sweet!
;;
;; and lesson learned: I should try to run everything!
