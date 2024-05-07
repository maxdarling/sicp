(load "2.12.scm")

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
		(add-interval r1 r2)))
(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval
     one (add-interval (div-interval one r1)
		       (div-interval one r2)))))


;; demonstrating the that par1 and par2 behave differently:
(define x (make-center-percent 107 0.0001))
(define y (make-center-percent 5.3 0.0001))

(display-center-percent (par1 x x))
(display-center-percent (par2 x x))

(display-center-percent (par1 y y))
(display-center-percent (par2 y y))

(display-center-percent (par1 x y))
(display-center-percent (par2 x y))

;; yes, the results of par1 and par2 differ by up to 0.1
;; for all 3 cases par1 percent is 3x larger than it should be. very interesting!

;; also, notice below that dividing by 1 does not change the tolerance at all...
(define one (make-interval 1 1))
(define A (div-interval one x))
(define B (div-interval one y))
(newline)
(display-center-percent (par1 A A))
(display-center-percent (par2 A A))
       
(display-center-percent (par1 B B))
(display-center-percent (par2 B B))
       
(display-center-percent (par1 A B))
(display-center-percent (par2 A B))
