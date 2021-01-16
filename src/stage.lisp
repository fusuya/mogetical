;;0 +yuka+ 1+wall+ 2+block+ 3+forest+ 4+mtlow+ 5+mthigh+ 6+water+ 7+fort+ 8+kaidan+ +cursor+)
(defparameter *stage1*
  (list :field '((1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
	:chest-max 2 
	:chest-init-pos  '(:xmin 1 :xmax 13 :ymin 1 :ymax 11)
	:kaidan-init-pos '(:xmin 1 :xmax 13 :ymin 1 :ymax 6)
	:player-init-pos '(:xmin 6 :xmax 8  :ymin 12 :ymax 13)
	:enemy-init-pos  '(:xmin 5 :xmax 9  :ymin 1 :ymax 4)))

(defparameter *stage2*
  (list :field '((1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 3 3 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 3 3 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 3 3 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 3 3 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
		 (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
	:chest-max 2 
	:chest-init-pos  '(:xmin 1 :xmax 10 :ymin 1 :ymax 10)
	:kaidan-init-pos '(:xmin 1 :xmax 6 :ymin 1 :ymax 6)
	:player-init-pos '(:xmin 11 :xmax 13  :ymin 11 :ymax 13)
	:enemy-init-pos  '(:xmin 1 :xmax 4  :ymin 1 :ymax 4)))



(defparameter *stage-list*
  (list *stage1* *stage2*))
