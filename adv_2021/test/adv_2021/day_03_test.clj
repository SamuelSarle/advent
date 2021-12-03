(ns adv-2021.day-03-test
  (:require
   [adv-2021.day-03 :refer [solve-1 solve-2]]
   [clojure.string :as str]
   [clojure.test :refer :all]))

(def test-input (str/split-lines "00100\n11110\n10110\n10111\n10101\n01111\n00111\n11100\n10000\n11001\n00010\n01010"))

(deftest test-solutions
  (testing "Solutions are correct for example data."
    (is (= 198 (solve-1 test-input)))
    (is (= 230 (solve-2 test-input)))))
