(load "2.46.scm")

;; given
(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
	((frame-coord-map frame)
	 (start-segment segment))
	((frame-coord-map frame)
	 (end-segment segment))))
     segment-list)))


;; a)
(define (outliner frame)
  (let ((0-0 (make-vector 0 0))
	(0-1 (make-vector 0 1))
	(1-0 (make-vector 1 0))
	(1-1 (make-vector 1 1)))
    (segments->painter (list (make-segment 0-0 0-1)
			     (make-segment 0-0 1-0)
			     (make-segment 0-1 1-1)
			     (make-segment 1-0 1-1)))))



;; b)
(define (x-painter frame)
  (let ((0-0 (make-vector 0 0))
	(0-1 (make-vector 0 1))
	(1-0 (make-vector 1 0))
	(1-1 (make-vector 1 1)))
    (segments->painter (list (make-segment 0-0 1-1)
			     (make-segment 0-1 1-0)))))

;; c)
(define (diamond-painter frame)
  (let ((b (make-vector 0.5 0))
	(l (make-vector 0 0.5 ))
	(r (make-vector 1 0.5))
	(t (make-vector 0.5 1)))
    (segments->painter (list (make-segment b l)
			     (make-segment l t)
			     (make-segment t r)
			     (make-segment r b)))))


;; d)
;; I drew this on paper. the simplest imitation that I could come up with.
;; scheme:
;; - (everything is in 1/2, 1/3, or 1/6 increments)
;; - feet are at (.33, 0) and (.66, 0), connecting to torso at (.5, .33)
;; - torso goes up to (.5, .66)
;; - head is a square, bottom at (.5, .66), out to (.33, .83) and (.66, .83), and connecting at (.5, 1)
;; - arms start at torso at (.5, .5). waving arm goes to (0, .83). limp arm goes to (.66, .33)
;; 
;; I'm too lazy to write the code for this. no point unless I can render it IMO.
  



