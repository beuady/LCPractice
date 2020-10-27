import UIKit

/**
 力扣双周比赛 No.189
 */

class Solution5414 {
    func peopleIndexes(_ favoriteCompanies: [[String]]) -> [Int] {
        var array = [Set<String>]() //
        var res = [Int]()// result array
        
        for i in 0..<favoriteCompanies.count {
            let aset = Set(favoriteCompanies[i])
            array.append(aset)
        }
        
        for i in 0..<array.count {
            let aset = array[i]
            var hasSubset = false
            for j in 0..<array.count {
                let eachSet = array[j]
                let isRs = i != j && aset.count < eachSet.count && aset.isSubset(of: eachSet)
                    
//                print("compare \(aset) and (\(eachSet), (i,j)=\(i),\(j) isSubSet=\(isRs)")
                if isRs {
                    
                    // if j==array.count-1 && (res.firstIndex(of: j) == nil) {
                    //     res.append(j)
                    // }
                    
                    hasSubset = true
                    break
                }
            }
            if !hasSubset {
                res.append(i)
            }
        }
        
        return res //res.sorted()
    }
    
    func testDemo() {
        let input = [["leetcode","google","facebook"],
                     ["google","microsoft"],
                     ["google","facebook"],
                     ["google"],
                     ["amazon"]] //[0,1,4]
        peopleIndexes(input)
    }
    
}

class Solution5413{
    func arrangeWords(_ text: String) -> String {
        
        var split = text.split(separator: " ")
        
        split[0] = Substring(split[0].lowercased())
        
        // Sort
        split.sort { (s1, s2) -> Bool in
            return s1.count < s2.count
        }
        
        split[0] = Substring(split[0].capitalized)
        
        return split.joined(separator: " ")
        
//        for i in 0..<array.count {
//            let index = table[i]![0]
//            if(i==0){
//
//                res = String(split[index])
//                res = "\(res.capitalized) "
//
//            }else if(i<array.count-1){
//                res += "\(split[index].lowercased()) "
//            }else{
//                res += split[index].lowercased()
//            }
//        }
        
//        return res
    }
    
    func testM() {
        let input = "To be or not to be"
        arrangeWords(input)
    }
}
Solution5413().testM()
