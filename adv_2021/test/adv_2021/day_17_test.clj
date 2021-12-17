(ns adv-2021.day-17-test
  (:require
   [adv-2021.day-17 :refer [solve-1 solve-2]]
   [clojure.test :refer :all]))

(def test-input "target area: x=20..30, y=-10..-5")

(deftest test-solutions
  (testing "Solutions are correct for example data.")
  (is (= 45 (solve-1 test-input)))
  (is (= 112 (solve-2 test-input))))
