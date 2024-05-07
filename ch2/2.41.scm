(load "2.40.scm")

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; bonus!
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (enumerate-interval i j)
  (if (> i j)
      '()
      (cons i (enumerate-interval (+ 1 i) j))))

;; enumerate all unique k-tuples whose elements are distinct and in [1, n]
(define (unique-tuples k n)
  (if (= k 0)
      (list '())
      ;; recursive case: for each possible last element i, generate
      ;; all size k-1 tuples with smaller max elements and append i to each.
      (flatmap (lambda (i)
		 (map (lambda (tuple) (append tuple (list i)))
		      (unique-tuples (- k 1) (- i 1))))
	       (enumerate-interval 1 n))))

(unique-tuples 3 5)
		 

;; ;; enumerate all unique triples (i, j, k) s.t. 1 <= k < j < i <= n
;; (define (unique-triples n)
;;   (flatmap (lambda (i)
;; 	     (map (lambda (pair) (append pair (list i)))
;; 		  (unique-pairs (- i 1))))
;; 	   (enumerate-interval 1 n)))

(define (unique-triples n)
  (unique-tuples 3 n))


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; solution
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; enumerate all unique triples (i, j, k) s.t. 1 <= k < j < i <= n and (+ i j k) = s
(define (find-triple-sums n s)
  (filter (lambda (triple) (= s (accumulate + 0 triple)))
	  (unique-triples n)))
  

(find-triple-sums 5 8)


