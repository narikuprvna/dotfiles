;;This is the custom emacs config, which adds features not included in the example-config from clojure-emacs.
;;info: https://github.com/clojure-emacs/example-config.git
;;anything you see below that uses require-package is downloaded automatically from Melpa and requires no manual installation of any .el files
;;----------------------------------------------------------------------------

;; Packages you want installed automatically
;;(require-package 'ido-ubiquitous)
(require-package 'rainbow-delimiters)
(require-package 'smex)
(require-package 'multiple-cursors)
(require-package 'auto-complete)

;; Set modes
(smex-initialize)
(rainbow-delimiters-mode t)
;;(ido-mode t)
;;(ido-ubiquitous-mode t)
(global-auto-complete-mode t)
(yas-global-mode t)
(show-paren-mode)
(column-number-mode)
(global-hl-line-mode)
;;(nlinum-mode)
;;(powerline-center-theme)
;;(setq powerline-default-separator 'wave)

;; Miscellaneous key bindings
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-;") 'comment-or-uncomment-region)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-c C-k") 'compile)
(global-set-key (kbd "C-.") 'other-window)
;;(global-set-key (kbd "C-x g") 'magit-status)

;; helm specific key bindings
;;(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x r b") 'helm-bookmarks)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x m") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "M-i") 'helm-swoop)

;; multiple-cursors setup and key bindings
;; (require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Swap parenthesis and brackets (US Layout)
(keyboard-translate ?\( ?\[)
(keyboard-translate ?\[ ?\()
(keyboard-translate ?\) ?\])
(keyboard-translate ?\] ?\))

;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; No need for ~ files when editing
(setq create-lockfiles nil)

;; Go straight to scratch buffer on startup
(setq inhibit-startup-message t)

;;======================================================================
;; My customizations copied from Programothesis (emailatask.com)
;; see https://github.com/scottjad/dotfiles
;;======================================================================
(defmacro bind (key fn)
  "shortcut for global-set-key"
  `(global-set-key (kbd ,key)
                   ;; handle unquoted function names and lambdas
                   ,(if (listp fn)
                        fn
                      `',fn)))

(defmacro cmd (name &rest body)
  "declare an interactive command without all the boilerplate"
  `(defun ,name ()
     ,(if (stringp (car body)) (car body))
     (interactive)
     ,@ (if (stringp (car body)) (cdr `,body) body)))

(cmd isearch-other-window
     (save-selected-window
       (other-window 1)
       (isearch-forward)))

(bind "C-M-S" isearch-other-window)

;;======================================================================
;; 21 Clojure - define-clojure-function
;; (Programothesis by emailatask.com)
;; This is a very useful function for Clojure programming
;; Example: if you have the following:
;; (defn foo [x]
;;   (bar something))
;; "C-c f" at point bar will create function definition code
(defun define-clojure-function ()
  "C-c f = template for Clojure function definition"
  (interactive)
  (let ((name (symbol-at-point)))
    (backward-paragraph)
    (insert "\n(defn " (symbol-name name) "\n [])\n")
    (backward-char 3)))

(define-key clojure-mode-map (kbd "C-c f") 'define-clojure-function)

(defun define-function ()
  "C-c e = template for elisp function definition"
  (interactive)
  (let ((name (symbol-at-point)))
    (backward-paragraph)
    (insert "\n(defun " (symbol-name name) "\n ())\n")
    (backward-char 3)))

;;(define-key clojure-mode-map (kbd "C-c e") 'define-function)

