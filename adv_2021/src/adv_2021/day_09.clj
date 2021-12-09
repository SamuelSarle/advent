(ns adv-2021.day-09
  (:require
   [adv-2021.core :refer [get-raw-input]]))

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

(def neighbours [[-1 0] [1 0] [0 -1] [0 1]])

(defn neighbours-for
  [[x y]]
  (for [[dx dy] neighbours]
    [(+ x dx) (+ y dy)]))

(defn low-point?
  [m [x y]]
  (let [val (get m [x y])]
    (->> [x y]
         neighbours-for
         (map (partial get m))
         (not-any? #(and (not= % nil)
                         (<= % val))))))

(defn solve-1
  [input]
  (let [m (create-map input)]
    (->> m
         keys
         (filter (partial low-point? m))
         (map (partial get m))
         (map inc)
         (apply +))))

(defn valid-basin-neighbours
  [m low-point]
  (let [low-val (get m low-point)]
    (->> low-point
         neighbours-for
         (filter #(let [val (get m %)]
                    (and (not= val nil)
                         (not= val 9)
                         (< low-val val)))))))

(defn basin
  [m lowest-point]
  (loop [basin #{lowest-point}
         to-be-checked (valid-basin-neighbours m lowest-point)]
    (if (empty? to-be-checked)
      basin
      (let [low-point (first to-be-checked)
            valid-neighbours (valid-basin-neighbours m low-point)
            to-be-checked (apply conj (rest to-be-checked) valid-neighbours)]
        (recur (conj basin low-point)
               to-be-checked)))))

(defn solve-2
  [input]
  (let [m (create-map input)]
    (->> m
         keys
         (filter (partial low-point? m))
         (map (partial basin m))
         (map count)
         (sort >)
         (take 3)
         (apply *))))

(comment
  (solve-1 (get-raw-input 9))
  (solve-2 (get-raw-input 9)))
