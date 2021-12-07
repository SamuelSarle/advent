(ns adv-2021.day-07
  (:require
   [adv-2021.core :refer [get-input]]
   [clojure.string :as str]))

(defn int-abs
  "Using (abs (int x)) has 10x faster execution time
  than (abs x) for solve-1 and solve-2."
  [x]
  (Math/abs (int x)))

(defn median
  [xs]
  (nth (sort xs) (int (/ (count xs) 2))))

(defn solve-1
  [input]
  (let [xs (map #(Integer/parseInt %) (str/split input #","))
        median (median xs)]
    (apply + (map #(int-abs (- % median)) xs))))

(defn mean
  [xs]
  (/ (apply + xs) (count xs)))

(defn fuel-cost
  [x y]
  (let [distance (int-abs (- x y))]
    (/ (* distance (inc distance)) 2)))

(defn total-fuel-cost
  [xs mean]
  (->> xs
       (map #(fuel-cost % mean))
       (apply +)))

(defn minimum-fuel-cost
  [xs mean]
  (min (total-fuel-cost xs (Math/ceil mean))
       (total-fuel-cost xs (Math/floor mean))))

(defn solve-2
  [input]
  (let [xs (map #(Integer/parseInt %) (str/split input #","))
        m (mean xs)]
    (minimum-fuel-cost xs m)))

(comment
  (solve-1 (get-input 7))
  (solve-2 (get-input 7)))
