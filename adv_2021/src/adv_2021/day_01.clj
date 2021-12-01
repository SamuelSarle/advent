(ns adv-2021.day-01
  (:require
   [adv-2021.core :refer [get-input]]))

(defn solve-1
  [input]
  (->> input
       (map #(Integer/parseInt %))
       (partition 2 1)
       (map (fn [[x y]] (if (< x y) 1 0)))
       (apply +)))

(defn solve-2
  [input]
  (->> input
       (map #(Integer/parseInt %))
       (partition 3 1)
       (map (partial apply +))
       (partition 2 1)
       (map (fn [[x y]] (if (< x y) 1 0)))
       (apply +)))

(comment
 (solve-1 (get-input 1))
 (solve-2 (get-input 1)))
