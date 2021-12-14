(ns adv-2021.day-14
  (:require
   [adv-2021.core :refer [get-raw-input]]
   [clojure.string :as str]))

(defn parse-rules
  [s]
  (->> s
       str/split-lines
       (map #(vec (rest (re-find #"(\w{2}) -> (\w)" %))))
       (map (fn [[k v]] [k [(str (first k) v) (str v (second k))]]))
       (into {})))

(defn parse-start-template
  [s]
  (->> s
       (partition 2 1 " ") ; pad with " " so that last element is "B "
       (map #(apply str %))
       frequencies))

(defn parse-input
  [input]
  (let [[t r] (str/split input #"\n\n")]
    [(parse-start-template t) (parse-rules r)]))

(defn apply-insertion
  [m rules]
  (reduce (fn [acc [k v]]
            (reduce
             #(assoc %1 %2 (+ v (get %1 %2 0)))
             acc
             (get rules k [k]))) ; any key not in rules will be
          {}                     ; mapped to only itself
          m))

(defn element-counts
  [m]
  (->> m
       (map (fn [[k v]] {(str (first k)) v}))
       (apply merge-with +)))

(defn max-minus-min-element
  [m]
  (->> m
       element-counts
       vals
       ((juxt (partial apply max)
              (partial apply min)))
       (apply -)))

(defn solve-1
  [input]
  (let [[start rules] (parse-input input)]
    (->> (nth (iterate #(apply-insertion % rules) start) 10)
         (max-minus-min-element))))

(defn solve-2
  [input]
  (let [[start rules] (parse-input input)]
    (->> (nth (iterate #(apply-insertion % rules) start) 40)
         (max-minus-min-element))))

(comment
  (solve-1 (get-raw-input 14))
  (solve-2 (get-raw-input 14)))
