;; This allows you to override variables such
;; as live-packs (allowing you to specify pack loading order)
;; Does not load if running in safe mode
;; See live-ignore-packs, live-(append|add)-packs,
;; live-prepend-packs,
;; live-use-packs (load only these + those added later),
;; live-use-dev-packs (only the dev packs)
;; Could also be done in .emacs.d/etc/custom/custom-configuration.el
;; which runs at the very end of booting Emacs Live
(live-add-packs '(~/.live-packs/jholy-pack))
