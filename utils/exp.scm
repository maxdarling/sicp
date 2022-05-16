;; naive algorithm
(define (exp a b) 
  (if (= b 0)
      1
      (* a (exp a (- b 1)))))
