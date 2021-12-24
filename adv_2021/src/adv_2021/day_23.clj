(ns adv-2021.day-23
  (:require
   [adv-2021.core :refer [get-raw-input]]
   [clojure.data.priority-map :refer [priority-map]]))

(defn parse-positions
  [s]
  (let [[a1 b1 c1 d1 a2 b2 c2 d2]
        (rest (re-find #"#{13}\n#.{11}#\n###([A-D])#([A-D])#([A-D])#([A-D])###\n  #([A-D])#([A-D])#([A-D])#([A-D])#" s))]
    {:a (list (keyword a1) (keyword a2))
     :b (list (keyword b1) (keyword b2))
     :c (list (keyword c1) (keyword c2))
     :d (list (keyword d1) (keyword d2))}))

(defn unfold-input
  [positions]
  (let [[a1 a2] (:a positions)
        [b1 b2] (:b positions)
        [c1 c2] (:c positions)
        [d1 d2] (:d positions)]
    (-> positions
        (assoc :a [a1 :D :D a2])
        (assoc :b [b1 :C :B b2])
        (assoc :c [c1 :B :A c2])
        (assoc :d [d1 :A :C d2]))))

(def paths-from
 {:h1 [:h2]
  :h2 [:h1 :h3]
  :h3 [:h2 :a :h4]
  :h4 [:h3 :h5]
  :h5 [:h4 :b :h6]
  :h6 [:h5 :h7]
  :h7 [:h6 :c :h8]
  :h8 [:h7 :h9]
  :h9 [:h8 :d :h10]
  :h10 [:h9 :h11]
  :h11 [:h10]
  :a [:h3]
  :b [:h5]
  :c [:h7]
  :d [:h9]})

(def hallway-rooms #{:h1 :h2 :h3 :h4 :h5 :h6 :h7 :h8 :h9 :h10 :h11})
(def is-door? #{:h3 :h5 :h7 :h9})

(defn dijsktra-valid-paths-from
  "From https://en.wikipedia.org/wiki/Dijkstra's_algorithm"
  [graph start]
  (loop [[queue dist prev] [(priority-map start 0) (assoc {} start 0) {}]]
    (let [u (first (peek queue))]
      (if (nil? u)
        (dissoc dist start)
        (recur (reduce
                (fn [[q d p] k]
                  (let [alt (inc (get d u))]
                    (if (< alt (get d k Integer/MAX_VALUE))
                      [(assoc q k alt) (assoc d k alt) (assoc p k u)]
                      [q d p])))
                [(dissoc queue u) dist prev]
                (->> (paths-from u)
                     (remove #(or (and (graph %)
                                       (not (sequential? (graph %))))
                                  (dist %))))))))))

(defn energy-cost
  [path-length amphipod]
  (* path-length (case amphipod :A 1 :B 10 :C 100 :D 1000)))

(defn finished?
  [positions]
  (and (every? #{:A} (:a positions))
       (every? #{:B} (:b positions))
       (every? #{:C} (:c positions))
       (every? #{:D} (:d positions))
       (every? nil? (for [k [:h1 :h2 :h3 :h4 :h5 :h6 :h7 :h8 :h9 :h10 :h11]]
                      (positions k)))))

(defn own-room?
  [pos type]
  (case type
    :A (= :a pos)
    :B (= :b pos)
    :C (= :c pos)
    :D (= :d pos)))

(defn own-room-available?
  [positions type]
  (case type
    :A (not (some #{:B :C :D} (:a positions)))
    :B (not (some #{:A :C :D} (:b positions)))
    :C (not (some #{:B :A :D} (:c positions)))
    :D (not (some #{:B :C :A} (:d positions)))))

(defn can-move?
  [positions cur-pos type target-pos]
  (cond
    (and (own-room? cur-pos type)
         (own-room-available? positions type))
    false

    (hallway-rooms cur-pos)
    (and (own-room? target-pos type)
         (own-room-available? positions type))

    :else
    (hallway-rooms target-pos)))

(defn path-length-leaving-room
  [path room depth]
  (+ path (- depth (count room))))

(defn path-length-entering-room
  [path room]
  (+ path (count room)))

(defn steps-from
  [state]
  (remove nil?
          (flatten
           (concat
            (for [room [:a :b :c :d]]
              (if (and (not= 0 (count (get-in state [:positions room] [])))
                       (some #(not (own-room? room %)) (get-in state [:positions room] [])))
                (let [type (first (get-in state [:positions room]))]
                  (->> (dijsktra-valid-paths-from (:positions state) room)
                       (remove #(is-door? (first %)))
                       (filter #(can-move? (:positions state) room type (first %)))
                       (map (fn [[new-pos path-l]]
                              (-> state
                                  (update-in [:positions room] rest)
                                  (assoc-in [:positions new-pos] (if (seq? (get-in state [:positions new-pos]))
                                                                   (conj (get-in state [:positions new-pos]) type)
                                                                   type))
                                  (update :cost (fnil
                                                 (partial
                                                  +
                                                  (if (#{:a :b :c :d} new-pos)
                                                    (-> path-l
                                                        (path-length-leaving-room (get-in state [:positions room]) (:depth state))
                                                        (path-length-entering-room (get-in state [:positions new-pos]))
                                                        (energy-cost type))
                                                    (-> path-l
                                                        (path-length-leaving-room (get-in state [:positions room]) (:depth state))
                                                        (energy-cost type))))
                                                 0)))))))))
            (for [hallway hallway-rooms]
              (if-let [type (get-in state [:positions hallway])]
                (->> (dijsktra-valid-paths-from (:positions state) hallway)
                     (remove #(is-door? (first %)))
                     (filter #(can-move? (:positions state) hallway type (first %)))
                     (map (fn [[new-pos path-l]]
                            (-> state
                                (update :positions (fn [m] (dissoc m hallway)))
                                (assoc-in [:positions new-pos] (if (seq? (get-in state [:positions new-pos]))
                                                                 (conj (get-in state [:positions new-pos]) type)
                                                                 type))
                                (update :cost (fnil
                                               (partial
                                                +
                                                (-> path-l
                                                    (path-length-entering-room (get-in state [:positions new-pos]))
                                                    (energy-cost type)))
                                               0))))))))))))

(def dfs
  (memoize
   (fn [state]
     (if-let [pos (:positions state)]
       (if (finished? pos)
         0
         (reduce min Long/MAX_VALUE
                 (for [step (steps-from state)]
                   (+' (:cost step)
                       (let [res (dfs (dissoc step :cost))]
                         res)))))))))

(defn solve-1
  [input]
  (dfs {:positions (parse-positions input)
        :depth 2}))

(defn solve-2
  [input]
  (dfs {:positions (unfold-input (parse-positions input))
        :depth 4}))

(comment
  (solve-1 (get-raw-input 23))
  (solve-2 (get-raw-input 23)))

(defn print-positions
  [state]
  (let [pos (:positions state)]
    (println
     (clojure.string/replace
      (reduce str (for [k [:h1 :h2 :h3 :h4 :h5 :h6 :h7 :h8 :h9 :h10 :h11]]
                    (str " " (get pos k "."))))
      #":"
      ""))
    (doseq [y [0 1 2 3]]
      (println
       (reduce str "    "
               (interpose "  "
                (for [k [:a :b :c :d]]
                  (nth (get pos k) y " ."))))))))
