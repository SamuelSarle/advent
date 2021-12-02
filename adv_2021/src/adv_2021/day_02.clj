(ns adv-2021.day-02
  (:require
   [adv-2021.core :refer [get-input]]
   [clojure.string :as str]))

(defn parse
  [x]
  (let [[dir n] (str/split x #" ")]
    [dir (Integer/parseInt n)]))

(defn move
  [[px py] [dir n]]
  (case dir
    "up" [px (- py n)]
    "down" [px (+ py n)]
    "forward" [(+ px n) py]))

(defn solve-1
  [input]
  (->> input
       (map parse)
       (reduce move [0 0])
       (apply *)))

(defn move-2
  [[px py aim] [dir n]]
  (case dir
    "up" [px py (- aim n)]
    "down" [px py (+ aim n)]
    "forward" [(+ px n) (+ py (* aim n)) aim]))

(defn solve-2
  [input]
  (->> input
       (map parse)
       (reduce move-2 [0 0 0])
       butlast
       (apply *)))

(comment
  (solve-1 (get-input 2))
  (solve-2 (get-input 2)))
