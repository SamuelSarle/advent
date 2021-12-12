(ns adv-2021.day-12
  (:require
   [adv-2021.core :refer [get-input]]
   [clojure.string :as str]))

(defn small-cave?
  [s]
  (= s (str/lower-case s)))

(defn str->graph
  [input]
  (let [edges (->> input
                   (map #(str/split % #"-"))
                   (map #(if (= "start" (second %)) [(second %) (first %)] %)))
        reverse-edges (->> edges (map reverse) (filter #(not= "start" (second %))))]
    (reduce
     #(update %1 (first %2) conj (second %2))
     {}
     (concat edges reverse-edges))))

(defn dfs
  ([graph] (dfs graph "start" [] #{}))
  ([graph start current-path visited]
   (if (= "end" start)
     [(conj current-path start)]
     (when-not (and (small-cave? start)
                    (visited start))
       (mapcat #(dfs graph
                     %
                     (conj current-path start)
                     (conj visited start))
               (get graph start))))))

(defn solve-1
  [input]
  (->> input
       str->graph
       dfs
       count))

(defn dfs-2
  ([graph] (dfs-2 graph "start" [] #{} 1))
  ([graph start current-path visited revisit]
   (if (= "end" start)
     [(conj current-path start)]
     (let [successors #(get graph start)
           current-path (conj current-path start)
           new-visited (conj visited start)]
       (cond
         ;; It's a small cave and we've already visited it,
         ;; can't proceed further.
         (and (small-cave? start)
              (visited start))
         nil

         ;; It's a small cave and we haven't yet used our one chance
         ;; at revisiting a cave. Concat the two recursive searches
         ;; where we either have or haven't used up our revisit on
         ;; the current position.
         (and (= 1 revisit)
              (small-cave? start)
              (not= start "start"))
         (concat
          (mapcat #(dfs-2 graph % current-path visited 0) (successors))
          (mapcat #(dfs-2 graph % current-path new-visited 1) (successors)))

         ;; It's either a small cave and we don't have a revisiting chance
         ;; anymore or it's a large cave.
         :else
         (mapcat #(dfs-2 graph
                         %
                         current-path
                         new-visited
                         revisit)
                 (successors)))))))

(defn solve-2
  [input]
  (->> input
       str->graph
       dfs-2
       distinct
       count))

(comment
  (solve-1 (get-input 12))
  (solve-2 (get-input 12)))
