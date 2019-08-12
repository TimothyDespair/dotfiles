;; Org
(use-package org
  :ensure t
  :general
  (:states 'normal
   :prefix "SPC"
   "a"  '(org-agenda           :which-key "Agenda Prompt"))
  (:states 'normal
   :keymaps 'org-mode-map
   ">"  '(org-shiftmetaright   :which-key "Demote Heading")
   "<"  '(org-shiftmetaleft    :which-key "Promote Heading")
   "J"  '(org-timestamp-down   :which-key "Shift Time Down")
   "K"  '(org-timestamp-up     :which-key "Shift Time Up"))
  (:states 'normal
   :keymaps 'org-mode-map
   :prefix "SPC"
   "c"  '(org-capture          :which-key "Org Capture")
   "t"  '(org-todo             :which-key "Toggle TODO")
   "T"  '(:which-key "TODOs")
   "Tt" '(org-show-todo-tree   :which-key "Show TODOs in File")
   "TT" '(org-todo-list        :which-key "Show TODO List")
   "Ts" '(org-schedule         :which-key "Schedule TODO")
   "Td" '(org-deadline         :which-key "Set TODO Deadline")
   "#"  '(org-set-tags-command :which-key "Set Org Tags"))
  (:states 'normal
   :keymaps 'org-agenda-mode-map
   "j"  'org-agenda-next-line
   "k"  'org-agenda-previous-line
   "]"  'org-agenda-next-item
   "["  'org-agenda-previos-item
   "gf" 'org-agenda-recenter
   "gF" 'org-agenda-switch-to
   "F"  'org-agenda-follow-mode)
  :init
  (setq org-agenda-files
      (append
       (directory-files-recursively "~/University/" "\.org$"))))

(use-package calfw
  :ensure t)
