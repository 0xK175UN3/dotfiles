
(setq
  split-width-threshold nil
  inhibit-startup-screen t
  create-lockfiles nil
  make-backup-files nil
  auto-save-default nil
  line-number-mode t
  column-number-mode t
  scroll-error-top-bottom t
  show-paren-delay 0.1
  tabs-width 2
  use-package-verbose nil
  use-package-always-ensure t
  package-enable-at-startup nil
  sentence-end-double-space nil
  split-width-threshold nil
  split-height-threshold nil
  ring-bell-function 'ignore
  inhibit-startup-echo-area-message t
  frame-title-format '((:eval buffer-file-name))
  enable-local-variables :all
  mouse-1-click-follows-link t
  mouse-1-click-in-non-selected-windows t
  select-enable-clipboard t
  mouse-wheel-scroll-amount '(0.01)
  column-number-mode t
  confirm-kill-emacs (quote y-or-n-p)
  ns-use-native-fullscreen nil
  ns-pop-up-frames nil
  line-move-visual t)

(setq-default
  fill-column 70
  indent-tabs-mode nil
  truncate-lines t
  require-final-newline t
  fringe-mode '(4 . 2))

(defalias 'yes-or-no-p 'y-or-n-p)
(blink-cursor-mode 0)
(global-hl-line-mode t)
(show-paren-mode t)
(delete-selection-mode 1)
(cua-mode 1)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(set-face-attribute 'default nil
                    :family "Fira Code"
                    :height 140
                    :width 'normal)

(use-package company
  :init
    (progn
      (add-hook 'after-init-hook 'global-company-mode)))

(use-package web-mode
  :config
    (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.erb?\\'" . web-mode)))
     
(setq web-mode-enable-auto-closing t)
(setq web-mode-enable-auto-quoting t)

(use-package ruby-end
  :init
    (add-hook 'ruby-mode-hook 'ruby-end-mode t))

(use-package inf-ruby
  :init
    (add-hook 'ruby-mode-hook #'inf-ruby-minor-mode))

(use-package projectile-rails
  :config
    (projectile-rails-global-mode t))

(use-package slime
  :mode "\\.lisp%"
  :init
    (add-hook 'lisp-mode-hook 'slime-mode)
    (progn
      (setq inferior-lisp-program "/usr/local/Cellar/sbcl/1.4.1/bin/sbcl")
      (setq slime-contribs '(slime-fancy))))

(use-package markdown-mode
  :mode "\\.md%")

(use-package yaml-mode
  :mode "\\.yml%")

(use-package counsel)

(use-package ivy
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer))
  :config
    (setq ivy-use-virtual-buffers t)
    (setq ivy-count-format "%d/%d ")
    (setq ivy-display-style 'fancy))

(use-package swiper
  :bind (("\C-s" . swiper)
         ("C-c C-r" . ivy-resume)
         ("M-x" . counsel-M-x)
         ("C-c C-f" . counsel-find-file))
  :config
    (progn
      (ivy-mode 1)
      (setq ivy-use-virtual-buffers t)
      (setq ivy-display-style 'fancy)))

(use-package avy
  :bind (("C-;" . avy-goto-char)))

(use-package ace-window
  :bind (("M-o" . ace-window)
         ("M-p" . ace-delete-window))
  :init (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(use-package which-key
  :init
    (which-key-mode))

(use-package dired+
  :config
    (require 'dired+))

(use-package magit
  :bind (("C-x g" . magit-status)))

(use-package git-gutter
  :config
    (global-git-gutter-mode))

(use-package projectile
  :init
    (progn
      (projectile-global-mode)
      (setq projectile-completion-system 'ivy)))

(use-package indent-guide
  :init
  (indent-guide-global-mode))

(use-package linum
  :init
    (global-linum-mode 1)
(setq linum-format "%4d "))

(use-package zerodark-theme
  :init
    (load-theme 'zerodark t))

(use-package powerline
  :config
    (setq powerline-display-buffer-size nil)
    (setq powerline-display-mule-info nil)
    (setq powerline-display-hud nil)
    (when (display-graphic-p)
    (powerline-default-theme)
    (remove-hook 'focus-out-hook 'powerline-unset-selected-window)))

(use-package all-the-icons)
