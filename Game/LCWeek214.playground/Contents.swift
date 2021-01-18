import UIKit

class Solution2 {
    func minDeletions(_ s: String) -> Int {
        var map = [Character:Int]()
        for c in s {
            map[c] = (map[c] ?? 0) + 1
        }
        var list = [Int]()
        list.append(0)
        for (_, cnt) in map {
            list.append(cnt)
        }
        var sort = list.sorted()
        
        var delCount = 0
        var i = sort.count - 1
        while i>=1 {
            
            print(sort)
            while sort[i-1]>0 && sort[i-1] >= sort[i] {
                sort[i-1] -= 1
                delCount += 1
            }
            
            i -= 1
        }
        return delCount


    }
    func test() {
        // aabbcc
//        minDeletions("abcabc") == 3
        // ceabbb, 1,1,1,4
        minDeletions("bbcebab") == 2
    }
}
Solution2().test()

class Solution1 {
    func getMaximumGenerated(_ n: Int) -> Int {
        if n == 0 {
            return 0
        }
        if n < 3 {
            return 1
        }
        
        var nums = [Int](repeating: 0, count: n+2)
        nums[1] = 1
        let m:Int = n/2
        print(m)
        var mx = 0
        for i in 1...m {
            print(i*2+1)
            nums[i*2] = nums[i]
            nums[i*2+1] = nums[i] + nums[i+1]
            if i*2+1 <= n {
                mx = max(mx, nums[i*2+1])
            }else{
                mx = max(mx, nums[i*2])
            }
        }
        return mx
    }
    
    func test() {
        getMaximumGenerated(4) == 2
    }
}
Solution().test()
