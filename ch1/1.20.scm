(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))


;; (gcd 206 40)

;; normal order: 1 + 2 + 4 + 7 + 4 = 18 remainder operations performed
;; (14 for evaluating condition (= b 0) and 4 to finally evaluate 'a'.
;;
;; (gcd 206 40)
;; (gcd 40 (r 206 40))
;; (gcd (r 206 40) (r 40 (r 206 40)))                            | (+1)
;; (gcd (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40))))      | (+2)
;; (gcd (r (r 206 40) (r 40 (r 206 40)))                         | (+4)
;;      (r (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40)))))  | (+7 + 4)
;; = (gcd 2 0)
;; = 2

;; applicative-order: 4 remainder operations performed
;;
;; (gcd 206 40)
;; (gcd 40 (r 206 40))
;; (gcd 40 6)
;; (gcd 6 (r 40 6))
;; (gcd 6 4)
;; (gcd 4 (r 6 4))
;; (gcd 4 2)
;; (gcd 2 (r 4 2))
;; (gcd 2 0)
;; 2


