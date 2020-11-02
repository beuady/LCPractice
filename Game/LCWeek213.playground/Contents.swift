import UIKit

class Solution {
    func canFormArray(_ arr: [Int], _ pieces: [[Int]]) -> Bool {
       
        var indexMap = [Int:Int]()
        for i in 0..<arr.count{
            indexMap[arr[i]] = i
        }
//        print(indexMap)
        
        let n = pieces.count
        
        var ans = 0
        for i in 0..<n {
            var lastIndex:Int = -1
            let m = pieces[i].count
            for j in 0..<m {
                let num = pieces[i][j]
                if m == 1 {
                    if indexMap[num] != nil {
                        ans += 1
                    }
                }else {
//                    print(num)
                    if indexMap[num] != nil {
                        ans += 1
                        
                        if lastIndex != -1 && lastIndex+1 != indexMap[num]! {
                            return false
                        }
                        
                        lastIndex = indexMap[num]!
                    }else{
                        return false
                    }
                }
            }
        }

        return arr.count == ans
    }
    
    func test() {
        canFormArray([91,4,64,78], [[78],[4,64],[91]]) == true
    }
    
}

Solution().test()
