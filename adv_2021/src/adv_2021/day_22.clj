(ns adv-2021.day-22
  (:require
   [adv-2021.core :refer [get-input]]))

(defn create-box
  [[[x1 x2] [y1 y2] [z1 z2]]]
  {:x1 x1 :x2 x2 :y1 y1 :y2 y2 :z1 z1 :z2 z2})

(defn parse-input
  [s]
  [(last (re-find #"^(on|off) " s))
   (->> s
        (re-find #"x=(-?\d+)\.\.(-?\d+),y=(-?\d+)\.\.(-?\d+),z=(-?\d+)\.\.(-?\d+)")
        rest
        (map #(Integer/parseInt %))
        (partition 2)
        create-box)])

(defn apply-initialization-instructions
  [s ins box]
  (let [op (if (= ins "on") conj disj)]
    (reduce
     op
     s
     (for [x (range (max (:x1 box) -50) (min (inc (:x2 box)) 51))
           y (range (max (:y1 box) -50) (min (inc (:y2 box)) 51))
           z (range (max (:z1 box) -50) (min (inc (:z2 box)) 51))]
       [x y z]))))

(defn solve-1
  [input]
  (let [ins (map parse-input input)]
    (count
     (reduce
      #(apply-initialization-instructions %1 (first %2) (second %2))
      #{}
      ins))))

(defn intersecting?
  [box1 box2]
  (not
   (or (> (:x1 box2) (:x2 box1)) (< (:x2 box2) (:x1 box1))
       (> (:y1 box2) (:y2 box1)) (< (:y2 box2) (:y1 box1))
       (> (:z1 box2) (:z2 box1)) (< (:z2 box2) (:z1 box1)))))

(defn volume
  [box]
  (* (Math/abs (- (:x1 box) (inc (:x2 box))))
     (Math/abs (- (:y1 box) (inc (:y2 box))))
     (Math/abs (- (:z1 box) (inc (:z2 box))))))

(defn cut-out
  [box cut]
  (if (not (intersecting? box cut))
    [box]
    (remove
     nil?
     [;;top and bottom
      (if (< (:y1 box) (:y1 cut)) {:x1 (:x1 box)
                                   :x2 (:x2 box)
                                   :y1 (:y1 box)
                                   :y2 (dec (:y1 cut))
                                   :z1 (:z1 box)
                                   :z2 (:z2 box)})
      (if (> (:y2 box) (:y2 cut)) {:x1 (:x1 box)
                                   :x2 (:x2 box)
                                   :y1 (inc (:y2 cut))
                                   :y2 (:y2 box)
                                   :z1 (:z1 box)
                                   :z2 (:z2 box)})
      ;;left and right
      (if (< (:x1 box) (:x1 cut)) {:x1 (:x1 box)
                                   :x2 (dec (:x1 cut))
                                   :y1 (max (:y1 box) (:y1 cut))
                                   :y2 (min (:y2 box) (:y2 cut))
                                   :z1 (:z1 box)
                                   :z2 (:z2 box)})
      (if (> (:x2 box) (:x2 cut)) {:x1 (inc (:x2 cut))
                                   :x2 (:x2 box)
                                   :y1 (max (:y1 box) (:y1 cut))
                                   :y2 (min (:y2 box) (:y2 cut))
                                   :z1 (:z1 box)
                                   :z2 (:z2 box)})
      ;;front and back
      (if (< (:z1 box) (:z1 cut)) {:x1 (max (:x1 box) (:x1 cut))
                                   :x2 (min (:x2 box) (:x2 cut))
                                   :y1 (max (:y1 box) (:y1 cut))
                                   :y2 (min (:y2 box) (:y2 cut))
                                   :z1 (:z1 box)
                                   :z2 (dec (:z1 cut))})
      (if (> (:z2 box) (:z2 cut)) {:x1 (max (:x1 box) (:x1 cut))
                                   :x2 (min (:x2 box) (:x2 cut))
                                   :y1 (max (:y1 box) (:y1 cut))
                                   :y2 (min (:y2 box) (:y2 cut))
                                   :z1 (inc (:z2 cut))
                                   :z2 (:z2 box)})])))

(defn solve-2
  [input]
  (let [ins (map parse-input input)]
    (->> ins
         (reduce
          (fn [acc [cmd box]]
            (let [acc (mapcat #(cut-out % box) acc)]
              (if (= cmd "on")
                (conj acc box)
                acc)))
          [])
         (map volume)
         (apply +))))

(comment
  (solve-1 (get-input 22))
  (solve-2 (get-input 22)))
