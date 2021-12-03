(ns adv-2021.day-01-test
  (:require
   [adv-2021.day-01 :refer [solve-1 solve-2]]
   [clojure.test :refer :all]))

(def test-input (clojure.string/split-lines "199\n200\n208\n210\n200\n207\n240\n269\n260\n263"))

(deftest test-solutions
  (testing "Solutions are correct for example data."
    (is (= 7 (solve-1 test-input)))
    (is (= 5 (solve-2 test-input)))))
