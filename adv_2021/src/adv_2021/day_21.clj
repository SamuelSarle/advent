(ns adv-2021.day-21
  (:require
   [adv-2021.core :refer [get-input]]))

(defn next-roll [dice] (inc (mod dice 100)))

(defn rolls
  []
  (->> (iterate next-roll 1)
       (partition 6)
       (mapcat #(vector
                 [:one (take 3 %)]
                 [:two (drop 3 %)]))))

(def move
  (let [board (cycle (range 1 11))]
    (fn [score position rolls]
      (let [pos (nth board (dec (apply + position rolls)))]
        [(+ score pos) pos]))))

(defn play
  [rolls one two]
  (loop [rolls rolls
         rolled []
         [one-score one-pos] [0 one]
         [two-score two-pos] [0 two]]
    (let [roll (first rolls)
          player (first roll)
          moves (second roll)]
      (cond
        (>= one-score 1000) (* two-score (count rolled))
        (>= two-score 1000) (* one-score (count rolled))
        (= player :one) (recur (rest rolls)
                               (apply conj rolled (second roll))
                               (move one-score one-pos moves)
                               [two-score two-pos])
        (= player :two) (recur (rest rolls)
                               (apply conj rolled (second roll))
                               [one-score one-pos]
                               (move two-score two-pos moves))))))

(defn solve-1
  [input]
  (let [[one two] (->> input
                       (map #(last (re-find #"position: \d+$" %)))
                       (map #(Integer/parseInt (str %))))]
    (play (rolls) one two)))

(def play-dirac
  (let [rolls (for [x [1 2 3] y [1 2 3] z [1 2 3]]
                [x y z])]
    (memoize
     (fn [[one-score one-pos] [two-score two-pos] turn]
       (apply
        mapv +'
        (cond
          (>= one-score 21) [[1 0]]
          (>= two-score 21) [[0 1]]
          (= turn :one) (->> rolls
                             (map #(move one-score one-pos %))
                             (map #(play-dirac % [two-score two-pos] :two)))
          (= turn :two) (->> rolls
                             (map #(move two-score two-pos %))
                             (map #(play-dirac [one-score one-pos] % :one)))))))))

(defn solve-2
  [input]
  (let [[one two] (->> input
                       (map #(last (re-find #"position: \d+$" %)))
                       (map #(Integer/parseInt (str %))))]
    (apply max (play-dirac [0 one] [0 two] :one))))

(comment
  (solve-1 (get-input 21))
  (solve-2 (get-input 21)))
