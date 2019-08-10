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
    ("melpa"  . "http://melpa.org/packages/")))
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
  :ensure t)

;; Vim mode
(load-file "~/.emacs.d/evil.el")

;; VCS
(use-package magit
  :ensure t)

(use-package ediff
  :ensure t)

(use-package projectile
  :ensure t
  :config
  (projectile-mode 1))

;; Neotree
(load-file "~/.emacs.d/neotree.el")

;; Org
(load-file "~/.emacs.d/org.el")

;; Theme
(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox t))

(use-package rainbow-delimiters
  :ensure t)

;; Ivy
(use-package ivy
  :ensure t
  :config
  (setq ivy-use-virtual-buffers t
        ivy-count-format "%d/%d"))

;; Completion
(use-package company
  :ensure t
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
