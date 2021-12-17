(ns adv-2021.day-17
  (:require
   [adv-2021.core :refer [get-raw-input]]))

(defn parse-input
  [input]
  (->> input
       (re-find #"x=(-?\d+)\.\.(\-?\d+), y=(-?\d+)\.\.(\-?\d+)")
       rest
       (map #(Integer/parseInt %))
       vec))

(defn step
  [probe]
  (-> probe
      (assoc :x (+ (probe :x) (probe :dx)))
      (assoc :y (+ (probe :y) (probe :dy)))
      (assoc :dx (- (probe :dx) (Integer/signum (probe :dx))))
      (update :dy dec)))

(defn not-over-area?
  [probe [_ x y _]]
  (not
   (or (> (probe :x) x)
       (< (probe :y) y))))

(defn find-trajectory
  [dx dy target-area]
  (->> {:x 0 :y 0 :dx dx :dy dy}
       (iterate step)
       (take-while #(not-over-area? % target-area))))

(defn in-area?
  [probe [x1 x2 y1 y2]]
  (and (>= (probe :x) x1)
       (<= (probe :x) x2)
       (>= (probe :y) y1)
       (<= (probe :y) y2)))

(defn reached-target?
  [probe-trajectory target-area]
  (some #(in-area? % target-area) probe-trajectory))

(defn max-step-values
  [[x1 x2 y1 y2]]
  [(max (Math/abs x1)
        (Math/abs x2))
   (max (Math/abs y1)
        (Math/abs y2))])

(defn solve-1
  [input]
  (let [t (parse-input input)
        [max-x max-y] (max-step-values t)
        vs (for [dx (range (inc max-x)) dy (range (inc max-y))]
             [dx dy])]
    (->> vs
         (map (fn [[dx dy]] (find-trajectory dx dy t)))
         (filter #(reached-target? % t))
         (mapcat #(map :y %))
         (reduce max))))

(defn solve-2
  [input]
  (let [t (parse-input input)
        [_ _ min-y _] t
        [max-x max-y] (max-step-values t)
        vs (for [dx (range (inc max-x)) dy (range min-y (inc max-y))]
             [dx dy])]
    (->> vs
         (filter (fn [[dx dy]] (reached-target? (find-trajectory dx dy t) t)))
         count)))

(comment
  (solve-1 (get-raw-input 17))
  (solve-2 (get-raw-input 17)))
