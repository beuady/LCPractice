import UIKit

/**
 
 https://leetcode-cn.com/contest/biweekly-contest-29/problems/parallel-courses-ii/
5435. 并行课程 II
 给你一个整数 n 表示某所大学里课程的数目，编号为 1 到 n ，数组 dependencies 中， dependencies[i] = [xi, yi]  表示一个先修课的关系，也就是课程 xi 必须在课程 yi 之前上。同时你还有一个整数 k 。

 在一个学期中，你 最多 可以同时上 k 门课，前提是这些课的先修课在之前的学期里已经上过了。

 请你返回上完所有课最少需要多少个学期。题目保证一定存在一种上完所有课的方式。
 
 
 输入：n = 4, dependencies = [[2,1],[3,1],[1,4]], k = 2
 输出：3
 解释：上图展示了题目输入的图。在第一个学期中，我们可以上课程 2 和课程 3 。然后第二个学期上课程 1 ，第三个学期上课程 4 。
 */
class Solution {
    //思路，BFS+k次限制的迭代即可遍历，终点实际就是数字n,
    func minNumberOfSemesters(_ n: Int, _ dependencies: [[Int]], _ k: Int) -> Int {

    }
}

func test() {
    Solution().minNumberOfSemesters(4, [[2,1],[3,1],[1,4]], 2)==3
}
test()

class Solution7777 {
    
    func longestSubarray_dp(_ nums: [Int]) -> Int {
        let n = nums.count
        var dp0=[Int](repeating: 0, count: n+1)
        var dp1=[Int](repeating: 0, count: n+1)
        var ans = 0
        dp1[0] = Int.min
        for i in 0..<n {
            dp0[i+1] = nums[i]==1 ? dp0[i]+1:0
            dp1[i+1] = dp0[i]
            if nums[i] != 0 {
                dp1[i+1] = max(dp1[i+1], dp1[i]+1)
            }
            ans = max(ans, dp1[i+1])
        }
        
        return ans
    }
    
    func longestSubarray_slicewindow(_ nums: [Int]) -> Int {
        var l=0, r = 0, n = nums.count, count = 0
        var ans = 0
        // slide window, 左边界的收敛条件，可以结合右边界做制造，不一定用独立的判断函数
        while r < n {
            if nums[r] == 0 {
                count += 1
            }

            while count >= 2 {
                if nums[l] == 0 {
                    count -= 1
                }
                l += 1
            }

            ans = max(ans, r-l)
            print(ans, r, l)
            r += 1
        }
        return ans
    }
    
    
    func longestSubarray(_ nums: [Int]) -> Int {
        var zeroI = -1
        var l = 0 , r = 0
        var res = [[Int]]()
        while l<nums.count {
//            print(l, "l=")
            if nums[l] == 1 {
                r = l
                while r < nums.count {
//                    print(r, "r=")
                    if nums[r] == 0 || r+1 == nums.count {
                        if nums[r] == 0 && zeroI == -1{
                            zeroI = r
                        }else{
                            let validR = nums[r] == 0 ? r-1 : r
                            res.append([l,validR,zeroI]) //
                            if zeroI != -1 {
                                l = zeroI-1 //如果删除的数为0，则left更新到这里
                            }else if r+1==nums.count {//优化左边的收敛速度
                                l = r
                            }
                            zeroI = -1
                            break
                        }
                    }
                    r += 1
                }
                
            }
            
            l += 1
        }
        
        // all 0
        if l==nums.count && r == 0 {
            return 0
        }
        
        print("...")
        var max1 = 0
        var solution = -1
        for _nums in res {
            let l = _nums[0]
            let r = _nums[1]
            let zeroI = _nums[2]
            if r-l+1 > max1 {
                max1 = r-l+1
                if zeroI == -1 {//不包含，判断是否在目标子数组外能删除一个数
                    if l>0 || r<nums.count-1 {
                        return max1
                    }else{
                        return max1-1
                    }
                }else{//包含zeroIndex
                    solution = max1 - 1
                }
            }
        }
        return solution
    }
}

func test() {
//    Solution().longestSubarray([1,1,0,1])==3
    Solution7777().longestSubarray_slicewindow([0,1,1,1,0,1,1,0,1])==5
//    Solution().longestSubarray([1,1,1])==2
//    Solution().longestSubarray([1,1,0,0,1,1,1,0,1])==4
//    Solution().longestSubarray([0,0,0])==0
//    Solution().longestSubarray([1,0,0,0,0])==1
//    Solution().longestSubarray([0,0,1,1])==2

}
test()

class Solution6666 {
    func kthFactor(_ n: Int, _ k: Int) -> Int {
        var N = [Int]()
        var step = 0
        for i in 1...n {
            if n % i == 0 {
                N.append(i)
                step += 1
                if step == k {
                    return i
                }
            }
        }
        
        return -1
    }
}
//func test() {
//    Solution().kthFactor(12, 3)==3
//    Solution().kthFactor(7, 2)==7
//    Solution().kthFactor(4, 4) == -1
//    Solution().kthFactor(1, 1)==1
//    Solution().kthFactor(1000, 3)==4
//
//}
//test()


class Solution5555 {
    func average(_ salary: [Int]) -> Double {
//        let sorts = salary.sorted()
//        var res:Double = 0
//        for i in 1..<sorts.count-1 {
//            res += Double(sorts[i])
//        }
//        return res / Double((sorts.count-2))
        var mx = Int.min
        var mn = Int.max
        var sum = 0
        for i in 0..<salary.count {
            mx = max(mx, salary[i])
            mn = min(mn, salary[i])
            sum += salary[i]
        }
        return Double((sum - mx - mn) / (salary.count-2))
    }
}
