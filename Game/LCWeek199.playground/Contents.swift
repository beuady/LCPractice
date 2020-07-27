import UIKit

class Solution4 {
    func getLengthOfOptimalCompression(_ s: String, _ k: Int) -> Int {
        if s.count==0 {
            return 0
        }
        var ans = 0

        yasuo(s, k)
        
        return ans
    }
    
    func yasuo(_ s: String, _ k: Int) {
        let S = Array(s)
        var L = [(Character, Int, Int)]() // (char, cnt, len)
        var cnt = 0
        let n = S.count
        var last:Character=S[0]
        for i in 1..<n {
            let char = S[i]
            if last == char {
                cnt += 1
            }
            if last != char || i+1 == n {
                let c = i+1==n ? char : last
                if cnt == 0 {
                    L.append((c, 0, 1))
                }else{
                    L.append((c, cnt, 1+String(cnt).count))
                }
                cnt = 0
                last = char
            }
        }
        // add last
        print(L)
        
        
        var k = k

        var ans = 0
        for i in (0..<L.count).reversed() {
            let len = L[i].2
            if k>0 && len<=k {
                k -= len
            }else{
                ans += len
            }
        }
    }
    
    func test() {
//        getLengthOfOptimalCompression("aaabcccd", 2)==4
//        getLengthOfOptimalCompression("aaaaaaaaaaa",0)==3
        getLengthOfOptimalCompression("aabbaa", 2)==2
    }
}
Solution4().test()

 public class TreeNode {
     public var val: Int
     public var left: TreeNode?
     public var right: TreeNode?
     public init() { self.val = 0; self.left = nil; self.right = nil; }
     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
         self.val = val
         self.left = left
         self.right = right
     }
 }

class Solution3 {
    var ans = 0
    var visited:[Bool]!
    func countPairs(_ root: TreeNode?, _ distance: Int) -> Int {
//        visited =
//        help(root, 0, distance)
        return ans
    }
    
    /*
     public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
             if(root == null || root == p || root == q) return root;
             TreeNode left = lowestCommonAncestor(root.left, p, q);
             TreeNode right = lowestCommonAncestor(root.right, p, q);
             if(left == null && right == null) return null; // 1.
             if(left == null) return right; // 3.
             if(right == null) return left; // 4.
             return root; // 2. if(left != null and right != null)
         }
     */
    
    func help(_ root:TreeNode?, _ deep:Int,_ distance:Int) {
        if root == nil {
            return
        }

        if root?.left != nil {
            help(root?.left, deep+1, distance)
        }
        if root?.right != nil {
            help(root?.right, deep+1, distance)
        }

        if root?.left == nil && root?.right == nil {
            if deep <= distance {
                ans += 1
            }
        }

    }
}

class Solution1 {
    func restoreString(_ s: String, _ indices: [Int]) -> String {
        let S = Array(s)
        let n = indices.count
        var ans = [Character](repeating: "_", count: n)
        
        for i in 0..<n {
            let index = indices[i]
            ans[index] = S[i]
        }
        return String(ans)
    }
    
    func test(){
        restoreString("aiohn", [3,1,4,2,0])=="nihao"
    
    }
}
Solution().test()


