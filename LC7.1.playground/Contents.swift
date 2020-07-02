import UIKit

/**
 378. 有序矩阵中第K小的元素
 */
class Solution378 {
    func kthSmallest(_ matrix: [[Int]], _ k: Int) -> Int {
        let n = matrix.count
        var left = matrix[0][0]
        var right = matrix[n-1][n-1]
        while left < right {
            let mid = left + ((right - left)>>1)
            if check(matrix,mid, k, n) {
                right = mid
            }else{
                left = mid + 1
            }
        }
        
        return left
    }
    
    func check(_ matrix:[[Int]], _ mid:Int, _ k:Int, _ n:Int)->Bool {
        var i = n-1
        var j = 0
        var num = 0
        while i >= 0 && j < n {
            if matrix[i][j] <= mid {
                num += i + 1
                j += 1
            }else{
                i -= 1
            }
        }
        return num >= k
    }
    
    func test(){
        kthSmallest([
           [ 1,  5,  9],
           [10, 11, 13],
           [12, 13, 15]
        ], 8)==13
    }
    
}
Solution378().test()

/**
 最长重复子数组
 */
class Solution718 {
    func findLength(_ A: [Int], _ B: [Int]) -> Int {
        let n = A.count, m = B.count
        var ans = 0

        for i in 0..<n {
            let len = min(m, n-i)
            let maxLen = maxLength(A,B, i , 0, len)
            ans = max(ans, maxLen)
        }
        
        for i in 0..<m {
            let len = min(n, m-i)
            let maxLen = maxLength(A,B, 0 , i, len)
            ans = max(ans, maxLen)
        }
        
        return ans
    }
    
    func maxLength(_ A:[Int],_ B:[Int], _ addA:Int, _ addB:Int, _ len:Int) -> Int{
        var res = 0, k = 0
        for i in 0..<len {
            if A[addA+i] == B[addB+i]{
                k += 1
            }else{
                k = 0
            }
            res = max(res, k)
        }
        return res
    }
    
    func test(){
        findLength([0,0,0,0,1], [1,0,0,0,0])==4
        findLength([0,0,0,0,0], [0,0,0,0,0])==5
    }
}
Solution718().test()
        
//        dp[i] = dp[i-1]&& target[i]
//        ans = max(ans, dp[i])
