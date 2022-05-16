(define dx 0.00001)
(define (smooth f)
  (lambda (x)
    (/
     (+ (f x) (f (- x dx)) (f (+ x dx)))
     3)))


(define (repeated f n)
  (if (< n 1)
      (lambda (x) x)
      (lambda (x) (f ((repeated f (- n 1)) x)))))


(define (n-fold-smooth f)
  ((repeated smooth n) f))

;; test
