import UIKit


class Solution {
    func specialArray(_ nums: [Int]) -> Int {
        let sorts = nums.sorted()
        let n = sorts.count
        for x in 0...n {
            var valid = 0
            for i in (0..<n).reversed() {
//                print(x, sorts[i])
                if sorts[i] >= x  {
                    valid += 1
                }else{
                    break
                }
            }
            if valid == x {
                return x
            }
        }
                
        return -1
    }
    
    func test() {
        specialArray([3,5])==2
        specialArray([0,0]) == -1
        specialArray([0,4,3,0,4]) == 3
    }
}

Solution().test()
