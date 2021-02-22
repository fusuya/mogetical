(defsystem "mogetical"
  :version "1.5.0"
  :author "mogezou"
  :license ""
  :depends-on (:ftw)
  :components ((:module "src"
                :components
                ((:file "package")
		 (:file "define");;    :depends-on ("package"))
		 (:file "stage");;     :depends-on ("package"))
		 (:file "name");;      :depends-on ("package"))
		 (:file "mci");;       :depends-on ("define"))
		 (:file "save");;      :depends-on ("stage"))
		 (:file "item")
		 (:file "stage-data")
		 (:file "astar")
		 (:file "render")
		 (:file "mogetical");; :depends-on ("define"))
		
		 
		 )))
  :description "")
