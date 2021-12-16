(ns adv-2021.day-16
  (:require
   [adv-2021.core :refer [get-raw-input]]
   [clojure.string :as str]))

(defn bin->long [bin] (Long/parseLong bin 2))

(defn hex->bin
  [hex]
  (->> hex
       (map str)
       (map #(Integer/parseInt % 16))
       (map #(Integer/toBinaryString %))
       (map #(Integer/parseInt % 10))
       (map #(format "%04d" %))
       (reduce str)))

(defn str-take
  [s n]
  (->> s (split-at n) (map #(apply str %))))

(defn parse-literal
  [bin packet]
  (let [[v bin] (str-take bin 5)]
    (if (str/starts-with? v "0")
      [(->> (subs v 1)
            (conj (packet :values))
            (apply str)
            bin->long
            (assoc packet :value))
       bin]
      (recur bin (assoc packet :values (conj (get packet :values []) (subs v 1)))))))

(declare parse-packet parse-n-packets parse-all-packets)

(defn parse-operator
  [bin packet]
  (let [[length-type bin] (str-take bin 1)]
    (if (= 0 (bin->long length-type))
      (let [[total-length bin] (str-take bin 15)
            [subpackets bin] (str-take bin (bin->long total-length))
            subpackets (parse-all-packets subpackets)]
        [(assoc packet :subpackets subpackets) bin])
      (let [[subpacket-n bin] (str-take bin 11)
            [subpackets bin] (parse-n-packets bin (bin->long subpacket-n))]
        [(assoc packet :subpackets subpackets) bin]))))

(defn parse-packet
  [bin]
  (let [[version bin] (str-take bin 3)
        [type bin] (str-take bin 3)]
    (when (some #(= \1 %) (str version type bin))
      (let [packet {:version (bin->long version) :type (bin->long type)}]
        (if (= 4 (packet :type))
          (parse-literal bin packet)
          (parse-operator bin packet))))))

(defn parse-n-packets
  [bin n]
  (->
   (iterate (fn [[packets bin]]
              (let [[packet bin] (parse-packet bin)]
                [(conj packets packet) bin]))
            [[] bin])
   (nth n)))

(defn parse-all-packets
  [bin]
  (loop [bin bin
         packets []]
    (if-let [[packet bin] (parse-packet bin)]
      (recur bin (conj packets packet))
      packets)))

(defn solve-1
  [input]
  (->> (str/trim input)
       hex->bin
       parse-packet
       first ; drop any remaining binary string
       (tree-seq :subpackets :subpackets)
       (map :version)
       (apply +)))

(defn eval-packet
  [packet]
  (let [subpackets (map eval-packet (packet :subpackets))]
    (case (packet :type)
      0 (apply + subpackets)
      1 (apply * subpackets)
      2 (reduce min subpackets)
      3 (reduce max subpackets)
      4 (packet :value)
      5 (if (apply > subpackets) 1 0)
      6 (if (apply < subpackets) 1 0)
      7 (if (apply = subpackets) 1 0))))

(defn solve-2
  [input]
  (->> (str/trim input)
       hex->bin
       parse-packet
       first ; drop any remaining binary string
       eval-packet))

(comment
  (solve-1 (get-raw-input 16))
  (solve-2 (get-raw-input 16)))
