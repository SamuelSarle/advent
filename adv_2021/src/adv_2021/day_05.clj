(ns adv-2021.day-05
  (:require
   [adv-2021.core :refer [get-input]]
   [clojure.string :as str]))

(defn str->range
  [s]
  (->> (str/split s #" +-> +")
       (mapcat (fn [x] (map #(Integer/parseInt %) (str/split x #","))))
       vec))

(defn straight-line?
  [[x1 y1 x2 y2]]
  (or (= x1 x2)
      (= y1 y2)))

(defn direction
  [start end]
  (cond
    (= start end) 0
    (pos? (- end start)) 1
    (neg? (- end start)) -1))

(defn unfold-line
  [[x1 y1 x2 y2]]
  (let [dx (direction x1 x2)
        dy (direction y1 y2)]
    (loop [acc [] x x1 y y1]
      (if (and (= x x2)  ; Lines are always either straight along an axis
               (= y y2)) ; or 45 degrees diagonally. No risk of infinite loop
        (conj acc [x y])
        (recur (conj acc [x y])
               (+ x dx)
               (+ y dy))))))

(defn overlapping-lines
  [lines]
  (->> lines
       (apply concat)
       frequencies
       (reduce-kv
        (fn [acc _ v]
          (if (>= v 2)
            (inc acc)
            acc))
        0)))

(defn solve-1
  [input]
  (->> input
       (map str->range)
       (filter straight-line?)
       (map unfold-line)
       overlapping-lines))

(defn solve-2
  [input]
  (->> input
       (map str->range)
       (map unfold-line)
       overlapping-lines))

(comment
  (solve-1 (get-input 5))
  (solve-2 (get-input 5)))
