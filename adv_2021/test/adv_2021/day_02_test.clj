(ns adv-2021.day-02-test
  (:require
   [adv-2021.day-02 :refer [solve-1 solve-2]]
   [clojure.string :as str]
   [clojure.test :refer :all]))

(def test-input (str/split-lines "forward 5\ndown 5\nforward 8\nup 3\ndown 8\nforward 2"))

(deftest test-solutions
  (testing "Solutions are correct for example data."
    (is (= 150 (solve-1 test-input)))
    (is (= 900 (solve-2 test-input)))))
