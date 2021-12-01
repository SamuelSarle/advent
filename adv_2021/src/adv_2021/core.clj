(ns adv-2021.core
  (:require [clojure.string :as str]))

(defn get-input [day]
  (let [input (str/split-lines (slurp (str "input/day_" (format "%02d" day )".txt")))]
    (if (= 1 (count input))
      (first input)
      input)))
