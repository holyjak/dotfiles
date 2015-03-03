;; User pack init file
;;
;; User this file to initiate the pack configuration.
;; See README for more information.

;;; ########### JH: Notes & tips #########################
;;; EMACS LIVE
;;; - add libs ti lib/, load via (live-add-pack-lib "lib-name") - works laso for lib/lib-name/lib-name.el
;;;
;;; GENERAL
;; cua-mode - mark rectangles (start with C-RET, then move), work on them (C-d delete, C-w, M-w, C-y)
;; => fix indentation etc. Type => inserts in all lines
;;;
;;; CLOJURE NOTES
;;; - Exploring new libs: hs-minor-mode (HideShow) => C-c @ C-M-h collapses all; ..-s show all; C-c @ C-c togge s/h
;;;   - https://github.com/shanecelis/hideshow-org.git adds hide/show via (S-)TAB w/o blocking its orig. func.
;;; - magnar's clj-refactor package
;;;
;;; TEACHING LEARNING
;;; - https://github.com/lewang/command-log-mode - record keystroke + command name in a buffer, cool, smart, useful
;;;
;;; EMACS LIVE
;;; IDO (complete anything in file opening etc.)
;;; - Create new file: C-z to go back to prev. proposal, C-j to create the typed path if it doesn't exist w/o switching
;;; ---

;;; TODO Ergoemacs
;; [home], [end] key replacement?
;; [menu] key?!


;;; JH: TODO - try - Interestig packages
;; Try http://www.emacswiki.org/emacs/OneKey
;; Try Tab Bar Mode for non-emacser friendliness
;; rm outdated iswitchb
;; better autocompletion - see ohai/Jakob
;; ? JS test results in Emacs
;; Open files via projectile by default?

;;;; TODO Eventually
;; ?? https://github.com/nonsequitur/smex
;; http://www.emacswiki.org/emacs/SrSpeedbar - speedbar in the same frame (~buffer-like)
;; List of functions in speedbar with cedet's semantic and ext. for clojure:
;; - https://github.com/kototama/clojure-semantic
;; https://github.com/Fuco1/smartparens/wiki - better paredit + more
;; Use IDO to search through recent files: http://stackoverflow.com/a/6995886

;; Load bindings config
(live-load-config-file "bindings.el")

