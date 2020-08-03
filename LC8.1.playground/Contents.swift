import UIKit

class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        var ans = 0
        var mP = Int.max
        for i in 0..<prices.count {
            if prices[i] < mP {
                mP = prices[i]
            }else if prices[i] - mP > ans {
                ans = prices[i] - mP
            }
        }
        return ans
    }
}

/**
 415. 字符串相加
 */
class Solution415 {
    func addStrings(_ num1: String, _ num2: String) -> String {
        var N1 = Array(num1)
        var N2 = Array(num2)
        if N1.count < N2.count {
            (N1,N2) = (N2,N1)
        }
        let n = N1.count,n2 = N2.count
        var ans = ""
        var jin = 0
        for i in 0..<n {
            var m:Int
            if i<n2 {
                m = N1[n-i-1].wholeNumberValue!+N2[n2-i-1].wholeNumberValue!+jin
            }else{
                m = N1[n-i-1].wholeNumberValue!+jin
            }
            jin = m/10
            m = m%10
            ans = "\(m)" + ans
        }
        return jin>0 ? "\(jin)" + ans : ans
    }
    
    func test(){
        addStrings("1", "9")=="10"
    }
    
    
    
}
Solution415().test()
