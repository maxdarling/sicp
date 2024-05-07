;; encoding a symbol:
;; (assume the tree is "line-like", as in 2.71)
;; you walk the tree, which has n nodes. 
;; - each traversal involves O(n) to lookup the symbol in the sets of the 
;; left/right subtrees (these sets shrink at worst n, n-1, ..., 2, 1 per each iteration)
;; - least-frequent symbols: you traverse O(n) nodes. O(n) iterations * O(n) work per iteration = O(n^2)
;; - most-frequent symbols: you traverse O(1) nodes. same work per iteration as above. so O(n).
