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


