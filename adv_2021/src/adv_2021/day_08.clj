(ns adv-2021.day-08
  (:require
   [adv-2021.core :refer [get-input]]
   [clojure.string :as str]))

(defn solve-1
  [input]
  (->> input
       (map #(second (str/split % #" \| ")))
       (mapcat #(str/split % #" "))
       (map count)
       (filter #{2 3 4 7})
       count))

(defn find-key-with-val
  [m val]
  (some (fn [[k v]] (if (= v val) k)) m))

(defn freq-to-char-map
  [signals]
  (->> (str/replace signals #"[^abcdefg]+" "")
       frequencies
       clojure.set/map-invert))

(defn initial-translations
  [signals]
  (let [freqs (freq-to-char-map signals)]
    (reduce (fn [acc [n letter]]
              (assoc acc (get freqs n) letter))
            {}
            [[4 "e"]
             [6 "b"]
             [9 "f"]])))

(defn add-remaining-translation
  [char num signals translations]
  (assoc translations
         (some #(and (not (get translations %)) %)
               (get signals num))
         char))

(defn translation-map
  [signals]
  (let [signal-counts (->> (str/split signals #" ")
                           (map #(vector (count %) %))
                           (into {}))]
    (->> (initial-translations signals)
         (add-remaining-translation "c" 2 signal-counts)
         (add-remaining-translation "d" 4 signal-counts)
         (add-remaining-translation "a" 3 signal-counts)
         (add-remaining-translation "g" 7 signal-counts))))

(defn translate
  [s translations]
  (reduce str (sort (replace translations s))))

(def segments->num
  (clojure.set/map-invert
   {0 "abcefg"
    1 "cf"
    2 "acdeg"
    3 "acdfg"
    4 "bcdf"
    5 "abdfg"
    6 "abdefg"
    7 "acf"
    8 "abcdefg"
    9 "abcdfg"}))

(defn line->num
  [line]
  (let [[signals output] (str/split line #" \| ")
        translations (translation-map signals)]
    (->> (str/split output #" ")
         (map #(translate % translations))
         (map #(segments->num %))
         (reduce str)
         Integer/parseInt)))

(defn solve-2
  [input]
  (->> input
       (map line->num)
       (apply +)))

(comment
  (solve-1 (get-input 8))
  (solve-2 (get-input 8)))
