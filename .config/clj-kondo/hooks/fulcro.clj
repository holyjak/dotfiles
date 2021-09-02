(ns hooks.fulcro
  ""
  {:author "Adam Helins"}
  (:require
   [clj-kondo.hooks-api :as hook]))

(defn defmutation
  [{:keys [node]}]
  (let [[_call
         sym
         & arg+] (:children node)
        docstring (first arg+)
        [[param+
          & fn-like+]
         docstring-2] (if (hook/string-node? docstring)
                        [(rest arg+)
                         docstring]
                        [arg+
                         nil])]
    {:node (hook/list-node (concat [(hook/token-node 'defn)
                                    sym]
                                   (when docstring-2
                                     [docstring-2])
                                   [param+
                                    (hook/vector-node (map #(let [[_sym
                                                                   arg+
                                                                   & body] (:children %)]
                                                              (hook/list-node (list* (hook/token-node 'fn)
                                                                                     arg+
                                                                                     body)))
                                                           fn-like+))]))}))
