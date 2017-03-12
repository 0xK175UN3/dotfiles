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

(use-package magit
  :ensure t
  :init
  (progn
    (bind-key "C-x g" 'magit-status)))

(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode))

(use-package ox-reveal
  :ensure ox-reveal)
  (setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
  (setq org-reveal-mathjax t)

(use-package evil
  :ensure t
  :init
  (progn
    (setq evil-default-cursor t))
  :config
  (evil-mode 1)

  (use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode))

  (use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode))

  (use-package evil-indent-textobject
  :ensure t))

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))
