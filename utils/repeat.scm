(define (repeat f n)
  (if (= n 0)
      (lambda (x) x)
      (lambda (x)
	(f ((repeat f (- n 1)) x)))))

;; test
;;((repeat (lambda (x) (+ x 1)) 5) 0)
