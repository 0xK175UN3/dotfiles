
(setq user-full-name "Lain")

(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t)

(fset 'yes-or-no-p 'y-or-n-p)
(setq indo-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(prefer-coding-system 'utf-8)

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package seoul256-theme
  :ensure t
  :init (progn
          (setq seoul256-background 235)
          (load-theme 'seoul256 t)))

(use-package evil
  :ensure t
  :init (progn
    ;; if we don't have this evil overwrites the cursor color
    (setq evil-default-cursor t)
    (evil-mode 1)))
