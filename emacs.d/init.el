(require 'package)
(setq package-enable-at-startup nil)
;;(add-to-list 'package-archives
;;     '("melpa" . "http://melpa.org/packages/"))
;;(add-to-list 'package-archives
;;     '("melpa2" . "http://www.mirrorservice.org/sites/melpa.org/packages/"))
(add-to-list 'package-archives
     '("melpa3" . "http://www.mirrorservice.org/sites/stable.melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

(org-babel-load-file (expand-file-name "~/.emacs.d/0xk175un3.org"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-frontends
   (quote
    (company-pseudo-tooltip-frontend company-echo-metadata-frontend)) t)
 '(company-idle-delay 0.2 t)
 '(company-minimum-prefix-length 1 t)
 '(company-require-match nil t)
 '(company-tooltip-align-annotation t t)
 '(package-selected-packages (quote (lsp-ui lsp-mode exec-path-from-shell use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
