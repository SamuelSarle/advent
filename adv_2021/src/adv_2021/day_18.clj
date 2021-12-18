(ns adv-2021.day-18
  (:require
   [adv-2021.core :refer [get-input]]
   [clojure.zip :as z]))

(defn parse
  [input]
  (read-string input))

(defn add-left
  [n tree]
  (let [prv (z/prev tree)]
    (if (nil? (second prv))
      tree
      (z/next
       (if (z/branch? prv)
         (add-left n prv)
         (z/edit prv (partial + n)))))))

(defn add-right
  [n tree]
  (let [nxt (z/next tree)]
    (if (z/end? nxt)
      tree
      (z/prev
       (if (z/branch? nxt)
         (add-right n nxt)
         (z/edit nxt (partial + n)))))))

(defn explode-all
  [z]
  (loop [z z]
    (let [node (z/node z)]
      (cond
        (z/end? z) z

        (and (vector? node)
             (not (some vector? node))
             (<= 4 (count (z/path z))))
        (let [[l r] node]
          (recur
           (->> (z/replace z 0)
                (add-right r)
                (add-left l))))

        :else (recur (z/next z))))))

(defn split-snailfish-num
  [n]
  (mapv int (vector (Math/floor (/ n 2)) (Math/ceil (/ n 2)))))

(defn split-one
  [z]
  (loop [z z]
    (let [node (z/node z)]
      (cond
        (z/end? z) z

        (and (number? node)
             (<= 10 node))
        (z/replace z (split-snailfish-num node))

        :else (recur (z/next z))))))

(defn back-to-root [z] (-> z z/root z/vector-zip))

(defn reduce-snailfish-num
  [z]
  (loop [z z mode :explode]
    (case mode
      :explode (recur (-> z explode-all back-to-root) :split)
      :split (let [s (split-one z)]
               (if (z/end? s)
                 (back-to-root s)
                 (recur s :explode))))))

(defn magnitude
  [z]
  (if (z/branch? z)
    (+ (* 3 (magnitude (z/down z)))
       (* 2 (magnitude (z/right (z/down z)))))
    (z/node z)))

(defn solve-1
  [input]
  (let [xs (->> input (map parse))
        start (-> xs first z/vector-zip)]
    (->> (rest xs)
         (reduce #(reduce-snailfish-num
                   (z/append-child
                    (z/edit %1 (partial vector))
                    %2))
                 start)
         magnitude)))

(defn solve-2
  [input]
  (let [nums (->> input (map parse))]
    (->> (for [x nums y nums :when (not= x y)]
           [[x y] [y x]])
         (mapcat #(vector (first %) (second %)))
         (pmap #(reduce-snailfish-num (z/vector-zip %)))
         (map magnitude)
         (reduce max))))

(comment
  (solve-1 (get-input 18))
  (solve-2 (get-input 18)))
