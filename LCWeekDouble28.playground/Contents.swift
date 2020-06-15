import UIKit

/**
 5423. 找两个和为目标值且不重叠的子数组
 https://leetcode-cn.com/contest/biweekly-contest-28/problems/find-two-non-overlapping-sub-arrays-each-with-target-sum/
 */
class Solution5423 {
    func minSumOfLengths(_ arr: [Int], _ target: Int) -> Int {
        var l=0, r = -1
//        var matchLens = [Int]()
        var matchRanges = [ClosedRange<Int>]()
        // 滑动窗口
        for _ in 0..<arr.count {
            r += 1
            while contain(arr, l,r, target) {
                if !contain(arr,l+1,r,target) {
                    let len = r - l + 1
//                    matchLens.append(len)
                    matchRanges.append((l...r))
                    print(l,r,arr[l],arr[r],"len=", len)
                    break
                }
                l += 1
            }
        }
        
        if matchRanges.count < 2 {
            return -1
        }
        
        // 找到子集里“不重叠”的最小长度
        // 双指针找min和min(-1)
        var res = -1
        var pr2 = matchRanges.count - 1
        var minLen1 = Int.max, minLen2 = Int.max
        var minIndex = 0, minIndex2 = pr2
        for pr1 in 0..<matchRanges.count {
            let r1 = matchRanges[pr1]
            let len1 = r1.upperBound - r1.lowerBound + 1
            if len1 <= minLen1 {
                minLen1 = len1
                minIndex = pr1
            }
            
            let r2 = matchRanges[pr2]
            let len2 = r2.upperBound - r2.lowerBound + 1
            // 指针2不和指针1重叠，因为要找不重叠的子集，就不能重复
            if len2 <= minLen2 && pr2 != minIndex {
                minLen2 = len2
                minIndex2 = pr2
            }
            
//            print(pr1,pr2)
            if pr1+1 >= pr2 {
                print(minIndex,minIndex2)
                // 仔细判断两个区间是否相交呀！
                if isIntersect(matchRanges[minIndex], matchRanges[minIndex2]) {
                    
                }else{//找到不重叠的两个子集
                    let r1 = matchRanges[minIndex]
                    let len1 = r1.upperBound - r1.lowerBound + 1
                    let r2 = matchRanges[minIndex2]
                    let len2 = r2.upperBound - r2.lowerBound + 1
                    res = len1 + len2
                    break
                }
            }
            
            pr2 -= 1
            
        }

        return res
    }
    
    func contain(_ arr:[Int],_ l:Int,_ r:Int,_ target:Int)->Bool {
        if l>r {
            return false
        }
        var sum = 0
        for i in (l...r).reversed() {
            sum += arr[i]
            if target == sum {
                return true
            }
        }
        return false
    }
    
    func isIntersect(_ r1:ClosedRange<Int>, _ r2:ClosedRange<Int>) -> Bool {
        if r1.lowerBound <= r2.lowerBound {
            if r1.upperBound >= r2.lowerBound {
                return true
            }
        }
        if r2.lowerBound <= r1.lowerBound {
            if r2.upperBound >= r1.lowerBound {
                return true
            }
        }
        return false
    }
    
    func testCase() {
//        minSumOfLengths([3,2,2,4,3], 3) == 2
//        minSumOfLengths([7,3,4,7], 7) == 2
//        minSumOfLengths([4,3,2,6,2,3,4], 6) == -1
//        minSumOfLengths([5,5,4,4,5], 3) == -1
//        minSumOfLengths([3,1,1,1,5,1,2,1], 3) == 3
//        minSumOfLengths([1,6,1],7) == -1
//        minSumOfLengths([1,2,2,3,2,6,7,2,1,4,8], 5) == 4
//        minSumOfLengths([26,5,16,1,2,2,25,20,1,5,1,9,32,4,2,2,3,34,6,8,1,1,2,45,2,2,1,1,1,50,1,1,32,6,7,6,1,37],52) == 8
//        minSumOfLengths([31,1,1,18,15,3,15,14],33) == 5
        minSumOfLengths([24,1,21,1,4,3,27,7,5,1,12,1,1,43,2,5,4,54,34],54) == 5
    }
}
Solution5423().testCase()

/**
 5420. 商品折扣后的最终价格
 https://leetcode-cn.com/contest/biweekly-contest-28/problems/final-prices-with-a-special-discount-in-a-shop/
 */
class Solution5420 {
    /**
    min = prices[j] && j>i
     f(0) = min
     */
    func finalPrices(_ prices: [Int]) -> [Int] {
        if prices.count < 1 {
            return prices
        }
        var res = [Int]()
                
        for i in 0..<prices.count {
            let minIndex = findMin(prices,prices[i], i+1)
            if let minI = minIndex {
                if minI>i && prices[minI] <= prices[i] {
                    res.append(prices[i] - prices[minI])
                }else{
                    res.append(prices[i])
                }
            }else{
                res.append(prices[i])
            }
        }
        return res
    }
    
    func findMin(_ prices:[Int],_ target:Int, _ start:Int) ->Int?{
        if start >= prices.count {
            return nil
        }
        for i in start..<prices.count{
            if prices[i] <= target{
                return i
            }
        }
        return start
    }
    
    func testCase() {
        finalPrices([8,4,6,2,3]) == [4,2,4,2,3]
    }
}

Solution5420().testCase()
