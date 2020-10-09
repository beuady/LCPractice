import UIKit


 public class TreeNode {
     public var val: Int
     public var left: TreeNode?
     public var right: TreeNode?
     public init(_ val: Int) {
         self.val = val
         self.left = nil
         self.right = nil
     }
 }

public class Node {
     public var val: Int
     public var left: Node?
     public var right: Node?
       public var next: Node?
     public init(_ val: Int) {
         self.val = val
         self.left = nil
         self.right = nil
         self.next = nil
     }
 }

class Solution117 {
    func connect(_ root: Node?) -> Node? {
        var lastNode:Node? = nil
        var queue = [Node]()
        if root != nil {
            queue.append(root!)
        }
        
        while !queue.isEmpty {
            
            let n = queue.count
            for i in 0..<n {
                let node = queue.removeFirst()
                if i != 0 {
                    lastNode?.next = node
                    lastNode = node
                }else{
                    lastNode = node
                }
                if node.left != nil {
                    queue.append(node.left!)
                }
                if node.right != nil {
                    queue.append(node.right!)
                }
            }
        }
                        
        return root
    }
}

class Solution145 {
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        var vector = [Int]()
        helper(root, &vector)
        return vector
    }

    func helper(_ node:TreeNode?, _ vector:inout [Int]) {
        if node == nil {
            return
        }
        
        helper(node?.left, &vector)
        helper(node?.right, &vector)
        vector.append(node!.val)
    }

}

class Solution235 {
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        
        var node:TreeNode? = root
        while true {
            if node != nil && node!.val > p!.val && node!.val > q!.val {
                node = node?.left
            }else if node != nil && node!.val < p!.val && node!.val < q!.val {
                node = node?.right
            }else{
                break
            }
        }
        return node
    }
}

/// 40. 组合总和 II
class Solution40 {
//    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
//
//
//    }
    func test(){
        combinationSum2([10,1,2,7,6,1,5], 8)==[
          [1, 7],
          [1, 2, 5],
          [2, 6],
          [1, 1, 6]
        ]
    }
}

Solution40().test()

// 77. 组合
class Solution77 {
    
    var temp:[Int]!
    var ans:[[Int]]!
    
    func dfs(_ cur:Int, _ n:Int, _ k:Int) {
        if temp.count + (n-cur + 1) < k {
            return
        }
        
        if temp.count == k {
            ans.append(temp)
            return
        }
        
        temp.append(cur)
        dfs(cur+1, n, k)
        temp.removeLast()
        dfs(cur+1, n, k)
    }
    
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        temp = [Int]()
        ans = [[Int]]()
        dfs(1,n, k)
        return ans
    }
    func test(){
        combine(4, 2)==[
          [2,4],
          [3,4],
          [2,3],
          [1,2],
          [1,3],
          [1,4],
        ]
    }
}
Solution77().test()

// 347. 前 K 个高频元素
class Solution347 {
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var ans = [Int]()
        var sorts = [(Int,Int)]()
        
        var maps = [Int:Int]()
        for num in nums {
            maps[num] = 1 + (maps[num] ?? 0)
        }
        
        for (num, cnt) in maps {
            sorts.append((num,cnt))
        }
        
        sorts.sort(by: {$0.1 > $1.1})
        
        for i in 0..<sorts.count {
            
            if i<k {
                ans.append(sorts[i].0)
            }
        }
        
        return ans
    }
    func test(){
        topKFrequent([1,1,1,2,2,3], 2)==[1,2]
    }
}
Solution347().test()
