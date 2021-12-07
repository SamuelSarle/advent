(ns adv-2021.day-07-test
  (:require
   [adv-2021.day-07 :refer [solve-1 solve-2]]
   [clojure.string :as str]
   [clojure.test :refer :all]))

(def test-input "16,1,2,0,4,2,7,1,2,14")

(deftest test-solutions
  (testing "Solutions are correct for example data."
    (is (= 37 (solve-1 test-input)))
    (is (= 168 (solve-2 test-input)))))
