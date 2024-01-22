(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;; combinations whose operators are compound expressions are allowed.
;; in the above, the operator is the result of the "if" expression, either '-' or '+'
;; depending on 'b'. when 'b' is positive, the overall expression is '(+ a b)' and
;; '(- a b)' when b is negative.
