(define (make-vect x y)
  (cons x y))

(define (xcor-vect v)
  (car v))

(define (ycor-vect v)
  (cdr v))

;; extensions

(define (add-vect p q)
  (make-vect (+ (xcor-vect p) (xcor-vect q))
	     (+ (ycor-vect p) (ycor-vect q))))

(define (sub-vect p q)
  (make-vect (- (xcor-vect p) (xcor-vect q))
	     (- (ycor-vect p) (ycor-vect q))))

(define (scale-vect s v)
  (make-vect (* s (xcor-vect v))
	     (* s (ycor-vect v))))
