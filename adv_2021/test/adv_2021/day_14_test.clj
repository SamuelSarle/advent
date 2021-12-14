(ns adv-2021.day-14-test
  (:require
   [adv-2021.day-14 :refer [solve-1 solve-2]]
   [clojure.test :refer :all]))

(def test-input "NNCB\n\nCH -> B\nHH -> N\nCB -> H\nNH -> C\nHB -> C\nHC -> B\nHN -> C\nNN -> C\nBH -> H\nNC -> B\nNB -> B\nBN -> B\nBB -> N\nBC -> B\nCC -> N\nCN -> C")

(deftest test-solutions
  (testing "Solutions are correct for example data."
    (is (= 1588 (solve-1 test-input)))
    (is (= 2188189693529 (solve-2 test-input)))))
