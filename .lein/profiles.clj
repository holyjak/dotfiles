;; Inspired heavily by http://dev.solita.fi/2014/03/18/pimp-my-repl.html
{:user {:dependencies [
                       [org.clojars.gjahad/debug-repl "0.3.3"]
                       [im.chit/vinyasa "0.1.8"]
                       [spyscope "0.1.4"] ;; reader macro to print forms before execution: #spy/p, d
                       [difform "1.1.2"] ;; diff of clj data structures
                       [clj-ns-browser "1.3.1"]
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
                     (require 'spyscope.core)]
        :plugins [
                  [lein-ancient "0.5.4"]
                  [lein-try "0.4.1"]]}}