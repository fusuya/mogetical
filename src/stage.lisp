;; +yuka+ +wall+ +block+ +forest+ +mtlow+ +mthigh+ +water+ +fort+ +kaidan+ +cursor+)
(defparameter *stage1*
  (list :field (make-array (list 15 15)
                                     :initial-contents
                                     '((1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
                                       (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
                                       (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
                                       (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
                                       (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
                                       (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
                                       (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
                                       (1 3 4 5 6 7 8 0 0 0 0 0 0 0 1)
                                       (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
                                       (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
                                       (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
                                       (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
                                       (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
                                       (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
                                       (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)))
	:player-init-pos '(:xmin 6 :xmax 8 :ymin 12 :ymax 13)
	;;'((6 12) (7 12) (8 12) (6 13) (7 13) (8 13))
	:enemy-init-pos '(:xmin 5 :xmax 9 :ymin 1 :ymax 4)))
	;;'((6 1) (7 1) (8 1) (6 2) (7 2) (8 2))))



(defparameter *stage-list*
  (list *stage1*))
