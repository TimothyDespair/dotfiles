(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1)
  (setq undo-tree-auto-save-history 1))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-easymotion
  :ensure t
  :config
  (evilem-default-keybindings "M"))

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
 
(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))
