import UIKit

class Solution18 {
    //排序+双指针
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        let Nums = nums.sorted()
        var ans = [[Int]]()
        if nums.count<4 {
            return ans
        }
        let n = nums.count
        for i in 0..<n-3 {
            
            if i > 0 && Nums[i] == Nums[i-1] {
                continue
            }
            
            if Nums[i] + Nums[i+1] + Nums[i+2] + Nums[i+3] > target {
                break //第一个数不能太大
            }
            
            if Nums[i] + Nums[n-3] + Nums[n-2] + Nums[n-1] < target {
                continue // 第一个数不能太小
            }
            
            for j in i+1..<n-2 {
                
                if j>i+1 && Nums[j] == Nums[j-1] {
                    continue
                }
                
                if Nums[i] + Nums[j] + Nums[j+1] + Nums[j+2] > target {
                    break
                }
                
                if Nums[i] + Nums[j] + Nums[n-2] + Nums[n-1] < target {
                    continue
                }
                
                //双指针
                var left = j+1, right = n-1
                while left < right {
                    
                    let sum = Nums[i] + Nums[j] + Nums[left] + Nums[right]
                    
                    if sum == target {
                        ans.append([Nums[i] , Nums[j] , Nums[left] , Nums[right]])
                        
                        while left < right && Nums[left] == Nums[left+1] {
                            left += 1
                        }
                        
                        while left < right && Nums[right-1] == Nums[right] {
                            right -= 1
                        }
                        right -= 1
                    }else if sum < target {
                        left += 1
                    }else {
                        right -= 1
                    }
                    
                }
            }
            
        }
        return ans
    }
}

class Solution771 {
    func numJewelsInStones(_ J: String, _ S: String) -> Int {
        let sets = Set<Character>(J)
        var ans = 0
        for ch in S {
            if sets.contains(ch) {
                ans += 1
            }
        }
        return ans
    }
}

class Solution {
    func minimumOperations(_ leaves: String) -> Int {
        let L = Array(leaves)
        let n = leaves.count
        var f = [[Int]](repeating: [Int](repeating: 0, count: 3), count: n)
        
        f[0][0] = L[0] == "y" ? 1 : 0
        f[0][1] = Int.max
        f[0][2] = Int.max
        f[1][2] = Int.max
        for i in 1..<n {
            let isRed = L[i] == "r" ? 1 : 0
            let isYellow = L[i] == "y" ? 1 : 0
            f[i][0] = f[i-1][0] + isYellow
            f[i][1] = min(f[i-1][0], f[i-1][1]) + isRed
            
            if i >= 2 {
                f[i][2] = min(f[i-1][1], f[i-1][2]) + isYellow
            }
        }
        
        return f[n-1][2]
    }
}
