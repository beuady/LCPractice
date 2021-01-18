import UIKit

class Solution {
    func arrayStringsAreEqual(_ word1: [String], _ word2: [String]) -> Bool {
        var N = 0, M = 0
        var i = 0, j = 0
        var p1 = 0, p2 = 0
        let n1 = word1.count
//        var remain1 = 0, remain2 = 0 // 剩余数
        while i < n1 {
            let w1 = Array(word1[i])
            if j == word2.count {
                break
            }
            let w2 = Array(word2[j])
            if w1.count - p1 < w2.count - p2 {
                print(p1,p2, w1, w2)
                while p1 < w1.count && p2 < w2.count {
                    if w1[p1] != w2[p2] {
                        return false
                    }
                    
                    p1 += 1
                    p2 += 1
                }
                p1 = 0
                
                N += w1.count
                i += 1
                print(p1,p2,"N=",N)
            }else {
                print(p1, p2,w1,w2,"else")

                while p1 < w1.count && p2 < w2.count {
                    if w1[p1] != w2[p2] {
                        return false
                    }
                    
                    p1 += 1
                    p2 += 1
                }
                p2 = 0
                M += w2.count
                j += 1
                print(p1, p2, "M=",M)
            }
        }
        
        return true
    }
    
    func test() {
        arrayStringsAreEqual(["ab", "c"], ["a", "bc"]) == true
    }
}
Solution().test()
