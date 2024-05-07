(load "2.8.scm")

(define (width-interval i)
  (/ (- (upper-bound i) (lower-bound i))
     2))

(define (display-width i)
  (newline)
  (display "width: ")
  (display (width-interval i)))

(define a (make-interval 1 7))
(define b (make-interval (- 3) (- 5)))
(define c (add-interval a b))

(display-interval a)
(display-width a)
(display-interval b)
(display-width b)
(display-interval c)
(display-width c)

;; lets compare the widths of individual intervals with the widths after combination
;; i.e. by addition/subtraction or multiplication/division.

;; first, we see that the width of added intervals is a function of the widths of
;; its constituent intervals (actually, they're identical)
;; we can show this algebraically:
;; - given: c = a + b, i.e. c = [lo(a) + lo(b), hi(a) + hi(b)]
;; - width(c) = 0.5*((hi(a) + hi(b)) - (lo(a) + lo(b)))
;; - width(a) = 0.5(hi(a) - lo(a))
;; - width(b) = 0.5(hi(b) - lo(b))
;; so width(c) = width(a) + width(b)

;; however, the width of multiplied intervals is not a function of the widths of
;; its constituent intervals.
;; if it were true, then intervals of lengths a and b multiplied should have the same
;; width as any other intervals of lengths a and b multiplied. but this is not so:
;;
;; [-1, 1] x [-3, 4] = [-4, 4] (widths 1, 3.5, and 4, respectively)
;;
;; [0, 2] x [-3, 4] = [-6, 8] (widths 1, 3.5, and 7, respectively)
