;; the current interface to complex numbers is:
;; - 2 constructors: make-from-real-imag, make-from-mag-ang
;; - 4 selectors: real-part, imag-part, magnitude, angle

;; the first order thing we must do is change the constructors to take generic number inputs
;; instead of integers/reals (which is currently assumed). naturally we'll also have to change
;; the selectors to return data in the right format.

;; this involves changing the 2 existing implementations for complex numbers: the rectangular
;; and polar packages. the entirety of the code for each of these use the following procedures
;; on the to-be generic inputs: +, *, sqrt, square, atan, cos, sin

;; so, the task becomes ensuring that each of these operations supports generic numbers.
;; we can swap + and * to the generic add and mul operations we made earlier. and we should
;; create new generic verions of all the other operations. (this is a large change in the system,
;; so it would make sense to group and document all of this cleary behind a package for generic
;; numbers and operations on them).

;; once we make generic versions of all the procedures, then the existing 2 implementations of
;; the complex interface will work. and then in the future, new implementations of complex numbers
;; must remember to be generic as well.


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; code
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; new generic operators
(define (square x) (mul x x)) ; redirect to the generic procedure mul 
(define (sqroot x) (apply-geneirc 'sqroot x)) 
(define (sine x) (apply-generic 'sine x)) 
(define (cosine x) (apply-generic 'cosine x)) 
(define (arctan y x) (apply-generic 'arctan y x)) 

;; <add to scheme-number package>
(put 'sqroot 'scheme-number (lambda (x) (tag (sqrt x)))) 
(put 'sine 'scheme-number (lambda (x) (tag (sin x)))) 
(put 'cosine 'scheme-number (lambda (x) (tag (cosine x)))) 
(put 'arctan '(scheme-number scheme-number) (lambda (y x) (tag (atan y x)))) 

;; <add to rational package>
(put 'sqroot 'rational (lambda (x) (make-rational (sqroot (numer x)) 
						  (sqroot (denom x))))) 
(define (rational->scheme-number x) (make-scheme-number (/ (numer x) (denom x)))) 
(put 'sine 'rational (lambda (x) (sine (rational->scheme-number x)))) 
(put 'cosine 'rational (lambda (x) (cosine (rational->scheme-number x)))) 
(put 'arctan '(rational rational) (lambda (y x) (arctan (rational->scheme-number y) 
							(rational->scheme-number x)))) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; post-solution
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; - I forgot to tag.
;; - atan takes 2 args
;; - I missed the complex-complex arithmetic operations, e.g. add-complex.
;; these will need to have their internals swapped out, too (they use the ops defined above,
;; and - and /, so it's simple).
