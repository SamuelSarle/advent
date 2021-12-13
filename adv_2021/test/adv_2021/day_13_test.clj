(ns adv-2021.day-13-test
  (:require
   [adv-2021.day-13 :refer [solve-1 solve-2]]
   [clojure.test :refer :all]))

(def test-input "6,10\n0,14\n9,10\n0,3\n10,4\n4,11\n6,0\n6,12\n4,1\n0,13\n10,12\n3,4\n3,0\n8,4\n1,10\n2,14\n8,10\n9,0\n\nfold along y=7\nfold along x=5")

(deftest test-solutions
  (testing "Solutions are correct for example data."
    (is (= 17 (solve-1 test-input)))))
    ;; (is (= nil (solve-2 test-input))))) ; nothing to test, the result is printed
                                           ; and visually inspected
