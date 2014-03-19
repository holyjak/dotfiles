;; Inspired heavily by http://dev.solita.fi/2014/03/18/pimp-my-repl.html
{:user {:dependencies [
                       [org.clojars.gjahad/debug-repl "0.3.3"]
                       [im.chit/vinyasa "0.1.8"]
                       [spyscope "0.1.4"] ;; reader macro to print forms before execution: #spy/p, d
                       [difform "1.1.2"] ;; diff of clj data structures
                       [clj-ns-browser "1.3.1"]
                       [nrepl-inspect "0.4.1"]    ; for wrap-inspect, Emacs
                       [ritz/ritz-nrepl-middleware "0.7.0"]
                       [night-vision "0.1.0-SNAPSHOT"] ;; print input/output of each call in a ns; see (night-vision.goggles/introspect-ns! '<your ns>)
                       ]
        ;; "Copy" the given function to clojure.core (and thus all namespaces), prefixed with > => (>doc ..)
        :injections [(require 'vinyasa.inject) ;; TODO check also vinyasa/pull, lein, reimport
                     (require 'alex-and-georges.debug-repl)
                     (require 'com.georgejahad.difform)
                     (require 'clj-ns-browser.sdoc)
                     (vinyasa.inject/inject 'clojure.core '>
                       '[[clojure.repl doc source]
                         [clojure.pprint pprint pp]
                         [alex-and-georges.debug-repl debug-repl]
                         [com.georgejahad.difform difform]
                         [clj-ns-browser.sdoc sdoc]])
                     (require 'spyscope.core)
                     (require 'night-vision.goggles)]
        :plugins [
                  [lein-catnip "0.5.1"]
                  ;;[codox "0.6.1"]                     ; document. generation from src
                  [lein-ring "0.8.10"]
                  ;;[lein-noir "1.2.1"]                 	; deprecated, use compojure + noir lib
                  [lein-droid "0.2.2"]       	; for Android; !! req. JDK 6 as of 5/2013 !!!
                  [lein-ritz "0.7.0"]   		; for nrepl-inspect
                  [lein-marginalia "0.7.1"]
                  [lein-ancient "0.5.4"]
                  [lein-try "0.4.1"]
                  [lein-alembic "0.1.0"]     ; make alembic available -> reload prj deps w/o restarting repl: (alembic.still/load-project)
                  [lein-clojuredocs "1.0.2"] ; Create clojuredocs-style doc
                  [quickie "0.2.6"] ; autotest for clojure.test
                  [lein-light "0.0.44"] ; LightTable: `lein light` in a prj
                  ]}
       :repl-options {:nrepl-middleware
                       [
                        ;inspector.middleware/wrap-inspect
                        ritz.nrepl.middleware.javadoc/wrap-javadoc
                        ritz.nrepl.middleware.apropos/wrap-apropos
                        ritz.nrepl.middleware.simple-complete/wrap-simple-complete]}
 }
