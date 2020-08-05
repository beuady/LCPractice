import UIKit


/**
 https://leetcode-cn.com/problems/number-of-nodes-in-the-sub-tree-with-the-same-label/
 */
class Solution {
    var adj:[[Int]]!
    var l:Array<Any>!
    var ans:[Int]!
    var c:[Int] = [Int](repeating: 0, count: 26)
    func countSubTrees(_ n: Int, _ edges: [[Int]], _ labels: String) -> [Int] {
        adj = [[Int]](repeating: [Int](), count: n)
        for e in edges {
            adj[e[0]].append(e[1])
            adj[e[1]].append(e[0])
        }
        l = Array(labels)
        ans = [Int](repeating: 0, count: n)
        dfs()
        return ans
    }
    
    func dfs(_ u:Int = 0, _ p:Int = -1) {
        var lc = c[l[u]-"a"]
        
    }
    
    
}

class Solution2 {
    func countSubTrees(_ n: Int, _ edges: [[Int]], _ labels: String) -> [Int] {
        let S = Array(labels)
        var ans = [Int](repeating: 1, count: n)
        
        var adj = [[Int]](repeating: [Int](), count: n)
        for edge in edges {
            adj[edge[1]].append(edge[0]) //准备反向遍历
            adj[edge[0]].append(edge[1])
        }
//        adj[0].append(0)
        
        print(adj)
        
        
        for v in (0..<n).reversed() {
            var queue = [(Int,Character)]()
            queue.append((v, S[v]))
                        
//            while !queue.isEmpty {
                let (v, char) = queue.removeFirst()
                for out in adj[v] {
                    queue.append((out, S[out]))
                    if char == S[out] && out != 0 {
                        ans[out] += 1
                    }
                }
//            }
                        
        }
        
        
        return ans
    }
    
    func test(){
        countSubTrees(7, [[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]], "abaedcd")==[2,1,1,1,1,1,1]
//        countSubTrees(5, [[0,1],[0,2],[1,3],[0,4]], "aabab")==[3,2,1,1,1]
//        countSubTrees(7, [[0,1],[1,2],[2,3],[3,4],[4,5],[5,6]], "aaabaaa")==[6,5,4,1,3,2,1]
//        countSubTrees(6, [[0,1],[0,2],[1,3],[3,4],[4,5]], "cbabaa")==[1,2,1,1,2,1]
//        countSubTrees(4, [[0,1],[1,2],[0,3]], "bbbb")==[4,2,1,1]
    }
    
}
Solution2().test()

//https://leetcode-cn.com/contest/weekly-contest-198/problems/water-bottles/
class Solution1 {
    func numWaterBottles(_ numBottles: Int, _ numExchange: Int) -> Int {
        var ans = numBottles
        var empty = numBottles
        var ex:Int = empty / numExchange
        while empty > 0 {
            empty = empty - ex * numExchange + ex
            ans += ex
            ex = empty / numExchange
            if ex == 0 {
                break
            }
        }
        return ans
    }
    
    func test(){
        numWaterBottles(19, 4)==25
//        numWaterBottles(15, 4)==19
    }
}
Solution1().test()

