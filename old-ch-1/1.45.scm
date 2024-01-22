(load "utils/fixed-point.scm")
(load "utils/exp.scm")
(load "utils/repeat.scm")

;; experiment to see how many average damps it takes to
;; compute nth roots via the fixed point method

;; x = f(x) = 1/2(x + f(x))
(define (avg-damp f)
  (define (average a b) (* 1/2 (+ a b)))
  (lambda (x) (average x (f x))))

(define (n-damp f n)
  ((repeat avg-damp n) f))

(define (nth-root x n damp-amount)
  (let ((f (lambda (y)
	     (/
	      x
	      (exp y (- n 1))))))
    (fixed-point
     (n-damp f damp-amount)
     1.0)))


;; converges when?
;; |root|min damps required|
;; 1 - 0 
;; 2 - 1
;; 3 - 1
;; 4 - 2
;; 5 - 2
;; 6 - 2
;; 7 - 2
;; 8 - 3
;; ...
;; 16 - 4
;; ...
;; 32 - 5

;; conclusion: nth root takes floor(log2(n)) damps
(nth-root 625 31 4)
