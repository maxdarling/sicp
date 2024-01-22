;; applies the passed procedure f twice
(define (double f)
  (lambda (x) (f (f x))))

;; test
(define (inc x) (+ x 1))
((double inc) 0) ;; 2

;; Q: what's the output?
;; A: wow, it grows 2^2^x-1
;; 2, 4, 16, 256. it's not hard to prove to yourself on paper
;; by doing substitutions (up to 16, that is.)
(((double double) inc) 5) ;; 9
(((double (double double)) inc) 5) ;; 21
(((double (double (double double))) inc) 0) ;; 256
