(ns adv-2021.day-04
  (:require
   [adv-2021.core :refer [get-raw-input]]
   [clojure.string :as str]))

(def rows 5)
(def cols 5)

(defn new-board
  ([] (new-board []))
  ([board] board))

(defn board-add-row
  [board row]
  (when (= cols (count row))
    (apply conj board row)))

(defn row-col->board-pos
  [[row col]]
  (+ (* row cols) col))

(defn board-remaining-vals
  [board]
  (remove nil? board))

(defn board-remove-num
  [board n]
  (mapv #(when (not= n %) %) board))

(defn str->draws
  [s]
  (map #(Integer/parseInt %) (str/split s #",")))

(defn str->board
  [s]
  (->> s
       str/split-lines
       (map str/trim)
       (map (fn [s] (map #(Integer/parseInt %) (str/split s #" +"))))
       (reduce #(board-add-row %1 %2) (new-board))))

(defmacro bingo?
  "Create the tree of conditionals and board accesssors at compile time.
  (bingo? []) -> (or (not (or (nth [] 0)
                              (nth [] 1)
                              (nth [] 2)
                              (nth [] 3)
                              (nth [] 4)))
                     (not (or ...))
                     (not (or ...))
                     ...)
  The individual (not (or ...)) branches are rows and cols over the board.
  We check if any of them contain a value, if there is some number left in
  that row/col, it can't be the winning row/col and we check the next one."
  [board]
  `(or ~@(for [cols (vector (vec (range cols)))
               row (range rows)]
           `(not (or ~@(for [col cols]
                         `(nth ~board ~(row-col->board-pos [row col]))))))
       ~@(for [rows (vector (vec (range rows)))
               col (range cols)]
           `(not (or ~@(for [row rows]
                         `(nth ~board ~(row-col->board-pos [row col]))))))))

(defn play-boards-until-winner
  [draws boards]
  (loop [draws draws
         boards boards]
    (let [cur-draw (first draws)
          new-boards (map #(board-remove-num % cur-draw) boards)
          winning-board (first (filter #(bingo? %) new-boards))]
      (if winning-board
        [cur-draw winning-board]
        (recur (rest draws) new-boards)))))

(defn calculate-score
  [last-draw winning-board]
  (* last-draw
     (apply + (board-remaining-vals winning-board))))

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
          new-boards (map #(board-remove-num % cur-draw) boards)]
      (if (and (= 1 (count new-boards))
               (bingo? (first new-boards)))
        [cur-draw (first new-boards)]
        (recur (rest draws) (remove #(bingo? %) new-boards))))))

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
