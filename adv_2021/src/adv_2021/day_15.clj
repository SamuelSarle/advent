(ns adv-2021.day-15
  (:require
   [adv-2021.core :refer [get-raw-input]]
   [clojure.data.priority-map :refer [priority-map]]))

(defn create-map
  [input]
  (first
   (reduce (fn [[acc cur-x cur-y] x]
             (if (= x "\n")
               [acc 0 (inc cur-y)]
               [(assoc acc [cur-x cur-y] (Integer/parseInt x)) (inc cur-x) cur-y]))
           [{} 0 0]
           (map str input))))

(defn get-start-end
  [m]
  [[0 0]
   (reduce #(cond
              (> (first %2) (first %1)) %2
              (> (second %2) (second %1)) %2
              :else %1)
           [0 0]
           (keys m))])

(defn neighbours
  [[x y]]
  (for [[dx dy] [[-1 0] [1 0] [0 -1] [0 1]]]
    [(+ x dx) (+ y dy)]))

(defn dijkstra
  "From https://en.wikipedia.org/wiki/Dijkstra's_algorithm"
  [m start end]
  (let [dist (zipmap (keys m) (repeat Integer/MAX_VALUE))]
    (loop [[queue dist prev] [(priority-map start 0) (assoc dist start 0) {}]]
      (if-let [u (first (peek queue))]
        (if (= end u)
          dist
          (recur (reduce
                  (fn [[q d p] [k v]]
                    (let [alt (+ v (get d u))]
                      (if (< alt (get d k))
                        [(assoc q k alt) (assoc d k alt) (assoc p k u)]
                        [q d p])))
                  [(dissoc queue u) dist prev]
                  (->> (neighbours u) (keep #(if-let [v (get m %)] [% v]))))))))))

(defn five-times-m
  [m]
  (let [max-x (inc (apply max (map (comp first first) m)))
        max-y (inc (apply max (map (comp second first) m)))]
    (apply merge
           m
           (for [dx (range 0 5) dy (range 0 5)
                 :when (or (not= 0 dx)
                           (not= 0 dy))]
             (->> m
                  (map (fn [[[x y] v]]
                         [[(+ x (* max-x dx)) (+ y (* max-y dy))]
                          (inc (rem (dec (+ v dx dy)) 9))]))
                  (into {}))))))

(defn solve-1
  [input]
  (let [m (create-map input)
        [start end] (get-start-end m)
        dists (dijkstra m start end)]
    (get dists end)))

(defn solve-2
  [input]
  (let [m (five-times-m (create-map input))
        [start end] (get-start-end m)
        dists (dijkstra m start end)]
    (get dists end)))

(comment
  (solve-1 (get-raw-input 15))
  (solve-2 (get-raw-input 15)))
