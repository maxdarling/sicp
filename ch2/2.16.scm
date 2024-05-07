(load "2.7.scm")
(load "2.12.scm")

(define A (make-center-percent 42 0.001))
(define A/A (div-interval A A))

;; A 
(display-center-percent A)
;; [42.,1.000000000000038e-3]

;; A * (A / A)
(display-center-percent (mul-interval A A/A))
;; [42.000168000168,2.999992000024251e-3]

;; A * (A / A) * (A / A)
(display-center-percent (mul-interval A
				      (mul-interval A/A A/A)))
;; [42.000504001176,4.999960000376438e-3]

;; A * (A / A) * (A / A) * (A / A)
(display-center-percent (mul-interval A
				      (mul-interval A/A
						    (mul-interval A/A A/A))))
;; [42.00100800436802,6.999888002128535e-3]


;; Notice how the tolerance increases after each successive multiplication!

;; This illustrates the main issue, I think. In the abstract world of interval
;; arithmetic, (A / A) terms should reduce to the one interval [1, 1] and have
;; no impact when multiplied to an interval. But, as shown above, in our computational
;; model this is not the case: every time we tack on a * (A / A) the tolerance 
;; increases. This is because (A / A) evaluates to 
;;
;;     [1.0000000200000003,1.9999999800004474e-4]
;;
;; currently on my system. A long way off of [1, 1]!
;;
;; If we wanted to solve this particular case, we could modify div-interval
;; to check for divisions of x/x and return [1, 1].
;;
;; But that's not enough. What about
;;
;;    (A * A * A * A) / (A * A * A) = A
;;
;; or 
;;
;;    (A * X) / A = X
;;
;; or, repeatedly applying the above
;;
;;    (A * (A * (A * (...) / A ) / A) / A) = (...)
;;
;; Expressions can be arbitrarily long and nested. For this, we need something
;; more powerful. We need the ability to *parse* these expressions, just as one would
;; parse a programming language like Lisp. This is a large task! (...but also one that
;; we'll be able to do, I think, by the end of the book!).



;; After looking at solutions: people taking a pretty different approach. One thing
;; I am no longer convinced about is whether A * A / A = A, haha. Some guy said
;; A * C / C != A in interval arithmetic. If that's the case then this problem is
;; pretty different.

;; Another note: just read another answer that says that interval arithmetic does not
;; have the structure of a "field" and that the fundamental issue is the "dependency"
;; problem. This is starting to make sense! E.g. why R1*R2 / (R1 + R2) is different
;; than 1 / (1/R1 + 1/R2): because the former has R1 and R2 each occurring multiple
;; times, and independently. The code we've written treats all the intervals
;; independently, that's the issue. So my solution - to write a parser and maximally
;; reduce expressions - makes sense. The only issue is: it's wrong. Because not all
;; expressions can be reduced to only 1 ocurrence of each variable. E.g. (A+B)/(A+C)
;; cannot be reduced further. So, you need other methods, and that's what people are
;; talking about at length in the solution thread with monte carlo, diff eq, etc.
