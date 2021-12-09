(ns adv-2021.day-09-test
 (:require
  [adv-2021.day-09 :refer [solve-1 solve-2]]
  [clojure.test :refer :all]))

(def test-input "2199943210\n3987894921\n9856789892\n8767896789\n9899965678")

(deftest test-solutions
  (testing "Solutions are correct for example data."
    (is (= 15 (solve-1 test-input)))
    (is (= 1134 (solve-2 test-input)))))
