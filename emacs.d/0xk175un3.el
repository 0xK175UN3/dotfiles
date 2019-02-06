(setq user-full-name "Artemiy Stepanov"
      user-mail-address "")

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
  confirm-kill-emacs (quote y-or-n-p)
  ns-use-native-fullscreen nil
  ns-pop-up-frames nil
  line-move-visual t)

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

(setq-default
  fill-column 70
  indent-tabs-mode nil
  truncate-lines t
  require-final-newline t
  eldoc-documentation-function #'ignore
  fringe-mode '(4 . 2))

(defalias 'yes-or-no-p 'y-or-n-p)
(blink-cursor-mode 0)
(global-hl-line-mode 0)
(show-paren-mode t)
(delete-selection-mode t)
(global-eldoc-mode -1)
(cua-mode t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(set-face-attribute 'default nil
                    :family "Hasklig"
                    :weight 'light
                    :height 145
                    :width 'normal)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(setq tab-always-indent 'complete)

(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns x))
  :config
    (setq exec-path-from-shell-variables '("PATH" "NVM_DIR"))
    (exec-path-from-shell-initialize))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package git-gutter
  :ensure t
  :diminish git-gutter-mode
  :config
    (global-git-gutter-mode))

(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :init
  (setq flycheck-disabled-checkers '(ruby-reek)))

(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-imenu-show-container-name nil))

(use-package company-lsp
  :ensure t
  :commands (company-lsp))

(use-package eglot
  :ensure t
  :config
  (progn
    (setq-default eglot-auto-display-help-buffer nil)
    (setq-default eglot-put-doc-in-help-buffer nil)))

(use-package company
  :ensure t
  :custom
    (company-require-match nil)
    (company-minimum-prefix-length 1)
    (company-idle-delay 0.2)
    (company-tooltip-align-annotation t)
    (company-frontends '(company-pseudo-tooltip-frontend
                               company-echo-metadata-frontend))
  :commands (company-mode global-company-mode company-complete
                          company-complete-common company-manual-begin
                          company-grab-line)
  :bind (
         :map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous))
  :hook ((prog-mode . company-mode)
         (comint-mode . company-mode)))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(use-package ag
  :ensure t)

(use-package anzu
  :ensure t
  :diminish global-anzu-mode
  :config
    (global-anzu-mode)
  :bind (
    ("M-%" . anzu-query-replace)
    ("C-M-%" . anzu-query-replace-regexp)))

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :bind-keymap (("C-c p" . projectile-command-map))
  :init
    (progn
      (projectile-mode)
      (setq projectile-completion-system 'ivy)
      (setq projectile-enable-caching nil)
      (setq projectile-verbose nil)
      (setq projectile-do-log nil)))

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
  :init
    (add-hook 'ruby-mode-hook #'flycheck-mode)
    (add-hook 'ruby-mode-hook 'eglot-ensure))

(use-package rbenv
  :ensure t
  :diminish
  :init
    (progn
      (setq rbenv-show-active-ruby-in-modeline nil)
      (setq rbenv-modeline-function 'rbenv--modeline-plain))
      (global-rbenv-mode))

(use-package ruby-end
  :ensure t
  :diminish
  :init
    (add-hook 'ruby-mode-hook 'ruby-end-mode t))

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
    (setq gofmt-command "goimports")
    (add-hook 'before-save-hook #'gofmt-before-save)
    (setq go-packages-function 'go-packages-go-list)
  :init
    (add-hook 'go-mode-hook 'flycheck-mode))

(use-package go-gopath
  :ensure t)

(use-package racket-mode
  :ensure t
  :interpreter "racket"
  :mode "\\.rkt$"
  :mode "\\.rktl$"
  :mode "\\.rktd$"
  :mode "\\.scrbl$"
  :mode "\\.plt$"
  :mode "\\.ss$"
  :mode "\\.scm$"
  :diminish)

(use-package clojure-mode
  :ensure t
  :mode "\\.clj%")

(use-package cider
  :ensure t
  :init
    (add-hook 'clojure-mode-hook 'cider-mode))

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

(use-package yaml-mode
  :ensure t
  :mode "\\.yml%")

(use-package diminish
  :ensure t)

(use-package whitespace
  :ensure t
  :diminish global-whitespace-mode
  :config
  (progn
    (setq whitespace-style '(trailing face))
    (global-whitespace-mode)))

(use-package git-gutter
  :ensure t
  :diminish git-gutter-mode
  :config
    (global-git-gutter-mode))

(use-package doom-themes
  :ensure t
  :init
    (load-theme 'doom-one-light t)
    (set-background-color "white"))

;; (use-package all-the-icons
  ;;   :ensure t)
  ;; (use-package doom-modeline
  ;;   :ensure t
  ;;   :hook (after-init . doom-modeline-mode)
  ;;   :config
  ;;     (setq doom-modeline-height 25)
  ;;     (setq doom-modeline-bar-width 2)
  ;;     (setq doom-modeline-persp-name t)
  ;;     (setq doom-modeline-buffer-file-name-style 'file-name)
  ;;     (setq doom-modeline-icon nil)
  ;;     (setq doom-modeline-major-mode-icon nil)
  ;;     (setq doom-modeline-minor-modes nil)
  ;;     (setq doom-modeline-github nil))
(setq-default mode-line-format nil)

(setq-default cursor-type 'bar)
