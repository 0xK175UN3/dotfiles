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
  use-package-verbose nil
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

(use-package company
  :diminish
  :bind (:map company-active-map
          ("M-n" . nil)
          ("M-p" . nil)
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous))
  :init
    (progn
      (add-hook 'after-init-hook 'global-company-mode)))

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

(use-package rbenv)

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

(use-package slime
  :mode "\\.lisp%"
  :init
    (add-hook 'lisp-mode-hook 'slime-mode)
    (progn
      (setq inferior-lisp-program "/usr/local/Cellar/sbcl/1.4.1/bin/sbcl")
      (setq slime-contribs '(slime-fancy))))

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

(use-package ox-reveal)

(setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
(setq org-reveal-mathjax t)

(use-package htmlize)

(use-package pandoc-mode
  :ensure t)

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

(use-package zerodark-theme
  :init
    (load-theme 'zerodark t))

(use-package powerline
    :ensure t
    :config
    (defvar mode-line-height 30 "A little bit taller, a little bit baller.")

    (defvar mode-line-bar          (eval-when-compile (pl/percent-xpm mode-line-height 100 0 100 0 3 "#909fab" nil)))
    (defvar mode-line-eldoc-bar    (eval-when-compile (pl/percent-xpm mode-line-height 100 0 100 0 3 "#B3EF00" nil)))
    (defvar mode-line-inactive-bar (eval-when-compile (pl/percent-xpm mode-line-height 100 0 100 0 3 "#9091AB" nil)))

    ;; Custom faces
    (defface mode-line-is-modified nil
      "Face for mode-line modified symbol")

    (defface mode-line-2 nil
      "The alternate color for mode-line text.")

    (defface mode-line-highlight nil
      "Face for bright segments of the mode-line.")

    (defface mode-line-count-face nil
      "Face for anzu/evil-substitute/evil-search number-of-matches display.")

    ;; Git/VCS segment faces
    (defface mode-line-vcs-info '((t (:inherit warning)))
      "")
    (defface mode-line-vcs-warning '((t (:inherit warning)))
      "")

    ;; Flycheck segment faces
    (defface doom-flycheck-error '((t (:inherit error)))
      "Face for flycheck error feedback in the modeline.")
    (defface doom-flycheck-warning '((t (:inherit warning)))
      "Face for flycheck warning feedback in the modeline.")


    (defun doom-ml-flycheck-count (state)
      "Return flycheck information for the given error type STATE."
      (when (flycheck-has-current-errors-p state)
        (if (eq 'running flycheck-last-status-change)
            "?"
          (cdr-safe (assq state (flycheck-count-errors flycheck-current-errors))))))

    (defun doom-fix-unicode (font &rest chars)
      "Display certain unicode characters in a specific font.
  e.g. (doom-fix-unicode \"DejaVu Sans\" ?⚠ ?★ ?λ)"
      (declare (indent 1))
      (mapc (lambda (x) (set-fontset-font
                    t (cons x x)
                    (cond ((fontp font)
                           font)
                          ((listp font)
                           (font-spec :family (car font) :size (nth 1 font)))
                          ((stringp font)
                           (font-spec :family font))
                          (t (error "FONT is an invalid type: %s" font)))))
            chars))

    ;; Make certain unicode glyphs bigger for the mode-line.
    ;; FIXME Replace with all-the-icons?
    (doom-fix-unicode '("DejaVu Sans Mono" 15) ?✱) ;; modified symbol
    (let ((font "DejaVu Sans Mono for Powerline")) ;;
      (doom-fix-unicode (list font 12) ?)  ;; git symbol
      (doom-fix-unicode (list font 16) ?∄)  ;; non-existent-file symbol
      (doom-fix-unicode (list font 15) ?)) ;; read-only symbol

    ;; So the mode-line can keep track of "the current window"
    (defvar mode-line-selected-window nil)
    (defun doom|set-selected-window (&rest _)
      (let ((window (frame-selected-window)))
        (when (and (windowp window)
                   (not (minibuffer-window-active-p window)))
          (setq mode-line-selected-window window))))
    (add-hook 'window-configuration-change-hook #'doom|set-selected-window)
    (add-hook 'focus-in-hook #'doom|set-selected-window)
    (advice-add 'select-window :after 'doom|set-selected-window)
    (advice-add 'select-frame  :after 'doom|set-selected-window)

    (defun doom/project-root (&optional strict-p)
      "Get the path to the root of your project."
      (let (projectile-require-project-root strict-p)
        (projectile-project-root)))

    (defun *buffer-path ()
      "Displays the buffer's full path relative to the project root (includes the
  project root). Excludes the file basename. See `*buffer-name' for that."
      (when buffer-file-name
        (propertize
         (f-dirname
          (let ((buffer-path (file-relative-name buffer-file-name (doom/project-root)))
                (max-length (truncate (/ (window-body-width) 1.75))))
            (concat (projectile-project-name) "/"
                    (if (> (length buffer-path) max-length)
                        (let ((path (reverse (split-string buffer-path "/" t)))
                              (output ""))
                          (when (and path (equal "" (car path)))
                            (setq path (cdr path)))
                          (while (and path (<= (length output) (- max-length 4)))
                            (setq output (concat (car path) "/" output))
                            (setq path (cdr path)))
                          (when path
                            (setq output (concat "../" output)))
                          (when (string-suffix-p "/" output)
                            (setq output (substring output 0 -1)))
                          output)
                      buffer-path))))
         'face (if active 'mode-line-2))))

    (defun *buffer-name ()
      "The buffer's base name or id."
      ;; FIXME Don't show uniquify tags
      (s-trim-left (format-mode-line "%b")))

    (defun *buffer-pwd ()
      "Displays `default-directory', for special buffers like the scratch buffer."
      (propertize
       (concat "[" (abbreviate-file-name default-directory) "]")
       'face 'mode-line-2))

    (defun *buffer-state ()
      "Displays symbols representing the buffer's state (non-existent/modified/read-only)"
      (when buffer-file-name
        (propertize
         (concat (if (not (file-exists-p buffer-file-name))
                     "∄"
                   (if (buffer-modified-p) "✱"))
                 (if buffer-read-only ""))
         'face 'mode-line-is-modified)))

    (defun *buffer-encoding-abbrev ()
      "The line ending convention used in the buffer."
      (if (memq buffer-file-coding-system '(utf-8 utf-8-unix))
          ""
        (symbol-name buffer-file-coding-system)))

    (defun *major-mode ()
      "The major mode, including process, environment and text-scale info."
      (concat (format-mode-line mode-name)
              (if (stringp mode-line-process) mode-line-process)
              (and (featurep 'face-remap)
                   (/= text-scale-mode-amount 0)
                   (format " (%+d)" text-scale-mode-amount))))

    (defun *vc ()
      "Displays the current branch, colored based on its state."
      (when vc-mode
        (let ((backend (concat " " (substring vc-mode (+ 2 (length (symbol-name (vc-backend buffer-file-name)))))))
              (face (let ((state (vc-state buffer-file-name)))
                      (cond ((memq state '(edited added))
                             'mode-line-vcs-info)
                            ((memq state '(removed needs-merge needs-update conflict removed unregistered))
                             'mode-line-vcs-warning)))))
          (if active
              (propertize backend 'face face)
            backend))))

    (defvar-local doom--flycheck-err-cache nil "")
    (defvar-local doom--flycheck-cache nil "")
    (defun *flycheck ()
      "Persistent and cached flycheck indicators in the mode-line."
      (when (and (featurep 'flycheck)
                 flycheck-mode
                 (or flycheck-current-errors
                     (eq 'running flycheck-last-status-change)))
        (or (and (or (eq doom--flycheck-err-cache doom--flycheck-cache)
                     (memq flycheck-last-status-change '(running not-checked)))
                 doom--flycheck-cache)
            (and (setq doom--flycheck-err-cache flycheck-current-errors)
                 (setq doom--flycheck-cache
                       (let ((fe (doom-ml-flycheck-count 'error))
                             (fw (doom-ml-flycheck-count 'warning)))
                         (concat
                          (if fe (propertize (format " •%d " fe)
                                             'face (if active
                                                       'doom-flycheck-error
                                                     'mode-line)))
                          (if fw (propertize (format " •%d " fw)
                                             'face (if active
                                                       'doom-flycheck-warning
                                                     'mode-line))))))))))

    (defun *buffer-position ()
      "A more vim-like buffer position."
      (let ((start (window-start))
            (end (window-end))
            (pend (point-max)))
        (if (and (= start 1)
                 (= end pend))
            ":All"
          (cond ((= start 1) ":Top")
                ((= end pend) ":Bot")
                (t (format ":%d%%%%" (/ end 0.01 pend)))))))

    (defun my-mode-line (&optional id)
      `(:eval
        (let* ((active (eq (selected-window) mode-line-selected-window))
               (lhs (list (propertize " " 'display (if active mode-line-bar mode-line-inactive-bar))
                          (*flycheck)
                          " "
                          (*buffer-path)
                          (*buffer-name)
                          " "
                          (*buffer-state)
                          ,(if (eq id 'scratch) '(*buffer-pwd))))
               (rhs (list (*buffer-encoding-abbrev) "  "
                          (*vc)
;;                          " "
;;                          (when persp-curr persp-modestring)
                          " " (*major-mode) "  "
                          (propertize
                           (concat "(%l,%c) " (*buffer-position))
                           'face (if active 'mode-line-2))))
               (middle (propertize
                        " " 'display `((space :align-to (- (+ right right-fringe right-margin)
                                                           ,(1+ (string-width (format-mode-line rhs)))))))))
          (list lhs middle rhs))))

    (setq-default mode-line-format (my-mode-line)))
(use-package all-the-icons)
