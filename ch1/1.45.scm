(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (display next) (newline)
      (if (close-enough? guess next)
	  next
	  (try next))))
  (try first-guess))

(define (average-damp f) (lambda (x) (/ (+ (f x) x) 2)))

(define (repeated f n)
  (define (compose f g) (lambda (x) (f (g x))))
  (if (= n 0)
      (lambda (x) x)
      (compose f (repeated f (- n 1)))))

(define (log2 x) (/ (log x) (log 2))) 

;; calculate 1/x^n for positive n
(define (nth-root n x)
  ;; to start: 1:1 average damp and n
  ;; solution: floor(log2(n)) works too!
  (let ((f (lambda (y) (/ x (expt y (- n 1))))))
    ;;(fixed-point ((repeated average-damp (- n 1)) f)
    (fixed-point ((repeated average-damp (floor (log2 n))) f)
		 1.0)))


;; TESTING
(nth-root 2 36) ;; ~ 6
(nth-root 3 27) ;; ~3
(nth-root 4 16) ;; ~2
(nth-root 5 243) ;; ~3
(nth-root 10 1024) ;; ~2

;; so, n average-damps for the n-th root works, but the minimum is floor(log2(n)).
;; interesting!!
