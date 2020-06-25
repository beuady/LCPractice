import UIKit

/**
 https://leetcode-cn.com/contest/weekly-contest-193/problems/minimum-number-of-days-to-make-m-bouquets/
 */
class Solution {
//    func minDays(_ bloomDay: [Int], _ m: Int, _ k: Int) -> Int {
//        
//    }
}

/**
  不同整数的最少数目
 https://leetcode-cn.com/contest/weekly-contest-193/problems/least-number-of-unique-integers-after-k-removals/
 */
class Solution5437 {
    func findLeastNumOfUniqueInts(_ arr: [Int], _ k: Int) -> Int {
        var res = arr.count
        if res < 2 {
            return res - k > 0 ? res - k : 0
        }
        var map = [Int:Int]()
        var repeatCount = 0
        var noCount = 0
        for num in arr {
            if let cnt = map[num]{
                map[num] = cnt + 1
            }else{
                map[num] = 1
            }
        }
        
        for (num, count) in map {
            if count == 1 {
                noCount += 1
                map.removeValue(forKey: num) //过滤后保留重复的元素集合
            }else{
                repeatCount += 1
            }
        }
        
        let element = noCount + repeatCount
        if k <= noCount {
            res = element - k
        }else{
            var needRepeatCount = k - noCount
            
            let countSorted = map.values.sorted() //重复的元素集合排序
            res = countSorted.count
            var i = 0
            while needRepeatCount > 0 {
                if needRepeatCount < countSorted[i]{
                    break
                }
                needRepeatCount = needRepeatCount - countSorted[i]
                res -= 1
                i += 1
            }
            
        }

        
        return res
    }
    
    func test() {
//        findLeastNumOfUniqueInts([5,5,4], 1)==1
//        findLeastNumOfUniqueInts([4,3,1,1,3,3,2], 3) == 2
//        findLeastNumOfUniqueInts([2,1,1,3,3,3],3)==1
//        findLeastNumOfUniqueInts([1],1)==0
//        findLeastNumOfUniqueInts([1],2)==0
//        findLeastNumOfUniqueInts([1],3)==0
        findLeastNumOfUniqueInts([1,1,2,2,3,3], 3) == 2
    }
}
Solution5437().test()

/**
 一维数组的动态和
 https://leetcode-cn.com/contest/weekly-contest-193/problems/running-sum-of-1d-array/
 */
class Solution5436 {
    func runningSum(_ nums: [Int]) -> [Int] {
        
        var dp0 = 0, dp1 = nums[0], dp2 = nums[0] + 0
        var res = [Int]()
        res.append(nums[0])
        for i in 1..<nums.count {
            dp0 = dp1
            dp1 = dp2
            dp2 = dp1 + nums[i]
            res.append(dp2)
        }
            
        return res
    }
    
/**
     [1,3,6,10]
     [1,2,3,4,5]
     [3,4,6,16,17]
     */
}
