(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.org/packages/")))

(require 'package)
(package-initialize)
(package-refresh-contents)



(setq show-paren-style 'expression)
(show-paren-mode 1)

(menu-bar-mode -1)
(tool-bar-mode -1)

(setq make-backup-files nil)
(setq auto-save-list-file-name nil)
(setq auto-save-default nil)

(require 'evil)
  (evil-mode 1)

(add-to-list 'load-path "~/.emacs.d/packages")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(load-theme 'seoul256 t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("eb07ee737bae7860ff12a4dbd2dcb9ff9712e517cfd6279fa74f04a17b6e1ba6" default)))
 '(package-selected-packages (quote (seoul256-theme evil))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
