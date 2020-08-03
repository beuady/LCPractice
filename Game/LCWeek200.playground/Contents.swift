import UIKit

class Solution {
    func countGoodTriplets(_ arr: [Int], _ a: Int, _ b: Int, _ c: Int) -> Int {
        var ans = 0
        var j=0,k=0
        let n = arr.count
        let sort = arr.sorted()
        var sortIndexs = [Int](repeating: 0, count: n) // [num:index]
        
        for p in 0..<n {
            for q in 0..<n {
                if sort[p] == arr[q] {
                    sortIndexs[p] = q
                    break
                }
            }
            
        }
        
        for i in 0..<n {
            j = i+1
            while j < n {
                k = j+1
                while k < n {
                    if abs(sort[i] - sort[j]) <= a &&
                        abs(sort[i] - sort[k]) <= c &&
                        abs(sort[j] - sort[k]) <= b {
                        print(sort[i], sort[j],sort[k])
                        ans += 1
                    }
                     
                    k += 1
                }
                                
                j += 1
                
            }
        }
        
        return ans
    }
    
    func test(){
//        countGoodTriplets([3,0,1,1,9,7],
//        7,
//        2,
//        3)
        countGoodTriplets([7,3,7,3,12,1,12,2,3],
        5,
        8,
        1)==12
    }
    
}
Solution().test()
