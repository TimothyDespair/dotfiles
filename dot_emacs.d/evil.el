(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1)
  (setq undo-tree-auto-save-history 1))

(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(use-package evil-easymotion
  :ensure t
  :config
  (evilem-default-keybindings "SPC"))

(use-package evil-snipe
  :ensure t
  :config
  (evil-snipe-mode 1))

(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode 1))

(use-package evil-goggles
  :ensure t
  :config
  (evil-goggles-mode 1))
 
