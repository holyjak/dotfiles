;; Place your bindings here.

;; For example:
;;;; OVERRIDING STUFF & KEYS
;(global-set-key "\C-a" 'smart-beginning-of-line) ;; start x first non-whitespace char
;(global-set-key (kbd "C-=") 'switch-to-current-buffer-other-window)
;(global-set-key (kbd "C-x 4 k") 'close-and-kill-next-pane)
;; Re-set M-/ from comment-or-uncomment-region back to dabbrev-expand (or ac-start )
;(global-set-key "\M-/" 'dabbrev-expand)
;; Text scale adjust: bound by def. to C-x C--, C-x C-+; depends on last char: 0/+/-/=
;(global-set-key "\M-+" 'text-scale-adjust)
;(global-set-key "\M--" 'text-scale-adjust)
(define-key global-map (kbd "M-+") 'text-scale-increase)
(define-key global-map (kbd "M--") 'text-scale-decrease)

;; Jump to word-start character
;;(define-key global-map (kbd "C-ø") 'ace-jump-mode)
(define-key global-map (kbd "M-b") 'ace-jump-mode) ;; FIXME Slow (~1s) under ErgoEmacs

;; Overide the "load buffer" to save it prior to loading
;(define-key global-map (kbd "C-c C-k") 'nrepl-save-and-load-current-buffer)

;; Replace zap-to-char with zap-up-to-char
;;(global-set-key "\M-z" 'zap-up-to-char) ;; colied with EE undo
;;(global-set-key (kbd "s-4") 'split-window-right)

;(global-set-key (kbd "<f5>") 'kill-buffer-and-window)

;; win-switch mode, activated temporarily if 3+ windows opened
;; e. live by default only sets o (next) and p (prev)
(win-switch-set-keys '("i") 'up)
(win-switch-set-keys '("k") 'down)
(win-switch-set-keys '("j") 'left)
(win-switch-set-keys '("l") 'right)

;;(require 'clojure-test-mode) TODO Deprecated, use cider-test
;;(define-key clojure-test-mode-map [f12] 'clj-save-and-test)

;;(require 'strokes)
;;(define-key strokes-mode-map [(shift down-mouse-3)] 'strokes-do-stroke)

;; F13 - mapped to CapsLock via Seil - is the [Menu] key used f.ex. by ErgoEmacs
(define-key key-translation-map (kbd "<f13>") (kbd "<menu>"))
;; House (home) on M$ Natural mapped to this:
(define-key key-translation-map (kbd "C-M-<f10>") (kbd "<menu>"))

;;; FIXME
;; x  Under EE, s-4 kbds defined above do not work (and the default Cmd/Alt-4 splits horizontally, not vertically as advertised) FIX: OSX settings - kbd - shortcuts - Screen Shots - disable all
;; x Under EE, M-z enters Ω, same as Cmd-z (mac-command-modifier is set to meta; without EE its value is super) - FIX by setting mac-option-modifier to 'meta inst.of nil
;; x TAB runs yas-expand that delegates to ace-jump-mode if no expansion = but I want indentation - FIX by not using C-i but rather M-b; somewhat C-i modified TAB?!
;;   The TAB is in the ace-jump-mode keymap
;; - Cannot define e.g. M-, inside ergonomics :bind, it does not take an effect (overridden by st.?)
;; x M-/ remapped to toggle case from complete string, which I need
;; - ? get rid out outline mode bindings M-n M-p, defined in Emacs Live default bindings?

;;; TODO
;; - Consider st. displaying tabs a la browser to make it easier for Alex to switch (or speedbar?)
;; - better autocompletion and ido mode that does not require consecutive chars
;; - fix conflict between JS autocompletion and using TAB for yasnippet compl.
