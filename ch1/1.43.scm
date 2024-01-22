(define (compose f g)
  (lambda (x) (f (g x))))

;; given a procedure f, return a procedure applying f n times, i.e. f^n
(define (repeated f n)
  (if (= n 0)
      (lambda (x) x)
      ;;(lambda (x) (f ((repeated f (- n 1)) x))))) ;; not using "compose"
      (compose f (repeated f (- n 1)))))

;; iterative version
(define (repeated f n)
  (define (f-iter i result)
    (if (= i n)
	result
	;;(f-iter (+ i 1) (lambda (x) (f (result x)))))) ;; not using "compose"
	(f-iter (+ i 1) (compose f result))))

  (f-iter 0 (lambda (x) x)))


;; TESTS
((repeated inc 10) 5) ;; -> 15
((repeated square 2) 3) ;; -> 81
