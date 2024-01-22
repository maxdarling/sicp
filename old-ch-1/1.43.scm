;; helper
(define (compose f g)
  (lambda (x) (f (g x))))

;; define a procedure allowing for f^n(x)
(define (repeated f n)
  ;; naive solution: linearly apply
  (define (naive)
    (if (= n 0)
	;; a func applied 0 times has no effect
	(lambda (x) x) 
	;; f^n(x) = f(f^(n-1)(x))
	(compose
	  f
	  (repeated f (- n 1)))))

  ;; logarithmic solution: f^n(x) = f^2(f^(n/2)x))
  (define (better)
    (cond ((= n 0)
	   (lambda (x) x))
	  ((even? n)
	   (repeated
	    (compose f f)
	    (/ n 2)))
	  (else
	   (compose
	    f
	    (repeated f (- n 1))))))
	   

  ;;(naive))
  (better)) 



;; helper: apply f(x) and measure time taken
(define (with-timer f x)
  (let ((start (runtime)))
    (f x)
    (display "elapsed time: ")
    (display (- (runtime) start)) (newline)))

;; test
((repeated square 2) 5) ;; 625
(with-timer (repeated (lambda (x) (+ x 1)) 100000) 1)
;; naive: 1.99e-2, better: 2e-2
;; interesting that better sol isn't faster to execute.
;; probably because we're not evaluating intermediate
;; computations, but we're just assembling nested function
;; calls. or something. not 100% sure.
