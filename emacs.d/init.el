(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
    '("melpa" . "http://melpa.org/packages/"))
;;(add-to-list 'package-archives
;;     '("melpa2" . "http://www.mirrorservice.org/sites/melpa.org/packages/"))
;; (add-to-list 'package-archives
;;      '("melpa3" . "http://www.mirrorservice.org/sites/stable.melpa.org/packages/"))
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
 '(ansi-color-names-vector
   ["#f0f0f0" "#e45649" "#50a14f" "#986801" "#4078f2" "#a626a4" "#0184bc" "#1b2229"])
 '(company-frontends
   (quote
    (company-pseudo-tooltip-frontend company-echo-metadata-frontend)))
 '(company-idle-delay 0.2)
 '(company-minimum-prefix-length 1)
 '(company-require-match nil)
 '(company-tooltip-align-annotation t t)
 '(custom-safe-themes
   (quote
    ("b54826e5d9978d59f9e0a169bbd4739dd927eead3ef65f56786621b53c031a7c" default)))
 '(fci-rule-color "#383a42")
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote cabal-repl))
 '(haslell-tags-on-save t)
 '(jdee-db-active-breakpoint-face-colors (cons "#f0f0f0" "#4078f2"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#f0f0f0" "#50a14f"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#f0f0f0" "#9ca0a4"))
 '(lsp-eldoc-render-all nil)
 '(package-selected-packages
   (quote
    (yasnippet neotree tabbar tabbar-mode doom-themes racket-mode ag lsp-ui lsp-mode exec-path-from-shell use-package)))
 '(vc-annotate-background "#fafafa")
 '(vc-annotate-color-map
   (list
    (cons 20 "#50a14f")
    (cons 40 "#688e35")
    (cons 60 "#807b1b")
    (cons 80 "#986801")
    (cons 100 "#ae7118")
    (cons 120 "#c37b30")
    (cons 140 "#da8548")
    (cons 160 "#c86566")
    (cons 180 "#b74585")
    (cons 200 "#a626a4")
    (cons 220 "#ba3685")
    (cons 240 "#cf4667")
    (cons 260 "#e45649")
    (cons 280 "#d2685f")
    (cons 300 "#c07b76")
    (cons 320 "#ae8d8d")
    (cons 340 "#383a42")
    (cons 360 "#383a42")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
