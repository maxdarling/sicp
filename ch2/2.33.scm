(define (map p sequence)
  ;; (accumulate (lambda (x y) (append (list (p x)) y)) '() sequence)) 
  ;; saw below in solutions. clear. but then again, the above is higher-level, so not all that bad I guess.
  (accumulate (lambda (x y) (cons (p x) y)) '() sequence)) 

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

;; testing
(map square (list 1 2 3))
(append (list 1) (list 2 3))
(length (list 1 2 3))
