(define zero
  (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

;; used substitution on (add-1 zero) to get the below:
(define one
  (lambda (f) (lambda (x) (f x))))

;; used substitution on (add-1 one) to get the below:
(define two
  (lambda (f) (lambda (x) (f (f x))))) 

;; this pattern continues generally. so we can directly define add.
;; I looked at solutions for this. kinda brutal, haha.
(define (add a b)
  (lambda (f)
    (lambda (x)
      ((a f) ((b f) x)))))
	    
		

;; thoughts:
;; - we think of "a" and "b" as numbers.
;; - a number x, in this paradigm, is a function that takes a function and 
;; returns a function of one arg that applies the given function x times to it's input.
;; - so, (add a b) is a number. so it will follow the above structure, i.e.
;; it will start with (lambda (f) (lambda (x) ...))
;; - ((b f) x) is exactly (f (f (f ... x))) with f applied 'b' times.
;; that's a good start!
;; - and then (a f) is (lambda (x) (f (f ... x))), i.e. a function that will
;; apply f 'a' times to an input x. so, we should just pass our ((b f) x) to that.
;; done!

;; ok, I looked up the solution. the explanation was bad. but this explanation
;; above clears things up. it's still kooky. but once I laid out what a "number" is
;; in this paradigm, the rest becomes a pretty simple mechanical process.


;; you can do this, too!
;; (b f) is the function that applies 'f' 'b' times to an argumemnt
;; (a (b f)) is the function that applies the above function 'a' times to an argument
;; and then we apply that to the arg x
(define (mult a b)
  (lambda (f)
    (lambda (x)
      ((a (b f)) x))))



;; testing
(define three (add one two))
(newline)
(display ((three inc) 0)) ;; 3x application of the inc function to 0

(define six (mult two three))
(newline)
(display ((six inc) 0)) ;; 6x application of the inc function to 0


;; very clean explanation from solutions: realize that a numeral "n" simply
;; composes a given function with itself n times.
;; you can realize this by looking at the redundancy of the initial definitions:
(define one
  (lambda (f) (lambda (x) (f x))))

;; can instead be:
(define one
  (lambda (f) f))

;; nice, right? duh!

;; you can't write two as cleanly...
(define two
  (lambda (f) (lambda (x) (f (f x)))))

;; ...except if you recall the "compose" func from earlier
(define (compose f g)
  (lambda (x) (f (g x))))

;; so then you get
(define two
  (lambda (f) (compose f f)))

;; so then thinking in terms of compose, we can now think of church-numerals
;; more simply as functions that compose their input functions 'n' times.
;; so, addition goes from this:
(define (add a b)
  (lambda (f)
    (lambda (x)
      ((a f) ((b f) x)))))

;; to this:
(define (add a b)
  (lambda (f)
    (compose (a f) (b f))))


;; meh, it's alright. I actually don't think this makes it easier for me, although
;; realizing this is an equivalent, more concice version was fun.

;; the crux was defining what these numbers actually are, in words. I.e., functions
;; that take a function and return a function that applies that function "n" times.
