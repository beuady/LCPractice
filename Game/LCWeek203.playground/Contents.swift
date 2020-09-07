import UIKit

class Solution {
    func maxCoins(_ piles: [Int]) -> Int {
        let sorted = piles.sorted()
        
        var ans = [Int]()
        var l = 0, r = sorted.count - 2
        while l < r {
            print(l, r)
            ans.append(sorted[r])
            r -= 2
            l += 1
        }
        
        print(ans)
        
        var sum = 0
        for num in ans {
            sum += num
        }
        return sum
    }
    //  1,2,2,4,7,8
    func test(){
//        maxCoins( [2,4,1,2,7,8])==9
//        maxCoins([2,4,5] )==4
        maxCoins([9,8,7,6,5,1,2,3,4])==18
    }
}

Solution().test()


class Solution1 {
    func mostVisited(_ n: Int, _ rounds: [Int]) -> [Int] {
        var visiteds = [Int](repeating: 0, count: n+1)
        var ans = [Int]()
        let m = rounds.count
        var p = 0
        visiteds[rounds[0]] = 1 // 首次访问记录1
        for i in 1..<m {
            let p0 = rounds[i-1]
            let p1 = rounds[i]
            if p0 < p1 {
                p = p0+1
                while p <= p1 {
                    visiteds[p] += 1
                    p += 1
                }
            }else{
                p = p0+1
                while p <= n {
                    visiteds[p] += 1
                    p += 1
                }
                p = 1
                while p <= p1 {
                    visiteds[p] += 1
                    p += 1
                }
            }
        }
        print(visiteds)
        let mx = visiteds.max()
        for i in 0..<visiteds.count {
            if visiteds[i] == mx {
                ans.append(i)
            }
        }
        
        return ans //需要升序，最多次数
    }
    func test(){
        mostVisited(4, [1,3,1,2])==[1,2]
        mostVisited(2,  [2,1,2,1,2,1,2,1,2])==[2]
        
    }

    
}



