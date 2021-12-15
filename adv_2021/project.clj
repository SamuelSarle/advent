(defproject adv_2021 "0.1.0-SNAPSHOT"
  :license {:name "Unlicense"
            :url "https://unlicense.org/"}
  :dependencies [[org.clojure/clojure "1.10.1"]
                 [org.clojure/data.priority-map "1.1.0"]]
  :repl-options {:init-ns adv-2021.core}
  :jvm-opts ["-Djdk.attach.allowAttachSelf"])
