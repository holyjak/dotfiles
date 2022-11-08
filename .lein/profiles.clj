
;; Inspired heavily by http://dev.solita.fi/2014/03/18/pimp-my-repl.html
;; and a newer https://gist.github.com/rauhs/d5bb47c239b58cbf54e1d3d1de221031
;; pragma: allowlist nextline secret
{:portal {:dependencies [[djblue/portal "RELEASE"]]
          :repl-options {:welcome (do (def p ((requiring-resolve 'portal.api/open) {:launcher :intellij})) (add-tap (requiring-resolve 'portal.api/submit)))}}
 ;; NOTE: Flow 2.2 needs tools.namespace 1.2
 :flowstorm {:dependencies [[com.github.jpmonettas/flow-storm-dbg "RELEASE"], [com.github.jpmonettas/flow-storm-inst "RELEASE"]]}
 :user {:signing {:gpg-key "5AA361214163F2CD"} ;; my keybase key
        :deploy-repositories [["clojars" {:url "https://repo.clojars.org" :creds :gpg}]]
        :dependencies [
;?                         [org.clojure/tools.nrepl "0.2.13"]
;;                       [org.clojars.gjahad/debug-repl "0.3.3"]
;;                       [im.chit/vinyasa "0.3.4"]
;;                       [spyscope "0.1.5"] ;; reader macro to print forms before execution: #spy/p, d
;;                       [difform "1.1.2"] ;; diff of clj data structures
;;;;                        [clj-ns-browser "1.3.1"]
;;                       [nrepl-inspect "0.4.1"]    ; for wrap-inspect, Emacs
;;                       [ritz/ritz-nrepl-middleware "0.7.0"]
;;                       ;;[night-vision "0.1.0-SNAPSHOT"] ;; print input/output of each call in a ns; see (night-vision.goggles/introspect-ns! '<your ns>)
;;                       ;;[leiningen "2.3.4"] ;; Vinyasa needs this, must match my lein version x see vinyasa/issues/3
;;                       [alembic "0.3.2"]   ;; reload new deps from project.clj
;;                       [slamhound "1.5.5"] ;; optimize and add missing requires/imports in .clj files - see aliases below or editor-specific plugins or run from repl
;;                       [io.aviso/pretty "0.1.17"] ;; nrepl/pretty-middleware for exceptions
;;                       ;; from REPL: (slam.hound/-main "src/my/namespace.clj")
;;                       [org.clojure/tools.trace "0.7.8"] ;; trace calls to fns (in+out), forms execution, ...
                       ]

        :injections [
;;                     (require 'vinyasa.inject) ;; TODO check also vinyasa/pull, lein, reimport
;;                     (require 'alex-and-georges.debug-repl)
;;                     (require 'com.georgejahad.difform)
;;;;                      (require 'clj-ns-browser.sdoc)
;;                   ;  (require 'clojure.tools.trace)
;;                     (vinyasa.inject/inject 'clojure.core '> ;; "Copy" the given function to clojure.core (and thus all namespaces), prefixed with > => (>doc ..)
;;                       '[[clojure.repl doc source]
;;                         [clojure.pprint pprint pp]
;;                         [vinyasa.pull pull]
;;                         ;[vinyasa.lein lein]
;;                         [alex-and-georges.debug-repl debug-repl]
;;                         [com.georgejahad.difform difform]
;;;;                          [clj-ns-browser.sdoc sdoc]
;;                         [clojure.tools.trace trace deftrace trace-forms trace-ns trace-vars untrace-ns untrace-vars]])
;;                     (require 'spyscope.core)
                     ]
        :plugins [
                  [lein-count "1.0.9"] ; -> `lein count` to count LoC
 ;;                   [lein-virgil "0.1.8"] ; auto-recompile and reload .java files from :java-source-paths into the REPL
 ;;                   [lein-libdir "0.1.1"] ; dependencies to ./lib/
                    ;[cider/cider-nrepl "0.9.1"]
                    ;[refactor-nrepl "1.1.0"]
                    ;[com.jakemccrary/lein-test-refresh "0.16.0"] ;; autotest
;?                    [venantius/ultra "0.5.2"] ;; clj.test output and data in REPL coloring etc
;;                  ;;[lein-catnip "0.5.1"]
;;                  ;;[codox "0.6.1"]                     ; document. generation from src
;;                  [lein-ring "0.9.3"]
;;                  ;;[lein-noir "1.2.1"]                 	; deprecated, use compojure + noir lib
;;                  [lein-droid "0.3.5"]       	; for Android; !! req. JDK 6 as of 5/2013 !!!
;;                  [lein-ritz "0.7.0"]   		; for nrepl-inspect
;;                  [lein-marginalia "0.8.0"]
                    [lein-ancient "0.6.15"]
                    [lein-try "0.4.3"]
;;                  ;;[lein-alembic "0.1.0"]     ; make alembic available -> reload prj deps w/o restarting repl: (alembic.still/load-project)
;;                  [lein-clojuredocs "1.0.2"] ; Create clojuredocs-style doc
;;                  ;;[quickie "0.2.6"] ; autotest for clojure.test
;;                  [com.jakemccrary/lein-test-refresh "0.9.0"] ;; autotest: lein test-refresh :growl ; weak results reporting :-(
;;                  [lein-light "0.0.44"] ; LightTable: `lein light` in a prj
;;                  [jonase/eastwood "0.2.1"] ; linter: lein eastwood
;;                  [lein-pprint "1.1.2"]
                  ]
        :aliases {
;;                  "slamhound" ["run" "-m" "slam.hound"] ;; => lein slamhound <file or dir>
                  }
        :repl-options {:nrepl-middleware
                      [
 ;;                      ;inspector.middleware/wrap-inspect
 ;;                      ritz.nrepl.middleware.javadoc/wrap-javadoc
 ;;                      ritz.nrepl.middleware.apropos/wrap-apropos
 ;;                      ritz.nrepl.middleware.simple-complete/wrap-simple-complete
 ;;                      io.aviso.nrepl/pretty-middleware ;; pretty-print exceptions in repl
                       ]}
;       :mirrors {#"clojars" {:name "clojars mirror" :url "https://clojars-mirror.tcrawley.org/repo/"}}
 }
 :reveal {:dependencies [[vlaaad/reveal "1.3.216"]
                         [org.openjfx/javafx-controls "17"]]
          :repl-options {:nrepl-middleware [vlaaad.reveal.nrepl/middleware]}}
 :repl {#_#_
        :dependencies [;[zcaudate/lucid.aether "1.4.4"]
                       ;[zcaudate/lucid.core.inject "1.4.4"]
                       [zcaudate/lucid.core.debug "1.4.7"]
                       [zcaudate/lucid.package "1.4.7"]
                       ;; needed for ns reload (i.e. resetting; see clojure.tools.namespace.reload [Clojure only as of 0.3.0alpha4)
                       [org.clojure/tools.namespace "0.3.0-alpha4"]]
 ;;       :plugins [[com.gfredericks/lein-shorthand "0.4.1"]]
        :global-vars {;*warn-on-reflection* true
                      *print-length* 200 ;; avoid infinite sequences in dev mode.
                      ;*print-namespace-maps* false
                      *assert* true}
        :jvm-opts [;"-Xms400m" ;; starting heap memory
                   ;"-Xmx8000m" ;; max heap memory
                   "-XX:-OmitStackTraceInFastThrow" ;; Stop JVM from hiding stacktrace of repeated exceptions
                   ; Enable clojure.spec/assert (off by default)
                   "-Dclojure.spec.check-asserts=true"]
        ;:injections [(require '[lucid.core.inject :as inject])
        ;             ; Make the following functions available everywhere with the prefix `>`, i.e. >doc, >pull etc.
        ;             (inject/in
        ;               ;.
        ;               [lucid.package pull]                ; add a project dependency to the REPL; ex: `(>pull [org.clojure/core.match "0.2.2"])`
        ;               [clojure.pprint pprint]
        ;               [clojure.repl doc source]
        ;               )
        ;             ]
        ; Use the lein-shorthand to create the namespace `.` and copy there
        ; functions we want easily available everywhere, e.g. `(./doc defn)`
        :shorthand {. [clojure.pprint/pprint
                       clojure.repl/doc
                       clojure.repl/source
                       ^:lazy lucid.package/pull ; add a project dependency to the REPL; ex: `(./pull [org.clojure/core.match "0.2.2"])`
                       clojure.tools.namespace.repl/refresh
                       clojure.tools.namespace.repl/refresh-all]}
        }
 }
