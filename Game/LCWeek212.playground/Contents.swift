import UIKit

class Solution {
    func slowestKey(_ releaseTimes: [Int], _ keysPressed: String) -> Character {
        let S = Array(keysPressed)
        let n = S.count
        var mx = 0
        var ans = S[0]
        for i in 0..<n {
            if i == 0 {
                mx = max(mx, releaseTimes[i])
            }else{
                let j = releaseTimes[i]-releaseTimes[i-1]
                if mx < j {
                    mx = j
                    ans = S[i]
                }else if mx == j {
                    if S[i].asciiValue! > ans.asciiValue! {
                        ans = S[i]
                    }
                }
            }
        }
        return ans
    }
}
