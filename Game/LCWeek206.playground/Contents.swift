import UIKit

class Solution {
    func numSpecial(_ mat: [[Int]]) -> Int {
        if mat.count == 1 {
            return mat[0][0] == 1 ? 1 : 0
        }
        var ans = 0
        let m = mat.count, n = mat.first!.count

        var cnt = 0
        var tj = 0
        for i in 0..<m {
            for j in 0..<n{
                if mat[i][j] == 1 {
                    cnt += 1
                    tj = j
                }
            }
            
            if cnt == 1 {// 这一行找到了半个
                var b = true
                for ti in 0..<m {
                    if ti != i && mat[ti][tj]==1 {
                        b = false
                        break
                    }
                }
                if b {
                    ans += 1
                }
            }
            cnt = 0
        }
        
        return ans
    }
}
