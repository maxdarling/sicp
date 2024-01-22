(define (compose f g)
  (lambda (x) (f (g x))))

;; given a procedure f, return a procedure applying f n times, i.e. f^n
(define (repeated f n)
  (if (= n 0)
      (lambda (x) x)
      ;;(lambda (x) (f ((repeated f (- n 1)) x))))) ;; not using "compose"
      (compose f (repeated f (- n 1)))))


;; compute the smoothed f, where g(x) = (f(x - dx) + f(x) + f(x + dx))/ 3
(define (smooth f)
  (define dx 0.000001)
  (lambda (x) (/ (+ (f (- x dx)) (f x) (f (+ x dx)))
		 3)))

(define (n-fold-smooth f n)
  ((repeated smooth n) f))
