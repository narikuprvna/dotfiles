;; ---------------------------------------------------
;; Sample emacs config focusing on clojure development
;; ---------------------------------------------------
;; Time-frame: Feb 2015

;; installed packages
;; - exec-path-from-shell (not from stable!)
;; - hl-sexp
;; - paredit
;; - clojure-mode
;; - cider
;; - company
;; - clj-refactor (not from stable!)

;; Add .emacs.d to load-path
(setq dotfiles-dir (file-name-directory
                     (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path dotfiles-dir)

;; don't use tabs for indent
(setq-default indent-tabs-mode nil)

;; emacs package management
;; use MELPA stable
(require 'package)

(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(setq package-user-dir (concat user-emacs-directory "elpa"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp"))

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(setq package-enable-at-startup nil) ; Don't initialize later as well

(package-initialize)

(require-package 'epl)

(require-package 'exec-path-from-shell)
;; Sort out the $PATH for OSX
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(dolist (file '("cfg-paredit.el"
		;"cfg-hlsexp.el"
		"cfg-cider.el"
                "cfg-cljrefactor.el"))
  (load (concat dotfiles-dir file)))

;;------------------------------------------------------------------
;; Helm
(require 'helm-config)

;;------------------------------------------------------------------
;; Backup files
(setq version-control t     ;; Use version numbers for backups.
      kept-new-versions 10  ;; Number of newest versions to keep.
      kept-old-versions 0   ;; Number of oldest versions to keep.
      delete-old-versions t ;; Don't ask to delete excess backup versions.
      backup-by-copying t)  ;; Copy all files, don't rename them.

(setq vc-make-backup-files t)

;; Default and per-save backups go here:
(setq backup-directory-alist '(("" . "~/.emacs.d/backup/per-save")))

(defun force-backup-of-buffer ()
  ;; Make a special "per session" backup at the first save of each
  ;; emacs session.
  (when (not buffer-backed-up)
    ;; Override the default parameters for per-session backups.
    (let ((backup-directory-alist '(("" . "~/.emacs.d/backup/per-session")))
          (kept-new-versions 3))
      (backup-buffer)))
  ;; Make a "per save" backup on each save.  The first save results in
  ;; both a per-session and a per-save backup, to keep the numbering
  ;; of per-save backups consistent.
  (let ((buffer-backed-up nil))
    (backup-buffer)))

(add-hook 'before-save-hook  'force-backup-of-buffer)

;;------------------------------------------------------------------
;; Custom User configurations:
;; If you wish to add additional functionality to your emacs config beyond what is in this setup,
;; simply add a file called "user-customizations.el" to your .emacs.d/ directory. Within that file,
;; you have access to the (require-package ...) function defined here, so for example, you could have:
;; (require-package 'rainbow-delimiters)
;; This would be all that is needed for emacs to automatically download the Rainbow Delimiters package
;; from Melpa. Additional configs of any kind could be added to this user-customizations.el file.
;; If the file is ommitted, no problem, no customizations are run.

(when (file-exists-p (concat dotfiles-dir "user-customizations.el"))
  (load (concat dotfiles-dir "user-customizations.el")))

;;; Set Emacs to save buffers on exit
(require 'desktop)
  (desktop-save-mode 1)
  (defun my-desktop-save ()
    (interactive)
   ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
    (if (eq (desktop-owner) (emacs-pid))
        (desktop-save desktop-dirname)))
  (add-hook 'auto-save-hook 'my-desktop-save)

;;; Org-agenda and org-capture key-bindings
;;; C-c a a to view agenda
(define-key mode-specific-map [?a] 'org-agenda)
;;; C-c c for org-capture
(setq org-default-notes-file "~/Documents/notebook/notes.org")
(define-key global-map "\C-cc" 'org-capture)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#eaeaea" "#d54e53" "#b9ca4a" "#e7c547" "#7aa6da" "#c397d8" "#70c0b1" "#000000"))
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (cyberpunk)))
 '(custom-safe-themes
   (quote
    ("dcbe22bc74153257f412183dd14ab9652197f59adf65646e618c2577e7cca34d" "4954ee57e8f06d5d4eb68c52e61cd18e40cc0043b021b514b570f29dcf91651d" "0c49a9e22e333f260126e4a48539a7ad6e8209ddda13c0310c8811094295b3a3" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" default)))
 '(fci-rule-color "#424242")
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#49483E" . 0)
     ("#67930F" . 20)
     ("#349B8D" . 30)
     ("#21889B" . 50)
     ("#968B26" . 60)
     ("#A45E0A" . 70)
     ("#A41F99" . 85)
     ("#49483E" . 100))))
 '(magit-diff-use-overlays nil)
 '(org-agenda-files (quote ("~/Documents/notebook/todo.org")))
 '(org-agenda-ndays 7)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-start-on-weekday nil)
 '(org-capture-templates
   (quote
    (("t" "Todo" entry
      (file+headline "~/Documents/notebook/todo.org" "Tasks")
      "** TODO %? %i")
     ("n" "Note" entry
      (file+datetree "~/Documents/notebook/notes.org")
      "** %? Entered on %U %i"))))
 '(org-default-notes-file "~/Documents/notebook/notes.org")
 '(org-directory "~/Documents/notebook")
 '(org-fast-tag-selection-single-key (quote expert))
 '(scheme-program-name "guile")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#d54e53")
     (40 . "#e78c45")
     (60 . "#e7c547")
     (80 . "#b9ca4a")
     (100 . "#70c0b1")
     (120 . "#7aa6da")
     (140 . "#c397d8")
     (160 . "#d54e53")
     (180 . "#e78c45")
     (200 . "#e7c547")
     (220 . "#b9ca4a")
     (240 . "#70c0b1")
     (260 . "#7aa6da")
     (280 . "#c397d8")
     (300 . "#d54e53")
     (320 . "#e78c45")
     (340 . "#e7c547")
     (360 . "#b9ca4a"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#272822" "#49483E" "#A20C41" "#F92672" "#67930F" "#A6E22E" "#968B26" "#E6DB74" "#21889B" "#66D9EF" "#A41F99" "#FD5FF0" "#349B8D" "#A1EFE4" "#F8F8F2" "#F8F8F0"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
