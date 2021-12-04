(ns adv-2021.day-04
  (:require
   [adv-2021.core :refer [get-raw-input]]
   [clojure.string :as str]))

(def rows 5)
(def cols 5)

(defn str->draws
  [s]
  (map
   #(Integer/parseInt %)
   (-> s
       (str/split #"\n")
       first
       (str/split #","))))

(defn str->board
  [s]
  (->> s
       str/split-lines
       (map str/trim)
       (map (fn [s] (map #(Integer/parseInt %) (str/split s #" +"))))
       (map #(vector %1 (vec %2)) (range rows))
       (reduce (fn [acc [row xs]]
                 (apply
                  merge
                  acc
                  (for [col (range cols)]
                    {[row col] (nth xs col)})))
               (sorted-map))))

(defn row-completed?
  [row board]
  (->> board
       keys
       (filter (fn [[r _]] (= r row)))
       count
       (= 0)))

(defn col-completed?
  [col board]
  (->> board
       keys
       (filter (fn [[_ c]] (= c col)))
       count
       (= 0)))

(defn bingo?
  [board]
  (some identity
        (concat
         (for [row (range rows)]
           (row-completed? row board))
         (for [col (range cols)]
           (col-completed? col board)))))

(defn remove-num
  [n board]
  (->> board
       (remove #(= n (val %)))
       (into {})))

(defn play-boards-until-winner
  [draws boards]
  (loop [draws draws
         boards boards]
    (let [cur-draw (first draws)
          new-boards (map #(remove-num cur-draw %) boards)
          winning-board (first (seq (filter bingo? new-boards)))]
      (if winning-board
        [cur-draw winning-board]
        (recur (rest draws) new-boards)))))

(defn calculate-score
  [last-draw winning-board]
  (* last-draw
     (apply + (vals winning-board))))

(defn solve-1
  [input]
  (let [split-input (str/split input #"\n\n")
        draws (str->draws (first split-input))
        boards (map str->board (rest split-input))]
    (->> boards
         (play-boards-until-winner draws)
         (apply calculate-score))))

(defn play-boards-until-last-winner
  [draws boards]
  (loop [draws draws
         boards boards]
    (let [cur-draw (first draws)
          new-boards (map #(remove-num cur-draw %) boards)]
      (if (and (= 1 (count new-boards))
               (bingo? (first new-boards)))
        [cur-draw (first new-boards)]
        (recur (rest draws) (remove bingo? new-boards))))))

(defn solve-2
  [input]
  (let [split-input (str/split input #"\n\n")
        draws (str->draws (first split-input))
        boards (map str->board (rest split-input))]
    (->> boards
         (play-boards-until-last-winner draws)
         (apply calculate-score))))

(comment
  (solve-1 (get-raw-input 4))
  (solve-2 (get-raw-input 4)))
