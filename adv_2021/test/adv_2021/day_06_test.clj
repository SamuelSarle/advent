(ns adv-2021.day-06-test
  (:require
   [adv-2021.day-06 :refer [solve-1 solve-2]]
   [clojure.string :as str]
   [clojure.test :refer :all]))

(def test-input "3,4,3,1,2")

(deftest test-solutions
  (testing "Solutions are correct for example data."
    (is (= 5934 (solve-1 test-input)))
    (is (= 26984457539 (solve-2 test-input)))))
