(use-package neotree
  :ensure t
  :general
  (:states 'normal
   :prefix "SPC"
   "n" '(neotree-toggle :which-key "Toggle Neotree"))
  (:states 'normal
   :keymaps 'neotree-mode-map
   "RET" 'neotree-enter
   "SPC" 'neotree-quick-look
   "j" 'neotree-next-line
   "k" 'neotree-previous-line
   "H" 'neotree-hidden-file-toggle))

(use-package projectile
  :ensure t
  :config
  (projectile-mode 1)
  (setq projectile-switch0project-action 'neotree-projectile-action))

(use-package perspective
  :ensure t
  :init
  (persp-mode 1)
  :config
  (defun my/persp-neo ()
    "Make NeoTree follow the perspective"
    (interactive)
    (let ((cw (selected-window))
	  (path (buffer-file-name)))
      (progn
	(when (and (fboundp 'projectile-project-p)
		   (projectile-project-p)
		   (fboundp 'projectile-project-root))
	  (neotree-dir (projectile-project-root)))
	(neotree-find path))
      (select-window cw)))
  :hook
  (persp-switch . my/persp-neo))
