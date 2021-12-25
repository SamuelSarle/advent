(ns adv-2021.day-25-test
  (:require
   [adv-2021.day-25 :refer [solve-1]]
   [clojure.test :refer :all]))

(def test-input"v...>>.vv>\n.vv>>.vv..\n>>.>v>...v\n>>v>>.>.v.\nv>v.vv.v..\n>.>>..v...\n.vv..>.>v.\nv.v..>>v.v\n....v..v.>")

(deftest test-solutions
  (testing "Solutions are correct for example data."
    (is (= 58 (solve-1 test-input)))))
