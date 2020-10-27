import UIKit


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
 
//  二叉树的前序遍历
class Solution144 {
    var list = [Int]()
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        helper(root)
        return list
    }
    
    func helper(_ node:TreeNode?) {
        if node == nil {
            return
        }
        
        list.append(node!.val)
        helper(node?.left)
        helper(node?.right)
    }
}

// 1365. 有多少小于当前数字的数字
class Solution1365 {
    /**
     注意到数组元素的值域为 [0,100][0,100]，所以可以考虑建立一个频次数组 cntcnt ，cnt[i]cnt[i] 表示数字 ii 出现的次数。那么对于数字 ii 而言，小于它的数目就为 cnt[0...i-1]cnt[0...i−1] 的总和

     作者：LeetCode-Solution
     链接：https://leetcode-cn.com/problems/how-many-numbers-are-smaller-than-the-current-number/solution/you-duo-shao-xiao-yu-dang-qian-shu-zi-de-shu-zi--2/
     来源：力扣（LeetCode）
     著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
     */
    func smallerNumbersThanCurrent(_ nums: [Int]) -> [Int] {
        var cnt = [Int](repeating: 0, count: 101)
        let n = nums.count
        for i in 0..<n{
            cnt[nums[i]] += 1
        }
        
        for i in 1...100 {
            cnt[i] = cnt[i] + cnt[i-1]
        }
        
        var res = [Int]()
        for i in 0..<n {
            res.append(nums[i] == 0 ? 0 : cnt[nums[i]-1])
        }
        return res
    }
}

/// 763. 划分字母区间
class Solution763 {
    func partitionLabels(_ S: String) -> [Int] {
        var last = [Int](repeating: 0, count: 26)
        let SS = Array(S)
        let n = S.count
        let a:UInt8 = Character("a").asciiValue!
        for i in 0..<n {
            let char = SS[i]
            last[Int(char.asciiValue!-a)] = i
        }
        
        var par = [Int]()
        var start = 0, end = 0
        for i in 0..<n {
            let cn = SS[i].asciiValue!
            end = max(end, last[Int(cn-a)])
            if i == end {
                par.append(end-start+1)
                start = end + 1
            }
        }
        return par
    }
}

/**
 Definition for singly-linked list.
 public class ListNode {
     public var val: Int
     public var next: ListNode?
     public init(_ val: Int) {
         self.val = val
         self.next = nil
     }
 }
 */
class Solution234 {
    func isPalindrome(_ head: ListNode?) -> Bool {
        var stack = [Int]()
        var cur = head
        while cur != nil {
            stack.append(cur!.val)
        }
        return stack == stack.reversed()
    }
}

class Solution925 {
    func isLongPressedName(_ name: String, _ typed: String) -> Bool {
        let N = Array(name)
        let T = Array(typed)
        let TCount = T.count
        var nIndex = 0
        var tIndex = 0
        while tIndex < TCount {
            if nIndex < N.count && N[nIndex] == T[tIndex] {
                nIndex += 1
            }else if tIndex>0 && T[tIndex] == T[tIndex-1] {
                
            }else{
                return false
            }
            
            tIndex += 1
        }
        return nIndex == N.count
    }
    func test(){
        isLongPressedName("alex",
                          "alexxr") == false
    }
}
Solution925().test()

 public class ListNode {
     public var val: Int
     public var next: ListNode?
     public init() { self.val = 0; self.next = nil; }
     public init(_ val: Int) { self.val = val; self.next = nil; }
     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 }

class Solution19 {
    
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        let dummy = ListNode(0, head)
        var stack = [ListNode]()
        var cur:ListNode? = dummy
        while cur != nil {
            stack.append(cur!)
            cur = cur?.next
        }
        
        for i in 0..<n {
            stack.removeLast()
        }
        
        let prev = stack.last
        prev?.next = prev?.next?.next
        let ans = dummy.next
        dummy.next = nil
        return ans
    }
    
    // 失败逻辑
    func removeNthFromEnd_fail(_ head: ListNode?, _ n: Int) -> ListNode? {
        var h1 = head
        var h2 = head
        var i = 0
        while h2?.next != nil && i+1<=n {
            if i < n-1 {
                h1 = h1?.next
            }
            h2 = h2?.next
            i += 1
        }
        return h1
    }
}

class Solution844 {
    func backspaceCompare(_ S: String, _ T: String) -> Bool {
        let s = Array(S)
        let t = Array(T)
        
        var stack = [Character]()
        var stack2 = [Character]()
        for c in s {
            if c != "#" {
                stack.append(c)
            }else{
                if !stack.isEmpty {
                    stack.removeLast()
                }
            }
        }
        
        for c in t {
            if c != "#" {
                stack2.append(c)
            }else{
                if !stack2.isEmpty {
                    stack2.removeLast()
                }
            }
        }
        
        
        
        return String(stack)==String(stack2)
    }
    
    func test(){
        backspaceCompare("ab#c", "ad#c") == true
    }
}
Solution844().test()

class Solution18 {
    //排序+双指针
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        let Nums = nums.sorted()
        var ans = [[Int]]()
        if nums.count<4 {
            return ans
        }
        let n = nums.count
        for i in 0..<n-3 {
            
            if i > 0 && Nums[i] == Nums[i-1] {
                continue
            }
            
            if Nums[i] + Nums[i+1] + Nums[i+2] + Nums[i+3] > target {
                break //第一个数不能太大
            }
            
            if Nums[i] + Nums[n-3] + Nums[n-2] + Nums[n-1] < target {
                continue // 第一个数不能太小
            }
            
            for j in i+1..<n-2 {
                
                if j>i+1 && Nums[j] == Nums[j-1] {
                    continue
                }
                
                if Nums[i] + Nums[j] + Nums[j+1] + Nums[j+2] > target {
                    break
                }
                
                if Nums[i] + Nums[j] + Nums[n-2] + Nums[n-1] < target {
                    continue
                }
                
                //双指针
                var left = j+1, right = n-1
                while left < right {
                    
                    let sum = Nums[i] + Nums[j] + Nums[left] + Nums[right]
                    
                    if sum == target {
                        ans.append([Nums[i] , Nums[j] , Nums[left] , Nums[right]])
                        
                        while left < right && Nums[left] == Nums[left+1] {
                            left += 1
                        }
                        
                        while left < right && Nums[right-1] == Nums[right] {
                            right -= 1
                        }
                        right -= 1
                    }else if sum < target {
                        left += 1
                    }else {
                        right -= 1
                    }
                    
                }
            }
            
        }
        return ans
    }
}

class Solution771 {
    func numJewelsInStones(_ J: String, _ S: String) -> Int {
        let sets = Set<Character>(J)
        var ans = 0
        for ch in S {
            if sets.contains(ch) {
                ans += 1
            }
        }
        return ans
    }
}

class Solution {
    func minimumOperations(_ leaves: String) -> Int {
        let L = Array(leaves)
        let n = leaves.count
        var f = [[Int]](repeating: [Int](repeating: 0, count: 3), count: n)
        
        f[0][0] = L[0] == "y" ? 1 : 0
        f[0][1] = Int.max
        f[0][2] = Int.max
        f[1][2] = Int.max
        for i in 1..<n {
            let isRed = L[i] == "r" ? 1 : 0
            let isYellow = L[i] == "y" ? 1 : 0
            f[i][0] = f[i-1][0] + isYellow
            f[i][1] = min(f[i-1][0], f[i-1][1]) + isRed
            
            if i >= 2 {
                f[i][2] = min(f[i-1][1], f[i-1][2]) + isYellow
            }
        }
        
        return f[n-1][2]
    }
}
