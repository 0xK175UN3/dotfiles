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
  package-enable-at-startup nil
  sentence-end-double-space nil
  split-width-threshold nil
  split-height-threshold nil
  ring-bell-function 'ignore
  inhibit-startup-echo-area-message t
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
                    :height 150
                    :width 'normal)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))

(global-set-key (kbd "M-/") #'hippie-expand)

(global-set-key (kbd "C-x C-b") #'ibuffer)

(setq tab-always-indent 'complete)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)

(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns x))
  :config
  (setq exec-path-from-shell-variables '("PATH" "NVM_DIR"))
  (exec-path-from-shell-initialize))

(use-package web-mode
  :ensure t
  :diminish web-mode
  :config
    (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.erb?\\'" . web-mode))
  :init
    (progn
      (setq web-mode-enable-auto-closing t)
      (setq web-mode-enable-auto-quoting t)
      (setq web-mode-markup-indent-offset 2)
      (setq web-mode-css-indent-offset 2)
      (setq web-mode-code-indent-offset 2)))

(use-package anzu
  :ensure t
  :diminish global-anzu-mode
  :config
    (global-anzu-mode)
  :bind (
    ("M-%" . anzu-query-replace)
    ("C-M-%" . anzu-query-replace-regexp)))

(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :init
  (setq flycheck-disabled-checkers '(ruby-reek)))

(use-package company
  :ensure t
  :diminish company-mode
  :config
    (global-company-mode))

(use-package ag
  :ensure t)

(use-package ruby-mode
  :ensure t
  :interpreter "ruby"
  :mode "\\.rb$"
  :mode "\\.rake$"
  :mode "\\.gemspec$"
  :mode "\\.\\(pry\\|irb\\)rc$"
  :mode "/\\(Gem\\|Cap\\|Vagrant\\|Rake\\|Pod\\|Puppet\\|Berks\\)file$"
  :config
    (setq ruby-insert-encoding-magic-comment nil)
    (setq ruby-deep-indent-paren t)
    (add-to-list 'company-backends 'ruby-mode '(company-dabbrev-code))
  :init
    (add-hook 'ruby-mode-hook #'flycheck-mode))

(use-package rbenv
  :ensure t
  :init
    (global-rbenv-mode))

(use-package rspec-mode
  :ensure t
  :diminish)

(use-package ruby-end
  :ensure t
  :diminish
  :init
    (add-hook 'ruby-mode-hook 'ruby-end-mode t))

(use-package inf-ruby
  :ensure t
  :diminish
  :init
    (add-hook 'ruby-mode-hook #'inf-ruby-minor-mode))

(use-package projectile-rails
  :ensure t
  :diminish
  :config
    (projectile-rails-global-mode t))

(use-package go-mode
  :ensure t
  :interpreter "go"
  :mode "\\.go$"
  :config
    (add-hook 'before-save-hook #'gofmt-before-save)
    (setq go-packages-function 'go-packages-go-list)
  :init
    (add-hook 'go-mode-hook 'flycheck-mode))

(use-package go-gopath
  :ensure t)

(use-package company-go
  :ensure t
  :diminish
  :config
    (add-hook 'go-mode-hook 'company-mode)
    (add-to-list 'company-backends 'company-go))

(use-package coffee-mode
  :ensure t
  :diminish
  :init
    (progn
      (setq coffee-tabs-width 2)))

(use-package markdown-mode
  :ensure t
  :mode "\\.md%")

(use-package yaml-mode
  :ensure t
  :mode "\\.yml%")

(use-package slim-mode
  :ensure t
  :mode "\\.slim%")

(use-package ssass-mode
  :ensure t
  :mode "\\.sass%")

(use-package counsel
  :ensure t
  :diminish counsel-mode)

(use-package ivy
  :ensure t
  :diminish ivy-mode
  :bind (("C-x b" . ivy-switch-buffer))
  :config
    (setq ivy-use-virtual-buffers t)
    (setq ivy-count-format "%d/%d ")
    (setq ivy-display-style 'fancy))

(use-package swiper
  :ensure t
  :diminish ivy-mode
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
  :ensure t
  :diminish avy-mode
  :bind (("C-;" . avy-goto-char)))

(use-package ace-window
  :ensure t
  :diminish ace-window-mode
  :bind (("M-o" . ace-window)
         ("M-p" . ace-delete-window))
  :init (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(use-package expand-region
  :ensure t
  :diminish
  :commands er/expand-region
  :bind ("C-c i" . er/expand-region))

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :init
    (which-key-mode))

(use-package dash
  :ensure t)

(use-package let-alist
  :ensure t)

(use-package f
  :ensure t)

(use-package s
  :ensure t)

(use-package diminish
  :ensure t)

(use-package whitespace
  :ensure t
  :diminish global-whitespace-mode
  :config
  (progn
    (setq whitespace-style '(trailing tabs tab-mark face))
    (global-whitespace-mode)))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package git-gutter
  :ensure t
  :diminish git-gutter-mode
  :config
    (global-git-gutter-mode))

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :init
    (progn
      (projectile-mode)
      (setq projectile-completion-system 'ivy)))

(use-package indent-guide
  :ensure t
  :diminish indent-guide-mode
  :init
  (indent-guide-global-mode))

(use-package linum
  :ensure t
  :init
    (global-linum-mode 1)
(setq linum-format "%4d "))

(use-package railscasts-reloaded-theme
  :ensure t
  :init
    (load-theme 'railscasts-reloaded t))
