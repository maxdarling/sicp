(define (f g) (g 2))

(f f) ;; "the object 2 is not applicable"

;; (f f) -> (f 2) -> (2 2)
