(ns adv-2021.day-03
  (:require
   [adv-2021.core :refer [get-input]]
   [clojure.string :as str]))

(defn character-positions
  "Transform \"00100\" to ([0 \"0\"] [1 \"0\"] [2 \"1\"] [3 \"0\"] [4 \"0\"])"
  [s]
  (map-indexed #(vector % %2) (str/split s #"")))

(defn gamma-rate
  "Given a map with lists of characters at positions
  {0 [\"0\" \"1\" \"0\"] 1 [\"1\" \"1\" \"0\"]}, returns the most
  common characters (\"0\" \"1\") sorted by position key."
  [xs]
  (for [pos (sort (keys xs))]
    (->> pos
         (get xs)
         frequencies
         (apply max-key val)
         first)))

(defn epsilon-rate
  "Given a map with lists of characters at positions
  {0 [\"0\" \"1\" \"0\"] 1 [\"1\" \"1\" \"0\"]}, returns the least
  common characters (\"1\" \"0\") sorted by position key."
  [xs]
  (for [pos (sort (keys xs))]
    (->> pos
         (get xs)
         frequencies
         (apply min-key val)
         first)))

(defn create-character-map
  "Transform input of strings to a map where keys correspond to
  positions in string and val corresponds to the characters
  in input strings at that position.
  [\"foo\" \"bar\" \"bazz\"] -> {0 [\"f\" \"b\" \"b\"], 1 [\"o\" \"a\" \"a\"], 2 [\"o\" \"r\" \"z\"], 3 [\"z\"]}"
  [input]
  (->> input
       (mapcat character-positions)
       (reduce (fn [acc [k v]]
                 (if (contains? acc k)
                   (update acc k conj v)
                   (assoc acc k [v])))
               {})))

(defn solve-1
  [input]
  (->> input
       create-character-map
       ((juxt gamma-rate epsilon-rate))
       (map #(reduce str %))
       (map #(Integer/parseInt % 2))
       (apply *)))

(defn character-at-pos=?
  [s c pos]
  (= c (nth (seq s) pos)))

(defn oxygen-generator-rating
  [xs]
  (loop [xs xs
         index 0]
    (if (= 1 (count xs))
      (first xs)
      (let [freqs (frequencies (map #(nth (seq %) index) xs))
            most-common (or (and (apply = (map val freqs))
                                 \1)
                            (first (apply
                                    max-key
                                    val
                                    freqs)))]
        (recur (filter #(character-at-pos=? % most-common index) xs)
               (inc index))))))

(defn co2-scrubber-rating
  [xs]
  (loop [xs xs
         index 0]
    (if (= 1 (count xs))
      (first xs)
      (let [freqs (frequencies (map #(nth (seq %) index) xs))
            least-common (or (and (apply = (map val freqs))
                                  \0)
                             (first (apply
                                     min-key
                                     val
                                     freqs)))]
        (recur (filter #(character-at-pos=? % least-common index) xs)
               (inc index))))))

(defn solve-2
  [input]
  (->> input
       ((juxt oxygen-generator-rating co2-scrubber-rating))
       (map #(reduce str %))
       (map #(Integer/parseInt % 2))
       (apply *)))

(comment
  (prn (solve-1 (get-input 3)))
  (prn (solve-2 (get-input 3))))
