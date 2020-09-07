import UIKit

// 347. 前 K 个高频元素
class Solution347 {
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var ans = [Int]()
        var sorts = [(Int,Int)]()
        
        var maps = [Int:Int]()
        for num in nums {
            maps[num] = 1 + (maps[num] ?? 0)
        }
        
        for (num, cnt) in maps {
            sorts.append((num,cnt))
        }
        
        sorts.sort(by: {$0.1 > $1.1})
        
        for i in 0..<sorts.count {
            
            if i<k {
                ans.append(sorts[i].0)
            }
        }
        
        return ans
    }
    func test(){
        topKFrequent([1,1,1,2,2,3], 2)==[1,2]
    }
}
Solution347().test()
