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
  use-package-always-ensure t
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
                    :height 140
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

(use-package auto-complete
  :diminish auto-complete-mode
  :commands auto-complete-mode
  :init
  (progn
    (auto-complete-mode t))
  :config
  (progn
    (use-package auto-complete-config)

    (ac-set-trigger-key "TAB")
    (ac-config-default)

    (setq ac-delay 0.02)
    (setq ac-use-menu-map t)
    (setq ac-menu-height 50)
    (setq ac-use-quick-help nil)
    (setq ac-ignore-case nil)
    (setq ac-fuzzy-enable t)

    (use-package ac-dabbrev
      :config
      (progn
        (add-to-list 'ac-sources 'ac-source-dabbrev)))

    (setq ac-modes '(emacs-lisp-mode
                     lisp-mode
                     lisp-interaction-mode
                     slime-repl-mode
                     clojure-mode
                     clojurescript-mode
                     scheme-mode
                     haskell-mode
                     elm-mode
                     ruby-mode
                     enh-ruby-mode
                     ecmascript-mode
                     javascript-mode
                     js-mode
                     js2-mode
                     js3-mode
                     css-mode
                     makefile-mode))))

(use-package web-mode
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
  :diminish global-anzu-mode
  :config
    (global-anzu-mode)
  :bind (
    ("M-%" . anzu-query-replace)
    ("C-M-%" . anzu-query-replace-regexp)))

(use-package aggressive-indent
  :init
    (progn
      (add-hook 'ruby-mode-hook       #'aggressive-indent-mode)
      (add-hook 'haskell-mode-hook    #'aggressive-indent-mode)
      (add-hook 'elm-mode-hook        #'aggressive-indent-mode)
      (add-hook 'clojure-mode-hook    #'aggressive-indent-mode)
      (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
      (add-hook 'css-mode-hook        #'aggressive-indent-mode)))

(use-package ruby-mode
  :config
    (setq ruby-insert-encoding-magic-comment nil))

(use-package rbenv
  :init
    (global-rbenv-mode))

(use-package ruby-end
  :diminish
  :init
    (add-hook 'ruby-mode-hook 'ruby-end-mode t))

(use-package inf-ruby
  :diminish
  :init
    (add-hook 'ruby-mode-hook #'inf-ruby-minor-mode))

(use-package projectile-rails
  :diminish
  :config
    (projectile-rails-global-mode t))

(use-package haskell-mode
  :mode "\\.hs%")

(use-package intero
  :init
  (add-hook 'haskell-mode-hook 'intero-mode))

(use-package elm-mode
  :mode "\\.elm%"
  :init
  (add-hook 'elm-mode-hook
    (lambda ()
      (set (make-local-variable 'eldoc-documentation-function)
        'elm-oracle-type-at-point))))

(use-package slime
  :mode "\\.lisp%"
  :init
    (add-hook 'lisp-mode-hook 'slime-mode)
    (progn
      (setq inferior-lisp-program "/usr/local/bin/sbcl")
      (setq slime-contribs '(slime-fancy))))

(use-package clojure-mode
  :ensure t
  :mode "\\.clj%")

(use-package cider
  :ensure t
  :init
    (add-hook 'clojure-mode-hook 'cider-mode))

(use-package markdown-mode
  :mode "\\.md%")

(use-package yaml-mode
  :mode "\\.yml%")

(use-package slim-mode
  :mode "\\.slim%")

(use-package counsel
  :diminish counsel-mode)

(use-package ivy
  :diminish ivy-mode
  :bind (("C-x b" . ivy-switch-buffer))
  :config
    (setq ivy-use-virtual-buffers t)
    (setq ivy-count-format "%d/%d ")
    (setq ivy-display-style 'fancy))

(use-package swiper
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
  :diminish avy-mode
  :bind (("C-;" . avy-goto-char)))

(use-package ace-window
  :diminish ace-window-mode
  :bind (("M-o" . ace-window)
         ("M-p" . ace-delete-window))
  :init (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(use-package expand-region
  :diminish
  :commands er/expand-region
  :bind ("C-c i" . er/expand-region))

(use-package which-key
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
  :diminish global-whitespace-mode
  :config
  (progn
    (setq whitespace-style '(trailing tabs tab-mark face))
    (global-whitespace-mode)))

(use-package neotree
  :diminish
  :ensure t
  :bind (("C-c f t" . neotree-toggle))
  :config (setq neo-window-width 32
                neo-create-file-auto-open t
                neo-banner-message nil
                neo-show-updir-line nil
                neo-mode-line-type 'neotree
                neo-smart-open t
                neo-dont-be-alone t
                neo-persist-show nil
                neo-show-hidden-files t
                neo-auto-indent-point t
                neo-theme (if (display-graphic-p) 'icons 'arrow)))

(use-package ox-reveal)

(setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.6.0/")
(setq org-reveal-mathjax t)

(use-package htmlize)

(use-package magit
  :bind (("C-x g" . magit-status)))

(use-package git-gutter
  :diminish git-gutter-mode
  :config
    (global-git-gutter-mode))

(use-package projectile
  :diminish projectile-mode
  :init
    (progn
      (projectile-global-mode)
      (setq projectile-completion-system 'ivy)))

(use-package indent-guide
  :diminish indent-guide-mode
  :init
  (indent-guide-global-mode))

(use-package linum
  :init
    (global-linum-mode 1)
(setq linum-format "%4d "))

(use-package doom-themes
  :init
    (load-theme 'doom-one t))
