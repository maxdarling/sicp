;; there are two loops: over the result of the subproblem on k-1, and over rows.
;;
;; the optimal solution computes the k-1 subpromblem once (it's the outer loop), and over each of these
;; subproblem solutions we map over the rows (inner loop).
;;
;; the second solution flips the order. the inner computation (adjoining a new row to a subproblem
;; solution) is the same. however, the k-1 subproblem is computed for each new row, versus the other
;; way around where a new row is computed for each k-1 subproblem solution. the k-1 subproblem is
;; MUCH more costly to compute than to generate rows (which is linear, it's the enumerate-interval
;; procedure). another way to phrase it is: we've turned a linear recursion into a tree recursion.
;;
;; let's analyze the difference.
;; givens:
;; - optimal solution solves the k problem in time T.
;;
;; analysis:
;; - the fundamental work (innermost computation) in each solution is the same
;; - new solution repeats the work T n-times at each level of the recursion. over a recursion depth of n,
;;   this is n^n.
;; - therefore, it's rougly n^n * T work
