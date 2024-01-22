(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))

(test 0 (p))

;; using applicative-order evaluation, the expression '(test 0 (p))' would lead
;; to the evaluation of '0' and '(p)' first, but '(p)' evaluates to itself, so the
;; evaluation would never terminate, e.g.:
;;
;; (test 0 (p))
;;
;; (test 0 (p))
;;
;; (test 0 (p))

;; normal-order evaluation proceeds as follows:
;;
;; (test 0 (p))
;;
;; (if (= 0 0) 0 (p))
;;
;; (if #t 0 (p))
;;
;; 0
