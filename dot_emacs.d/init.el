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

;; Vim mode
(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1)
  (setq undo-tree-auto-save-history t))

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

;; VCS
(use-package magit
  :ensure t)

(use-package projectile
  :ensure t
  :config
  (projectile-mode 1))

(use-package neotree
  :ensure t)

;; Org
(setq org-agenda-files
  (append
    (directory-files-recursively "~/University/" "\.org$")))

(use-package calfw
  :ensure t)

(use-package calfw
  :ensure t)

;; Theme
(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox t))

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

;; Custom keybinding
(use-package general
  :ensure t
  :config
  (general-define-key
    :states '(normal visual insert emacs)
    :prefix "SPC"
    :non-normal-prefix "M-SPC"
    "TAB" '(switch-to-prev-buffer :which-key "previous buffer")
    "SPC" '(helm-M-x              :which-key "M-x")
    "pf"  '(helm-find-file        :which-key "find files")
    ;; Buffers
    "bb"  '(helm-buffers-list     :which-key "buffers list")
    ;; Window
    "wl"  '(windmove-right        :which-key "move right")
    "wh"  '(windmove-left         :which-key "move left")
    "wk"  '(windmove-up           :which-key "move up")
    "wj"  '(windmove-down         :which-key "move down")
    "w/"  '(split-window-right    :which-key "split right")
    "w-"  '(split-window-below    :which-key "split below")
    "wx"  '(delete-window         :which-key "delete window")
    ;; Others
    "at"  '(ansi-term             :which-key "open terminal")))

;; Language Support
(use-package lua-mode
  :ensure t)
(use-package company-lua
  :ensure t)
