;; Minimal Ui
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)

(global-display-line-numbers-mode t)

;; Package Config
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives
  '(("org"    . "http://orgmode.org/elpa/")
    ("gnu"    . "http://elpa.gnu.org/packages/")
    ("melpa"  . "http://melpa.org/packages/")
    ("melpa-stable" . "http://stable.melpa.org/packages/")))
(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Editor Config
(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

;; Custom keybinding package
(use-package general
  :ensure t
  :config
  (general-define-key
   :states '(normal visual insert emacs)
   :prefix "SPC"
   :non-normal-prefix "M-SPC"
   "TAB"   '(switch-to-prev-buffer :which-key "Previous Buffer")
   "S-TAB" '(switch-to-next-buffer :which-key "Next Buffer")
   "SPC"   '(helm-find-file        :which-key "Find Files")
   "w"     '(:which-key "Window Actions")
   "wl"    '(windmove-right        :which-key "Move Right")
   "wk"    '(windmove-up           :which-key "Move Up")
   "wj"    '(windmove-down         :which-key "Move Down")
   "w|"    '(split-window-right    :which-key "Split Right")
   "w-"    '(split-window-below    :which-key "Split Down")
   "wx"    '(delete-window         :which-key "Delete Window")))

;; Vim mode
(load-file "~/.emacs.d/evil.el")

;; VCS
(use-package magit
  :ensure t)

(use-package ediff
  :ensure t)

;; Org
(load-file "~/.emacs.d/org.el")

;; Neotree/Projectile/Perspective
(load-file "~/.emacs.d/neotree.el")

;; Languages
(setq auto-mode-alist
      (append '(("\\.pl\\'" . prolog-mode)
		("\\.m\\'" . mercury-mode))
	      auto-mode-alist))

;; Theme
(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox t))

(use-package rainbow-delimiters
  :ensure t)

(use-package powerline
  :ensure t)
(use-package powerline-evil
  :ensure t
  :config
  (powerline-evil-vim-color-theme))

;; Ivy
(use-package ivy
  :ensure t
  :config
  (setq ivy-use-virtual-buffers t
        ivy-count-format "%d/%d"))

;; Completion
(use-package company
  :ensure t
  :general
  (:states 'normal
   :prefix "SPC"
   "c" 'company-mode)
  :hook
  (emacs-list-mode . (lambda () (add-to-list (make-local-variable 'company-bakends) '(company-elisp)))))

;; Which Key (Key hints)
(use-package which-key
  :ensure t
  :init
  (setq which-key-seperator " "
        which-key-prefix-prefix "+")
  :config
  (which-key-mode))

;; Language Support
(use-package lua-mode
  :ensure t)
(use-package company-lua
  :ensure t)
