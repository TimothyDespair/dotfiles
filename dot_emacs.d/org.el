;; Org
(use-package org
  :ensure t
  :general
  (:states 'normal
   :keymaps 'org-mode-map
   ">" 'org-shiftmetaright
   "<" 'org-shiftmetaleft
   "J" 'org-timestamp-down
   "K" 'org-timestamp-up)
  (:states 'normal
   :keymaps 'org-mode-map
   :prefix "SPC"
   "a" 'org-agenda
   "c" 'org-capture
   "t" 'org-todo
   "T t" 'org-show-todo-tree
   "T T" 'org-todo-list
   "T s" 'org-schedule
   "T d" 'org-deadline)
  (:states 'normal
   :keymaps 'org-agenda-mode-map
   "j" 'org-agenda-next-line
   "k" 'org-agenda-previous-line
   "]" 'org-agenda-next-item
   "[" 'org-agenda-previos-item
   "gf" 'org-agenda-recenter
   "gF" 'org-agenda-switch-to
   "F" 'org-agenda-follow-mode)
  :init
  (setq org-agend-files
	(append
	 (directory-files-recursively "~/University/" "\.org$"))))

(use-package calfw
  :ensure t)
