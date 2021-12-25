(ns adv-2021.day-25
  (:require
   [adv-2021.core :refer [get-raw-input]]))

(defn create-map
  [input]
  (let [[m w h] (reduce (fn [[acc cur-x cur-y] x]
                          (if (= x "\n")
                            [acc 0 (inc cur-y)]
                            [(assoc acc [cur-x cur-y] x)
                             (inc cur-x)
                             cur-y]))
                        [{} 0 0]
                        (map str (clojure.string/trim-newline input)))]
    [(into {} (remove #(= "." (val %))) m) w (inc h)]))

(defn movables
  [m sym dx dy mx my]
  (->> m
       (filter #(= sym (val %)))
       (remove (fn [[[x y] _]]
                 (get m [(mod (+ dx x) mx)
                         (mod (+ dy y) my)])))))

(defn move
  [m moves dx dy mx my]
  (reduce
   (fn [acc [[x y] v]]
     (-> acc
         (dissoc [x y])
         (assoc [(mod (+ dx x) mx)
                 (mod (+ dy y) my)] v)))
   m moves))

(defn solve-1
  [input]
  (let [[m w h] (create-map input)]
    (loop [m m c 1]
      (let [easts (movables m ">" 1 0 w h)
            m (move m easts 1 0 w h)
            souths (movables m "v" 0 1 w h)
            m (move m souths 0 1 w h)]
        (if (and (empty? easts)
                 (empty? souths))
          c
          (recur m (inc c)))))))

(comment
  (solve-1 (get-raw-input 25)))