;;; KEYS
(global-set-key (kbd "C-c C-r") 'recentf-open-files)
;; Note: Right Alt is used for inserting alternative chars under
;; non-english Mack
(setq ns-right-option-modifier 'none) ;; spec. chars entry
(setq ns-right-command-modifier 'meta)

;;;; GENERAL SETTINGS
;; Start emacs server to open files from command-line tools
;; (emacsclient <file>); see also
;; /Applications/../Emacs.app/Contents/MacOS/Emacs --daemon
(server-start)
;;; CONFIG
;; Always ALWAYS use UTF-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
;; Save & restore open buffer upon exit/start
(desktop-save-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(markdown-command "/usr/local/bin/markdown")
 '(show-trailing-whitespace t))

;; display help text automatically whenever it is available at point
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Help-Echo.html
(setq help-at-pt-display-when-idle t)

;;; PACKAGES -------
(push "~/.live-packs/jholy-pack/lib/use-package" load-path)
(require 'use-package)
(require 'package)
(mapc (lambda(p) (push p package-archives))
      '(("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))
;; load packages installed with package manager
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
;;(package-refresh-contents) ;; expensive !!!
(use-package discover ;; TODO add discover-js2-refactor; check also https://github.com/steckerhalter/discover-my-major
  :ensure t)
(use-package editorconfig
  :ensure t)
(use-package fill-column-indicator
    :ensure t)

;; Enable projectile anywhere (it knows lein, pom. git, ...)
;; C-c p t - switch test <> implem.
(use-package projectile
  :ensure t
  :init (projectile-global-mode))
(use-package groovy-mode
  :ensure t
  :mode "\\.gradle\\'")
(use-package ergoemacs-mode
    :ensure t
    :init (progn
              (setq ergoemacs-theme nil) ;; Uses Standard Ergoemacs keyboard theme
              (setq ergoemacs-keyboard-layout "us") ;; Assumes QWERTY keyboard layout
              (ergoemacs-mode 1)
              (setq mac-option-modifier 'meta) ;; if nil - done by EE - then A-z will enter Ω; anything lese will prevent this
              )
    :bind (
              ("C-a" . ergoemacs-beginning-of-line-or-what)
              ("C-e" . ergoemacs-end-of-line-or-what)
              ("M-n" . ergoemacs-beginning-or-end-of-buffer) ; re-bind, was bound to outline-next-visible-heading from outline.el
              ("M-/" . dabbrev-expand) ;; rebind from toggle case
              ))
(use-package ac-js2 // better autoc., navigate to symbol; support for Company mode on itsway
  ;; It binds M-. to jump to definition, M-, to go back
  :ensure t
  :init (add-hook 'js2-mode-hook 'ac-js2-mode))
(use-package nodejs-repl
  :ensure t)

;; see https://github.com/ergoemacs/ergoemacs-mode/issues/333
;; FIXME DOES NOT WORK
;; (defadvice ergoemacs-install-shortcuts-map (around ace-jump-fix (&optional map dont-complete install-read no-brand))
;;   "Fix slow ace-jump mode due to EE on the fly processing the keymap it generates"
;;   (if (and map (keymapp map) (eq (lookup-key map [t] t) 'ace-jump-done))
;;       map
;;    ad-do-it))
;; (defun foo--foo-around (orig-fun &rest args)
;;        "Ignore case in `foo'."
;;        (let ((case-fold-search t))
;;          (apply orig-fun args)))
;;      (advice-add 'foo :around #'foo--foo-around)


;;;; MODES -----------------------------------------------------------------------------------
;; Enable insertion of closing parens by default (what is close is customizable)
(electric-pair-mode 1)
;; Align line autom. after RET (as C-j does?)
(electric-indent-mode 1)
;; Autom. insert newline when some chars typed, e.g. } and ; in JavaScript:
;; (electric-layout-mode 1)

;;;; JavaScript (js2-mode) ...........................
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; See https://github.com/puppetlabs/puppet-syntax-emacs
(live-add-pack-lib "puppet-mode")
(require 'puppet-mode)
;(autoload 'puppet-mode (concat (live-pack-lib-dir) "/puppet-mode") "Major mode for editing puppet manifests")
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))

;;(live-add-pack-lib "jshint-mode")
;;(require 'flymake-jshint)
(live-add-pack-lib "emacs-flymake")
(require 'flymake)
(add-hook 'js2-mode-hook 'flymake-mode)

;;; JavaScript
(setq exec-path
      (cons "/usr/local/share/npm/bin/jshint" exec-path)) ;; jshint for flymake

;;; Show pretty symbols instead of 'function' etc., see
;; http://ergoemacs.org/emacs/emacs_pretty_lambda.html
(global-prettify-symbols-mode 1) ;; “lambda” as “λ” by default
(defun my-add-pretty-lambda ()
  "make some word or string show as pretty Unicode symbols"
  (setq prettify-symbols-alist
        '(
          ("lambda" . 955) ; λ
          ("function" . 955) ; λ
          ("->" . 8594)    ; →
          ("=>" . 8658)    ; ⇒
          ("map" . 8614)   ; ↦
          )))

(add-hook 'clojure-mode-hook 'my-add-pretty-lambda)
(add-hook 'js2-mode-hook 'my-add-pretty-lambda)

;;; NODEJS-REPL
(live-add-pack-lib "nodejs-repl-eval")
(require 'nodejs-repl-eval)

;;; CLOJURE


;; BEWARE 5/2013: You must jack-in from a test for this to work; otherwise:
;; 'ClassNotFoundException: clojure.test.mode'
;; see https://github.com/technomancy/clojure-mode/issues/146#issuecomment-15447065
(require 'clojure-test-mode)

;; Inspect a var with C-c C-i
;; See http://ianeslick.com/2013/05/17/clojure-debugging-13-emacs-nrepl-and-ritz/
;(live-add-pack-lib "nrepl-inspect")
;(define-key nrepl-mode-map (kbd "C-c C-i") 'nrepl-inspect) ; FIXME CcCi translated to CcTAB somewhere else
;;(require 'nrepl-inspect) - broken, the above works though

;(setq nrepl-ritz-javadoc-local-paths (list ".../standard_edition/7.0/docs/api"))

;; DOCS:
;;; CLOJURE BUFFER + REPL:
;; * M-x nrepl-jack-in: Launch an nrepl server and a repl client. Prompts for a project root if given a prefix argument.
;; * M-x nrepl: Connect to an already-running nrepl server.
;; * C-c M-n: Switch the namespace of the repl buffer to the namespace of the current buffer.
;; * C-c C-z: Select the repl buffer.
;; * C-c C-k: Load the current buffer.
;; * C-c C-d: Display doc string for the symbol at point (prompt if no symbol)
;; * M-TAB: Complete the symbol at point (For auto-complete integration, see ac-nrepl)
;; * C-c C-b: Interrupt any pending evaluations.
;; * C-x C-e: Evalulate the form preceding point -> echo area
;; * C-x C-r: -"- region
;; * M-. - go to symbol under point's definition; go back with M-,
;; * C-x C-i (imenu) - go to a definition in the file (ido search in
;; the minibuf)
;; CLJ TEST MODE (fun clojure-test-*)
;; * C-c C-t - jump between test and code (right dir, *ns*_test.clj)
;; * C-c , (or .. (C-,|M-,))
;; * C-c ' (or .. C-') - clojure-test-show-result
;; * C-c k - clojure-test-clear
;; * M-p, M-n - prev/next test problem
;; REPL
;; *e last error, *1, *2, ... = last, prev, ... output
;; * C-c M-o: clear
;; * C-c C-b: Interrupt any pending evaluations.
;; * C-up, C-down: Goto to previous/next input in history
;; * M-p, M-n: Search the previous/next item in history
;; * M-s, M-r: Search forward/reverse through command history with regex.
;; TAB - complete symbol
;; (defun nrepl-save-and-load-current-buffer ()
;;   (interactive)
;;   (save-buffer)
;;   (nrepl-load-current-buffer))

;; (require 'nrepl)
;; Configure nrepl - http://ianeslick.com/2013/05/17/clojure-debugging-13-emacs-nrepl-and-ritz
;(setq nrepl-hide-special-buffers t)     ; hides nrepl-server etc.
;;(setq nrepl-popup-stacktraces-in-repl t)
;; (setq nrepl-history-file "~/.emacs.d/nrepl-history")

;;; BROKEN: Emacs cannot find it now: File error: Cannot open load file, clj-refactor
;; (require 'clj-refactor)
;; ;; rf: rename file, update ns-declaration, and then query-replace new ns in project.
;; ;; ar: add :require to namespace declaration, then jump back
;; ;; au: add :use to namespace declaration, then jump back
;; ;; ai: add :import to namespace declaration, then jump back
;; (add-hook 'clojure-mode-hook (lambda ()
;;                                (clj-refactor-mode 1)
;;                                ;; insert keybinding setup here
;;                                (cljr-add-keybindings-with-prefix "C-c C-m") ;; eg. rename files with `C-c C-m rf`; ovverides macroexpand-1
;;                                ))

;;; Ritz:
;; (live-add-pack-lib "nrepl-ritz")
;; (add-hook 'nrepl-interaction-mode-hook 'my-nrepl-mode-setup)
;; (defun my-nrepl-mode-setup ()
;;   (require 'nrepl-ritz))

;;; hideshow-org: (S-)TAB toggle hide/show a sexp in the hs-org/minor-mode (indicated by hs+)
(live-add-pack-lib "hideshow-org")
(require 'hideshow-org)
(add-hook 'clojure-mode-hook 'hs-org/minor-mode)

;;; The SQL mode has no highlighting by default => use ANSI (replace with [postgres|ms|.. as appropriate)
(add-hook 'sql-mode-hook 'sql-highlight-ansi-keywords)
;;;; FUNS ------------------------------------------------------------------------------

;; zap-up-to-char is similar to zap-to-char (M-z) but excludes the end character and includes the current one
(autoload 'zap-up-to-char "misc"
    "Kill up to, but not including ARGth occurrence of CHAR. \(fn arg char)"
    'interactive)

;; C-a moves to 1st non-whitespace char if at beg. of line already
(defun smart-beginning-of-line ()
  "Toggles point between bol and first non-whitespace char in line.
Also moves past comment delimiters when inside comments."
  (interactive)
  (let (node beg)
    (cond
     ((bolp)
      (back-to-indentation))
     ((or (looking-at "//") (looking-at ";"))
      (skip-chars-forward "/; \t"))
     (t
      (goto-char (point-at-bol))))))

(defun switch-to-current-buffer-other-window ()
  (interactive)
  (switch-to-buffer-other-window (current-buffer)))

;; From http://emacswiki.org/emacs/KillingBuffers#toc2
(defun close-and-kill-next-pane ()
  "Close the other pane and kill the buffer in it also."
  (interactive)
  (other-window 1)
  (kill-buffer (current-buffer))
  (delete-window)
  )

;; From http://stackoverflow.com/questions/3669511/the-function-to-show-current-files-full-path-in-mini-buffer
(defun copy-file-name ()
  "Show the full path file name in the minibuffer and copy it to the clipboard."
  (interactive)
  (message (buffer-file-name))
  (kill-new (file-truename buffer-file-name))
)

;; Show the current file or buffer name in the window title
(setq frame-title-format
      '(buffer-file-name
        "%f"
        (dired-directory dired-directory "%b")))

(defun clj-save-and-test ()
  (interactive)
  (save-buffer)
  ;(nrepl-load-current-buffer) ;; FIXME if compilation fail, test will run on the old version, hiding the failure
  (clojure-test-run-tests))

(defun jh/editorconfig-apply ()
  "Apply editorcinfig properties manually (if it hasn't happend automatically)"
    (interactive)
    (edconf-find-file-hook)
  (let (props)
    (setq props (edconf-parse-properties (edconf-get-properties)))
    (message "editorconfig loaded, indent: st %s, sz %s, \\t %s" (gethash 'indent_style props) (gethash 'indent_size props) (gethash 'tab_width props))))

;; ------------------------------------------- INFO
;; Code folding
;; - hs-minor-mode: S-mouse-2 or shift middle click on a line to hide/show;
;; - Hideshowvis adds clickable icons to the fringe
