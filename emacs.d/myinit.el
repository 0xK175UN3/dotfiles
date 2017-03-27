(setq inhibit-startup-message t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)

(setq indo-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(setq make-backup-files         nil) ; Don't want any backup files
(setq auto-save-list-file-name  nil) ; Don't want any .saves files
(setq auto-save-default         nil) ; Don't want any auto saving

(use-package cider
  :ensure t
  :mode "\\.clj$"
  :init
  (add-hook 'clojure-mode-hook 'cider-jack-in))

(use-package js2-mode
  :ensure t
  :mode "\\.js$"
  :init
  (add-hook 'js-mode-hook 'j2-minor-mode))

(use-package jsx-mode
  :ensure t
  :mode "\\.jsx$")

(use-package json-mode
  :ensure t
  :mode "\\.json$")

(use-package emmet-mode
  :ensure t
  :mode "\\.html$"
  :init
  (add-hook 'html-mode-hook 'emmet-mode)
  (progn
    (setq emmet-expand-jsx-className? t)))

(use-package web-mode
  :ensure t
  :mode "\\.html$"
  :init
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-quoting t))

(use-package jedi
  :ensure t
  :mode "\\.py$"
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'jedi:ac-setup))

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)))

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

(use-package dumb-jump
  :bind 
    (("C-c o" . dumb-jump-go)
     ("C-c p" . dumb-jump-back)
     ("C-c x" . dumb-jump-go-prefer-external)
     ("C-c z" . dumb-jump-go-prefer-external-other-window))
  :ensure t
  :init
  (progn
    (dumb-jump-mode)))

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))

(use-package magit
  :ensure t)

(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode))

(use-package ox-reveal
  :ensure ox-reveal)
  (setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
  (setq org-reveal-mathjax t)

(use-package linum
  :ensure t
  :init
  (global-linum-mode 1))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package spacemacs-theme
  :ensure t
  :init
  (load-theme 'spacemacs-dark t))
