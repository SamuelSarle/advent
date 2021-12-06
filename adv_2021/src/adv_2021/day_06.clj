(ns adv-2021.day-06
  (:require
   [adv-2021.core :refer [get-input]]
   [clojure.string :as str]))

(defn step
  [[new-fishes & other]]
  (update (conj (vec other) new-fishes) 6 (partial +' new-fishes)))

(defn total
  [fishes turns]
  (apply +' (nth (iterate step fishes) turns)))

(defn start-counts
  [input]
  (let [counts (into (sorted-map) (for [x (range 9)] [x 0]))]
    (->> (str/split input #",")
         (map #(Integer/parseInt %))
         frequencies
         (into counts)
         (mapv val))))

(defn solve-1
  [input]
  (-> input
      start-counts
      (total 80)))

(defn solve-2
  [input]
  (-> input
      start-counts
      (total 256)))

(comment
  (solve-1 (get-input 6))
  (solve-2 (get-input 6)))
