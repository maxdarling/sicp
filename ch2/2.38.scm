;; givens
(define nil '())

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
	  (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
	result
	(iter (op result (car rest))
	      (cdr rest))))
  (iter initial sequence))


;; solutions
(fold-right / 1 (list 1 2 3))      ;; -> (/ 1 (/ 2 (/ 3 1))) = 3/2
(fold-left / 1 (list 1 2 3))       ;; -> (/ (/ (/ 1 1) 2) 3) = 1/6
(fold-right list nil (list 1 2 3)) ;; -> (list 1 (list 2 (list 3 '()))) = (1 (2 (3 ())))
(fold-left list nil (list 1 2 3))  ;; -> (list (list (list '() 1) 2) 3) = (((() 1) 2) 3)


;; fold-left produces expressions like: (op ...(op (op e_0 e_1) e_2)... e_n)
;; fold-right produces expressions like: (op e_1 (op e_2 (... (op e_n e_0))))

;; so for fold-left and fold-right to produce the same results...
;; - op must be commutative and associative
;;
;;... I think
