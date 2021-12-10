(ns adv-2021.day-10-test
 (:require
  [adv-2021.day-10 :refer [solve-1 solve-2]]
  [clojure.string :as str]
  [clojure.test :refer :all]))

(def test-input (str/split-lines "[({(<(())[]>[[{[]{<()<>>\n[(()[<>])]({[<{<<[]>>(\n{([(<{}[<>[]}>{[]{[(<()>\n(((({<>}<{<{<>}{[]{[]{}\n[[<[([]))<([[{}[[()]]]\n[{[{({}]{}}([{[{{{}}([]\n{<[[]]>}<{[{[{[]{()[[[]\n[<(<(<(<{}))><([]([]()\n<{([([[(<>()){}]>(<<{{\n<{([{{}}[<[[[<>{}]]]>[]]"))

(deftest test-solutions
  (testing "Solutions are correct for example data."
    (is (= 26397 (solve-1 test-input)))
    (is (= 288957 (solve-2 test-input)))))
