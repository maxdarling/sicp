;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; givens
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (prime? n)
  ;; terse naive prime algorithm
  (if (= n 1)
      #f
      (= 2
	 (length (filter (lambda (x) (= 0 (remainder n x)))
			 (enumerate-interval 1 n))))))

(define (accumulate op init seq)
  (if (null? seq)
      init
      (op (car seq)
	  (accumulate op init (cdr seq)))))

(define (enumerate-interval lo hi)
  (if (> lo hi)
      '()
      (cons lo (enumerate-interval (+ 1 lo) hi))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; solutions
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; enumerate all unique pairs (i, j) s.t. 1 <= j < i <= n
(define (unique-pairs n)
  (flatmap (lambda (i)
	     (map (lambda (j) (list j i))
		  (enumerate-interval 1 (- i 1))))
	   (enumerate-interval 1 n)))


;; find all unique pairs of positive integers less than n whose sum is prime
;; output format: (i, j, i+j)
(define (prime-sum-pairs n)
  (define (make-pair-sum pair)
    (append pair (list (+ (car pair) (cadr pair)))))
  (define (prime-sum? pair)
    (prime? (+ (car pair) (cadr pair))))

  (map make-pair-sum
       (filter prime-sum? (unique-pairs n))))

(prime-sum-pairs 10)
