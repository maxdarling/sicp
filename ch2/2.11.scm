(load "2.7.scm")

(define (neg? x) (< x 0))
(define (pos? x) (>= x 0))

(define (mul-interval x y)
  ;; You have [a, b] x [c, d]
  ;; Each interval has 3 sign choices: --, -+, or ++
  ;; Thus with 2 intervals there's 9 cases:
  ;; patt |  min  |  max 
  ;; ++++ |   a c | b d 
  ;; ++-+ |   b c | b d 
  ;; ++-- |   b c | a d 
  ;; -+++ |   a d | b d 
  ;; -+-+ | ad|bc | ac|bd
  ;; -+-- |   b c | a c 
  ;; --++ |   a d | b c 
  ;; ---+ |   a d | a c 
  ;; ---- |   b d | a c 
  ;;
  ;; In 8/9 cases, you know the upper/lower bound directly, i.e. [ac, bd] for (++, ++)
  ;; Note this takes 2 multiplications, as mentioned in the problem.
  ;; There is one case (-+, -+) where you need >2 mults. 
  (let ((a (lower-bound x))
	(b (upper-bound x))
	(c (lower-bound y))
	(d (upper-bound y)))
    (cond
     ;; (??, ++)
     ((and (pos? c) (pos? d))
      (cond ((and (pos? a) (pos? b)) (make-interval (* a c) (* b d)))
	    ((and (neg? a) (neg? b)) (make-interval (* a d) (* b c)))
	    (else                    (make-interval (* a d) (* b d)))))
     ;; (??, --)
     ((and (neg? c) (neg? d))
      (cond ((and (pos? a) (pos? b)) (make-interval (* b c) (* a d)))
	    ((and (neg? a) (neg? b)) (make-interval (* b d) (* a c))) 
	    (else                    (make-interval (* b c) (* a c)))))
     ;; (??, -+)
     (else
      (cond ((and (pos? a) (pos? b)) (make-interval (* b c) (* b d)))
	    ((and (neg? a) (neg? b)) (make-interval (* a d) (* a c)))
	    (else                    (make-interval (min (* a d) (* b c))
						    (max (* a c) (* b d)))))))))


;; testing
(define a (make-interval 1 7))
(define b (make-interval (- 5) (- 3)))
(define c (mul-interval a b))
(display-interval c)


