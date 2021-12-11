(ns adv-2021.day-11-test
  (:require
   [adv-2021.day-11 :refer [solve-1 solve-2]]
   [clojure.test :refer :all]))

(def test-input "5483143223\n2745854711\n5264556173\n6141336146\n6357385478\n4167524645\n2176841721\n6882881134\n4846848554\n5283751526")

(deftest test-solutions
  (testing "Solutions are correct for example data."
    (is (= 1656 (solve-1 test-input)))
    (is (= 195 (solve-2 test-input)))))
