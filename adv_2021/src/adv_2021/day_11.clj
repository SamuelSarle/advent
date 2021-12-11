(ns adv-2021.day-11
  (:require [adv-2021.core :refer [get-raw-input]]))

(defn create-map
  [input]
  (first
   (reduce
    (fn [[acc cur-x cur-y] x]
      (if (= x "\n")
        [acc 0 (inc cur-y)]
        [(assoc acc [cur-x cur-y] (Integer/parseInt x)) (inc cur-x) cur-y]))
    [{} 0 0]
    (map str input))))

(defn neighbours
  [[x y]]
  (for [dx [-1 0 1] dy [-1 0 1]
        :when (or (not= 0 dx) (not= 0 dy))]
    [(+ x dx) (+ y dy)]))

(defn inc-all
  [xs]
  (into {} (map (fn [[k v]] [k (inc v)])) xs))

(defn flash-all
  [m]
  (loop [m m
         flashed #{}]
    (let [flashable (->> m (filter #(< 9 (val %))) (remove #(flashed (key %))))]
      (if (empty? flashable)
        [m flashed]
        (let [to-flash (first flashable)]
          (recur (->> to-flash
                      key
                      neighbours
                      (filter #(get m %))
                      (reduce #(update %1 %2 inc) m))
                 (conj flashed (key to-flash))))))))

(defn step
  [[m flash-acc]]
  (let [[m flashed] (flash-all (inc-all m))]
    [(reduce #(assoc %1 %2 0) m flashed) (count flashed)]))

(defn hundred-steps
  [m]
  (->> [m 0]
       (iterate step)
       (drop 1)
       (take 100)))

(defn solve-1
  [input]
  (->> input
       create-map
       hundred-steps
       (map second)
       (apply +)))

(defn until-all-zero
  [m]
  (->> [m 0]
       (iterate step)
       ;; 100 flashes means that all of them would be zero:
       (take-while #(> 100 (second %)))))

(defn solve-2
  [input]
  (->> input
       create-map
       until-all-zero
       count))

(comment
  (solve-1 (get-raw-input 11))
  (solve-2 (get-raw-input 11)))
