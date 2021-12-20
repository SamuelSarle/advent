(ns adv-2021.day-20
  (:require
   [adv-2021.core :refer [get-raw-input]]
   [clojure.string :as str]))

(defn create-map
  [input]
  (first
   (reduce (fn [[acc cur-x cur-y] x]
             (if (= x "\n")
               [acc 0 (inc cur-y)]
               [(assoc acc [cur-x cur-y] (if (= "#" x) 1 0))
                (inc cur-x)
                cur-y]))
           [{} 0 0]
           (map str input))))

(defn format-rules
  "Format the rules so that keys are the same format
  as what the stencil returns for a position and val is what
  the pos should be transformed to.
  {(0 1 0 0 1 1 1 0 0 0) 1}"
  [s]
  (->> s
       (map-indexed
        (fn [k v] (let [k (->> (Integer/toString k 2)
                               (Integer/parseInt)
                               (format "%09d")
                               (map str)
                               (map #(Integer/parseInt %)))
                        v (if (= \# v) 1 0)]
                    [k v])))
       (into {})))

(defn stencil
  [m default x y]
  (for [dy [-1 0 1] dx [-1 0 1]]
    (get m [(+ x dx) (+ y dy)] default)))

(defn updated-inf
  [rules inf]
  (if (= 1 inf)
    (get rules (repeat 9 1))
    (get rules (repeat 9 0))))

(defn map-keys-to-check
  [m]
  (let [ks (keys m)
        [min-x max-x] ((juxt (partial apply min)
                             (partial apply max)) (map first ks))
        [min-y max-y] ((juxt (partial apply min)
                             (partial apply max)) (map second ks))]
    (for [x (range (dec min-x) (+ 2 max-x))
          y (range (dec min-y) (+ 2 max-y))]
      [x y])))

(defn step
  [rules m]
  (let [ks (map-keys-to-check (dissoc m :inf))
        inf (get m :inf 0)]
    (assoc (into {}
                 (map #(vector % (get rules (apply stencil m inf %))))
                 ks)
           :inf
           (updated-inf rules inf))))

(defn solve-1
  [input]
  (let [[rules m] (str/split input #"\n\n")
        rules (format-rules rules)
        m (create-map m)]
    (->> (nth (iterate (partial step rules) m) 2)
         (filter #(= 1 (val %)))
         count)))

(defn solve-2
  [input]
  (let [[rules m] (str/split input #"\n\n")
        rules (format-rules rules)
        m (create-map m)]
    (->> (nth (iterate (partial step rules) m) 50)
         (filter #(= 1 (val %)))
         count)))

(comment
  (solve-1 (get-raw-input 20))
  (solve-2 (get-raw-input 20)))
