(ns adv-2021.day-15-test
  (:require
   [adv-2021.day-15 :refer [solve-1 solve-2]]
   [clojure.test :refer :all]))

(def test-input "1163751742\n1381373672\n2136511328\n3694931569\n7463417111\n1319128137\n1359912421\n3125421639\n1293138521\n2311944581")

(deftest test-solutions
  (testing "Solutions are correct for example data."
    (is (= 40 (solve-1 test-input)))
    (is (= 315 (solve-2 test-input)))))
