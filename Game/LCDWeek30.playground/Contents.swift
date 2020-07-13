import UIKit

class Solution {
    func rangeSum(_ nums: [Int], _ n: Int, _ left: Int, _ right: Int) -> Int {
        let n = nums.count
        
        if n == 1 {
            return 1
        }
        
        var dp = [Int]()//(repeating: 0, count: n*(n+1)/2)
//        dp[0] = nums[0]
        var ans = 0
        var sum = 0
//        print("...")
        for pos in 0..<n {
            sum = 0
            for i in pos..<n {
                print(i, pos)
                if i == pos {
                    sum = nums[i]
                }else{
                    sum += nums[i]
                }
                dp.append(sum)
            }
        }
//        print("...2")
        dp = dp.sorted()
        print(dp)
        for i in left-1...right-1 {
            ans = (ans + dp[i])%(Int(10e9)+7)
        }
                
        return ans
    }
    
    
}

func test(){
    Solution().rangeSum([1,2,3,4], 4, 1, 5)==13
    Solution().rangeSum([1,2,3,4], 4, 3, 4)==6
    Solution().rangeSum([1,2,3,4], 4, 1, 10)==50
}
test()

/**
 5177. 转变日期格式
 */
class Solution5177 {
    func reformatDate(_ date: String) -> String {
        let months = ["", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let dateArr = date.split(separator: " ")
        
        let year = dateArr[2]
        var month = months.firstIndex(of: String(dateArr[1]))!
        let amonth = month<10 ? "0\(month)" : "\(month)"
        var day = 0
        for ch in dateArr[0] {
            if ch.isNumber {
                day = day * 10 + ch.wholeNumberValue!
            }
        }
        let aday = day < 10 ? "0\(day)" : "\(day)"
        
        let ans = "\(year)-\(amonth)-\(aday)"
        return ans
    }
    
}
//func test(){
//    Solution().reformatDate("20th Oct 2052")=="2052-10-20"
//}
//test()
