import UIKit

class Solution {
    func isInterleave(_ s1: String, _ s2: String, _ s3: String) -> Bool {
        let n = s1.count, m = s2.count, t = s3.count
        var f = [[Bool]](repeating: [Bool](repeating: false, count: m+1), count: n+1)
        
        if n+m != t {
            return false
        }
        
        let S1 = Array(s1)
        let S2 = Array(s2)
        let S3 = Array(s3)
        
        f[0][0] = true
        for i in 0...n {
            for j in 0...m {
                let p = i + j - 1
                if i > 0 {
                    f[i][j] = f[i][j] || (f[i-1][j] && S1[i-1] == S3[p])
                }
                if j > 0 {
                    f[i][j] = f[i][j] || ( f[i][j-1] && S2[j-1] == S3[p])
                }
            }
        }
        return f[n][m]
    }

}
