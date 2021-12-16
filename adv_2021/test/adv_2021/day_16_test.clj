(ns adv-2021.day-16-test
  (:require
   [adv-2021.day-16 :refer [solve-1 solve-2]]
   [clojure.test :refer :all]))

(def solve-1-test-inputs
  ;; [input answer]
  {"8A004A801A8002F478" 16
   "620080001611562C8802118E34" 12
   "C0015000016115A2E0802F182340" 23
   "A0016C880162017C3686B18A3D4780" 31})

(def solve-2-test-inputs
  ;; [input answer]
  {"C200B40A82" 3
   "04005AC33890" 54
   "880086C3E88112" 7
   "CE00C43D881120" 9
   "D8005AC2A8F0" 1
   "F600BC2D8F" 0
   "9C005AC2F8F0" 0
   "9C0141080250320F1802104A08" 1})

(deftest test-solutions
  (testing "Solutions are correct for example data."
    (doseq [[input answer] solve-1-test-inputs]
      (is (= answer (solve-1 input))))
    (doseq [[input answer] solve-2-test-inputs]
      (is (= answer (solve-2 input))))))
