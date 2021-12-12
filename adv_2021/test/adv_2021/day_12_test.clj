(ns adv-2021.day-12-test
  (:require [adv-2021.day-12 :refer [solve-1 solve-2]]
            [clojure.test :refer :all]))

(def test-input (clojure.string/split-lines "dc-end\nHN-start\nstart-kj\ndc-start\ndc-HN\nLN-dc\nHN-end\nkj-sa\nkj-HN\nkj-dc"))

(deftest test-solutions
  (testing "Solutions are correct for example data."
    (is (= 19 (solve-1 test-input)))
    (is (= 103 (solve-2 test-input)))))
