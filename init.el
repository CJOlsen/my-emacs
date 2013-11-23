;; My Emacs Configuration File
;; Author: Christopher Olsen
;; Pieced together from the far corners of the earth and/or intertubes.

;; General

;enable copying to the clipboard
(setq x-select-enable-clipboard t)

; move the scroll-bar to the right
(set-scroll-bar-mode 'right)

; don't show the extra buffer on startup
(setq inhibit-startup-message t)

; show line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

; turn on visual bell (and off audio bell)
(setq visible-bell t)

; turn off top menubar and toolbar
;(menu-bar-mode -1)
(tool-bar-mode -1)

; increase font-size
(set-face-attribute 'default nil :height 105)

; increase frame size
(add-to-list 'default-frame-alist '(height . 45))

;(set-foreground-color "snow")
;(set-background-color "grey20")

; set the window title to "*file-name* at *file-path*"
(set-default 'frame-title-format (list "%b "
                                 " at "
                                 "%f"))

;; add project tree navigation
;; (add-to-list 'load-path "~/.emacs.d/emacs-nav-49")
;; (require 'nav)
;; (nav-disable-overeager-window-splitting)


; make the ansi colors softer (for when using a shell)
;(setq ansi-color-names-vector
; ["black" "red" "green" "yellow" "PaleBlue" "magenta" "cyan" "white"])

; get color themes working (currently using solarized)
(load-file "~/.emacs.d/emacs-color-theme-solarized/color-theme-solarized.el")
(load-theme 'solarized-dark t)

; a bunch of other color themes in here:
;; (require 'color-theme)
;; (color-theme-initialize)
;; (color-theme-robin-hood)

; tell emacs where the plugins are stored
(add-to-list 'load-path "~/.emacs.d/plugins")
;(require 'json-mode)
(require 'clojure-mode)
(require 'clojure-test-mode)
(require 'nrepl)
(require 'paredit)
(require 'rainbow-delimiters)
(require 'autopair)

; turn on rainbow delimiters for all programming modes
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

; turn on autopair to auto-close braces and quotes
(autopair-global-mode)

; auto-generate closing braces and quotes (doesn't enforce like paredit-mode)
; autopair has some holes, may not be worth the auto-delete function
;; (setq skeleton-pair t)
;; (global-set-key "(" 'skeleton-pair-insert-maybe)
;; (global-set-key "[" 'skeleton-pair-insert-maybe)
;; (global-set-key "{" 'skeleton-pair-insert-maybe)
;; (global-set-key "\"" 'skeleton-pair-insert-maybe)
;; (global-set-key "<" 'skeleton-pair-insert-maybe)

;; Language Specific

; Python
(setq python-shell-interpreter "/usr/bin/python2.7")

; Clojure

;; (autoload 'enable-paredit-mode "paredit"
;; "Turn on pseudo-structural editing of Lisp code."
;; t)
;; (add-hook 'clojure-mode-hook #'enable-paredit-mode)
;; (paredit-mode t)

(setq inferior-lisp-program "/usr/bin/lein repl")

(add-hook 'clojure-mode-hook
         '(lambda ()
         (define-key clojure-mode-map
         "\C-c\C-e" '(lambda ()
                         (interactive)
                         (let ((curr (point)))
                         (end-of-defun)
                         (lisp-eval-last-sexp)
                         (goto-char curr))))
         (define-key clojure-mode-map
         "\C-x\C-e" 'lisp-eval-last-sexp)
         (define-key clojure mode-map
         "\C-c\C-r" 'list-eval-region)
         (define-key 'clojure-mode-map
         "\C-c\C-c" '(lambda ()
                         (interactive)
                         (list-eval-string (buffer-string))))
         (define-key clojure-mode-map
         "\C-c\C-z" 'run-lisp)))
