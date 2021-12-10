(ns adv-2021.day-10
  (:require
   [adv-2021.core :refer [get-input]]))

(def opening-char-for
  {\} \{
   \] \[
   \) \(
   \> \<})

(defn closing-char?
  [char]
  (contains? opening-char-for char))

(defn errors
  [input]
  (loop [line (seq input)
         stack (list)]
    (let [char (first line)]
      (cond
        (empty? line) (if stack {:missing-chars stack} {})

        (closing-char? char) (if (= (peek stack)
                                    (opening-char-for char))
                               (recur (rest line)
                                      (rest stack))
                               {:illegal-char char})

        :else (recur (rest line)
                     (conj stack char))))))

(def illegal-char-scores
  {\) 3
   \] 57
   \} 1197
   \> 25137})

(defn solve-1
  [input]
  (->> input
       (map errors)
       (keep :illegal-char)
       (map illegal-char-scores)
       (apply +)))

(def missing-char-scores
  {\( 1
   \[ 2
   \{ 3
   \< 4})

(defn count-score
  [missing-chars]
  (->> missing-chars
       (map missing-char-scores)
       (reduce #(+ %2 (* 5 %1)) 0)))

(defn solve-2
  [input]
  (let [scores (->> input
                    (map errors)
                    (keep :missing-chars)
                    (map count-score)
                    sort)]
    (nth scores (Math/floor (/ (count scores) 2)))))

(comment
  (solve-1 (get-input 10))
  (solve-2 (get-input 10)))
