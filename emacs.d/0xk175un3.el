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

(use-package auto-complete
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

    (setq ac-modes '(js3-mode
                     emacs-lisp-mode
                     lisp-mode
                     lisp-interaction-mode
                     slime-repl-mode
                     go-mode
                     clojure-mode
                     clojurescript-mode
                     scheme-mode
                     haskell-mode
                     python-mode
                     ruby-mode
                     enh-ruby-mode
                     ecmascript-mode
                     javascript-mode
                     js-mode
                     js2-mode
                     css-mode
                     makefile-mode))))

(use-package web-mode
  :diminish
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
  :diminish
  :config
    (global-anzu-mode)
  :bind (
    ("M-%" . anzu-query-replace)
    ("C-M-%" . anzu-query-replace-regexp)))

(use-package parinfer
  :ensure t
  :bind
  (("C-," . parinfer-toggle-mode))
  :init
  (progn
    (setq parinfer-extensions
          '(defaults       ; should be included.
            pretty-parens  ; different paren styles for different modes.
            paredit        ; Introduce some paredit commands.
            smart-tab      ; C-b & C-f jump positions and smart shift with tab & S-tab.
            smart-yank))   ; Yank behavior depend on mode.
    (add-hook 'clojure-mode-hook #'parinfer-mode)
    (add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
    (add-hook 'common-lisp-mode-hook #'parinfer-mode)
    (add-hook 'scheme-mode-hook #'parinfer-mode)
    (add-hook 'lisp-mode-hook #'parinfer-mode)))

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

(use-package anaconda-mode
  :ensure t
  :mode "//.py%"
  :init
    (progn
      (add-hook 'python-mode-hook 'anaconda-mode)
      (add-hook 'python-mode-hook 'anaconda-eldoc-mode)))

(use-package rust-mode
  :ensure t
  :mode "//.rs%")

(use-package racer
  :ensure t
  :config
    (setq racer-rust-src-path "/Users/0xk175un3/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src")
  :init
    (add-hook 'rust-mode-hood 'racer-mode)
    (add-hook 'racer-mode-hook #'eldoc-mode)
    (add-hook 'racer-mode-hook #'company-mode)
  :bind (:map rust-mode-map
          ([?\t] . company-indent-or-complete-common)))

(use-package markdown-mode
  :mode "\\.md%")

(use-package yaml-mode
  :mode "\\.yml%")

(use-package counsel
  :diminish)

(use-package ivy
  :diminish
  :bind (("C-x b" . ivy-switch-buffer))
  :config
    (setq ivy-use-virtual-buffers t)
    (setq ivy-count-format "%d/%d ")
    (setq ivy-display-style 'fancy))

(use-package swiper
  :diminish
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
  :diminish
  :bind (("C-;" . avy-goto-char)))

(use-package ace-window
  :diminish
  :bind (("M-o" . ace-window)
         ("M-p" . ace-delete-window))
  :init (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(use-package expand-region
  :diminish
  :commands er/expand-region
  :bind ("C-c i" . er/expand-region))

(use-package which-key
  :init
    (which-key-mode))

(use-package dired+
  :config
    (require 'dired+))

(use-package diminish
  :ensure t)

(use-package whitespace
  :diminish
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
  :diminish
  :config
    (global-git-gutter-mode))

(use-package projectile
  :diminish
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

(use-package doom-themes
  :init
    (load-theme 'doom-one t))
