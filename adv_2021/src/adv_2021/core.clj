(ns adv-2021.core
  (:require [clojure.string :as str]))

(defn get-raw-input
  [day]
  (slurp (str "input/day_" (format "%02d" day )".txt")))

(defn get-input
  [day]
  (let [input (str/split-lines (get-raw-input day))]
    (if (= 1 (count input))
      (first input)
      input)))
