(ns adv-2021.day-06
  (:require
   [adv-2021.core :refer [get-input]]
   [clojure.string :as str]))

(def total
  (memoize
   (fn [n turns]
     (cond
       (= 0 turns) 1
       (= 0 n) (+' (total 6 (dec turns))
                   (total 8 (dec turns)))
       :else (recur (dec n) (dec turns))))))

(defn solve-1
  [input]
  (->> (str/split input #",")
       (map #(Integer/parseInt %))
       (map #(total % 80))
       (apply +)))

(defn solve-2
  [input]
  (->> (str/split input #",")
       (map #(Integer/parseInt %))
       (map #(total % 256))
       (apply +)))

(comment
  (solve-1 (get-input 6))
  (solve-2 (get-input 6)))
