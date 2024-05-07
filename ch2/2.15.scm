;; yes, par2 does not repeat any interval variables, and is in fact more accurate
;; than par1, which does repeat interval variables.

;; My guess is that par1 has a tighter bound because it does fewer non-trivial
;; operations. Trivial meaning an operation on the [1,1] interval. par1 only does
;; one of these: 1/R1 + 1/R2. Whereas par2 does 3 non-trivial operations.

;; Trivial operations on [1,1],  will not affect the tolerance of intervals they're
;; combined with. Addition just shifts, and multiplication yields the identity.
;; Division I couldn't quickly convince myself so I tested it (see 2.14.scm).
