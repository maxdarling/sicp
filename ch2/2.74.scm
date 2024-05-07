;; constraints:
;; - suppose that each division’s personnel records consist of a single file, which
;; contains a set of records keyed on employees’ names. The structure of the set varies
;; from division to division
;; -  each employee’s record is itself a set (structured differently from division to
;; division) that contains information keyed under identifiers such as address and salary.

;; a)
;; get an employee's record based on the employee name from a specified personnel file.
;; file must be tagged with the division type.
;; the returned record is tagged with the division type.
;; should return nil if not found (needed in part c.)
(define (get-record employee-name file)
  (let* ((division (type-tag file))
	 (proc (get 'get-record division)))
    (attach-tag division
		(proc employee-name (contents file)))))

;; we need to know what division each file belongs to. the only way out is to assume that the
;; file is tagged with this information. we'll borrow the type-tag strategy from 2.4.2, copied
;; below. we also make sure to tag the returned value, since it's needed in part b).

;; type-tag functions from 2.4.2:
(define (attach-tag type-tag contents)
  (cons type-tag contents))
(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum: TYPE-TAG" datum)))
(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum: CONTENTS" datum)))


;; b)
;; return salary information from a given employee record from any division's personnel file.
;; record must be tagged with the division type.
(define (get-salary employee-record)
  (let* ((division (type-tag employee-record))
	 (proc (get 'get-salary division)))
    ;; no need to tag the salary, since it's just a number I assume
    (proc (contents employe-record))))


;; c)
;; search all given division's files for the given employee. return nil if employee isn't found.
(define (find-employee-record employee-name files)
  (if (null? files)
      '()
      (let* ((file (car files))
	     (record (get-record employee-name file)))
	(if (record)
	    record
	    (find-employee-record employee-name (cdr files))))))


;; d)
;; whenever Insatiable needs to add a new personnel file into the system, they need to:
;; - come up with a new unique division type symbol/tag
;; - implement all the procedures for
;; their division (in the example above, just 'get-record and 'get-salary).
;; - when providing their file to the headquarters, they must tag it with their division type.
