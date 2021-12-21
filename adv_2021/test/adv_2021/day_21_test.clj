(ns adv-2021.day-21-test
  (:require
   [adv-2021.day-21 :refer [solve-1 solve-2]]
   [clojure.test :refer :all]))

(def test-input (clojure.string/split-lines "Player 1 starting position: 4\nPlayer 2 starting position: 8"))

(deftest test-solutions
  (testing "Solutions are correct for example data."
    (is (= 739785 (solve-1 test-input)))
    (is (= 444356092776315 (solve-2 test-input)))))
