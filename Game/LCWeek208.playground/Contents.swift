import UIKit

class Solution {
    func minOperationsMaxProfit(_ customers: [Int], _ boardingCost: Int, _ runningCost: Int) -> Int {
        
    }
    
    func test(){
    }
}

Solution().test();


class Solution2 {
    func minOperations(_ logs: [String]) -> Int {
        var ans = 0
        
        for log in logs {
            if log == "../" {
                ans -= 1
                ans = max(0, ans)
            }else if log == "./" {
                
            }else{
                ans += 1
            }
        }
        
        return max(0, ans)
    }
    func test(){
        minOperations(["./","wz4/","../","mj2/","../","../","ik0/","il7/"])==2
    }
}


