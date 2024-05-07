(define (split first second)
  (lambda (painter n)
  (if (= n 0)
      painter
      (let ((smaller ((split first second) painter (- n 1))))
	(first painter (second smaller smaller))))))

;; usage:
(define right-split (split beside below))
(define up-split (split below beside))
