(ns adv-2021.day-13
  (:require
   [adv-2021.core :refer [get-raw-input]]
   [clojure.string :as str]))

(defn parse-points
  [s]
  (->> s
       str/split-lines
       (map (fn [x] (vec (map #(Integer/parseInt %) (str/split x #",")))))))

(defn parse-instructions
  [s]
  (->> s
       str/split-lines
       (map #(vec (rest (re-find #"(x|y)=(\d+)" %))))
       (map (fn [[k v]] (vector k (Integer/parseInt v))))))

(defn parse-input
  [s]
  (let [[points, ins] (str/split s #"\n\n")]
    [(parse-points points) (parse-instructions ins)]))

(defn fold
  [xs axis line]
  (->> xs (map (fn [[x y]]
                 (if (= "x" axis)
                   [(if (> x line) (- (* 2 line) x) x) y]
                   [x (if (> y line) (- (* 2 line) y) y)])))))

(defn solve-1
  [input]
  (let [[points, ins] (parse-input input)]
    (->> ins
         (take 1)
         (reduce #(fold %1 (first %2) (second %2)) points)
         distinct
         count)))

(defn print-code
  [folded-paper]
  (let [max-x (first (apply max-key first folded-paper))
        max-y (second (apply max-key second folded-paper))
        m (into #{} folded-paper)]
    (doseq [y (range (inc max-y))
            x (range (inc max-x))]
      (when (= x 0) (println))
      (print (if (contains? m [x y]) " X" "  ")))))

(defn solve-2
  [input]
  (let [[points, ins] (parse-input input)]
    (->> ins
         (reduce #(fold %1 (first %2) (second %2)) points)
         print-code)))

(comment
  (solve-1 (get-raw-input 13))
  (solve-2 (get-raw-input 13)))
