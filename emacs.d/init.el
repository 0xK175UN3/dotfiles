(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpha" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(org-babel-load-file (expand-file-name "~./emacs.d/myinit.org")
