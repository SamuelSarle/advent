(ns adv-2021.day-05-test
  (:require
   [adv-2021.day-05 :refer [solve-1 solve-2]]
   [clojure.string :as str]
   [clojure.test :refer :all]))

(def test-input (str/split-lines "0,9 -> 5,9\n8,0 -> 0,8\n9,4 -> 3,4\n2,2 -> 2,1\n7,0 -> 7,4\n6,4 -> 2,0\n0,9 -> 2,9\n3,4 -> 1,4\n0,0 -> 8,8\n5,5 -> 8,2"))

(deftest test-solutions
  (testing "Solutions are correct for example data."
    (is (= 5 (solve-1 test-input)))
    (is (= 12 (solve-2 test-input)))))
