;; note: it seems to me the point of the exercise (changing the representation)
;; refers to the underlying structures operated on by the constructor and selectors.
;; however, my initial choice of 4 segments leaves only 1 way to do it. so, I'm
;; just going to do different constructors/selectors as well for my alt representation.

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Utils
;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "2.2.scm") ;; segment and point

;; x component of segment/vector
(define (seg-x s)
  (- (x-point (end-segment s))
     (x-point (start-segment s))))

;; y component of segment/vector
(define (seg-y s)
  (- (y-point (end-segment s))
     (y-point (start-segment s))))

(define (seg-len s)
  ;; pythagorean
  (sqrt (+ (square (seg-x s))
	   (square (seg-y s)))))

;; translate a point by a segment/vector
(define (shift-point p s)
  (make-point (+ (x-point p) (seg-x s))
	      (+ (y-point p) (seg-y s))))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Rectangle 1
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; make a rectangle given 4 consecutive segments for sides.
;; (e.g. a and c are opposite sides.)
(define (make-rect a b c d)
  ;; representation #1: a pair of pair of opposite sides
  (cons (cons a c)
        (cons b d)))

(define (side-a-rect r)
  (car (car r)))

(define (side-b-rect r)
  (car (cdr r)))

(define (side-c-rect r)
  (cdr (car r)))

(define (side-d-rect r)
  (cdr (cdr r)))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Rectangle 2
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; represent a rectangle as a pair of segments: the base and left side

;; input: the base segment (left to right) and a height orthogonal to the base.
(define (make-rect-2 base h)
  ;; return the base and left side
  (let ((a (x-point (start-segment base)))
	(b (y-point (start-segment base)))
	(c (x-point (end-segment base)))
	(d (x-point (end-segment base))))
    (let ((theta (atan (/ (- c a) (- d b)))))
      (cons base
	    (make-segment (make-point a b)
			  (make-point (+ a (* h (cos theta)))
				      (+ b (* h (sin theta)))))))))
	
(define (side-a-rect r)
  (car r))

(define (side-b-rect r)
  (cdr r))

(define (side-c-rect r)
  (let ((a (car r))
	(b (cdr r)))
    (make-segment (shift-point (end-segment a) b)
		  (shift-point (start-segment a) b))))
    
(define (side-d-rect r)
  (let ((a (car r))
	(b (cdr r)))
    (make-segment (shift-point (end-segment b) a)
		  (shift-point (start-segment b) a))))


;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Applications
;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (rect-perim r)
  (+ (seg-len (side-a-rect r))
     (seg-len (side-b-rect r))
     (seg-len (side-c-rect r))
     (seg-len (side-d-rect r))))

(define (rect-area r)
  (* (seg-len (side-a-rect r))
     (seg-len (side-b-rect r))))
  
;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Testing
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; rect with 3-4-5 and 5-12-13 sides
(define a (make-segment (make-point 0 0) (make-point 3 4)))
(define b (make-segment (make-point 3 4) (make-point 15 (- 1))))
(define c (make-segment (make-point 15 (- 1)) (make-point 12 (- 5))))
(define d (make-segment (make-point 12 (- 5)) (make-point 0 0)))

;; final testing: use only one of the below and eval buffer...

;; (define r1 (make-rect a b c d))
;; (rect-perim r1) ;; 36
;; (rect-area r1)  ;; 65

(define r2 (make-rect-2 a 13))
(rect-perim r2) ;; 36.0
(rect-area r2)  ;; 65.0000000000000001
