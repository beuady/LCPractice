import UIKit

/**
 
 */
class Solution657 {
    func judgeCircle(_ moves: String) -> Bool {
        
    }
}

/**
 递增子序列
 */
class Solution491 {
    var temp:[Int]!
    var ans:[[Int]]!
    
    func dfs(_ cur:Int, _ last:Int, nums:[Int]) {
        
    }
    
    func findSubsequences(_ nums: [Int]) -> [[Int]] {
        
    }
}

/**
 459. 重复的子字符串
 */
class Solution459 {
    func repeatedSubstringPattern(_ s: String) -> Bool {
        let S = Array(s)
        let n = S.count
        var i = 1
        while i*2 <= n {
            
            if n % i == 0 {
                var match = true
                for j in i..<n {
                    if S[j] != S[j-i] {
                        match = false
                        break
                    }
                }
                
                if match {
                    return true
                }
                
            }
            
            i += 1
        }
        return false
    }
    
    func test(){
        repeatedSubstringPattern("babbabbabbabbab")==true
    }
    
}
Solution459().test()

/**
 647. 回文子串
 */
class Solution647 {
    func countSubstrings(_ s: String) -> Int {
        
        let n = s.count
        var ans = 0
        let S = Array(s)
        
        for i in 0..<2*n-1 {
            var l:Int = i / 2
            var r:Int = i / 2 + i % 2
            while l >= 0 && r < n && S[l] == S[r] {
                l -= 1
                r += 1
                ans += 1
            }
        }
        
        return ans
    }
//    func countSubstrings(_ s: String) -> Int {
//        let S = Array(s)
//        let n = S.count
//        var l = 0, r = 0
//        while r < n {
//            while l<=r && check(l,r) {
//
//                l += 1
//            }
//            r += 1
//        }
//
//    }
    
    func check(_ l:Int ,_ r:Int)->Bool {
        
        
        
    }
    
}

//有序链表转换二叉搜索树
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}
 
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


extension ListNode:Hashable {
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(val)
        hasher.combine(next)
    }
}

/**
 111. 二叉树的最小深度
 */
class Solution111 {
    var minD = Int.max
    func minDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        if root?.left == nil && root?.right == nil {
            return 1
        }
        
        if let l = root?.left {
            minD = min(minD, minDepth(l))
        }
        
        if let r = root?.right {
            minD = min(minD, minDepth(r))
        }
        
        return minD + 1
    }
}

/**
 有序链表转换二叉搜索树
 */
class Solution109 {
    func sortedListToBST(_ head: ListNode?) -> TreeNode? {
        guard let _ = head else {
            return nil
        }
        var cur = head
        var nums = [Int]()
        while cur != nil {
            nums.append(cur!.val)
            cur = cur?.next
        }
        return buildTree(nums, 0, nums.count - 1)
    }
    
    func buildTree(_ nums:[Int], _ left:Int, _ right:Int)->TreeNode? {
        if left < right {
            return nil
        }
        let mid = (left+right)>>1
        let node = TreeNode(nums[mid])
        node.left = buildTree(nums, left, mid-1)
        node.right = buildTree(nums, mid+1, right)
        return node
    }
    
    func findMid(_ left:ListNode?, _ right:ListNode?) -> ListNode? {
        var slow:ListNode? = left
        var fast:ListNode? = left
        while fast != right && fast?.next != right {
            slow = slow?.next
            fast = fast?.next?.next
        }
        return slow
    }
    
    func buildT(_ left:ListNode?, _ right:ListNode?)->TreeNode? {
        if left == right {
            return nil
        }
        let mid:ListNode? = findMid(left, right)
        
        let node:TreeNode? = mid != nil ? TreeNode(mid!.val) : nil
        node?.left = buildT(left, mid)
        node?.right = buildT(mid?.next, right)
        return node
    }
    
    
}

//Solution().test()

/**
  图像渲染
 */
class Solution733 {
    let dx = [1, 0, 0, -1]
    let dy = [0, 1, -1, 0]
    func floodFill(_ image: [[Int]], _ sr: Int, _ sc: Int, _ newColor: Int) -> [[Int]] {
        var curC = image[sr][sc]
        if curC == newColor {
            return image
        }
        var image = image
        let n = image.count, m = image.first!.count
        var queue = [(Int, Int)]()
        queue.append((sr, sc))
        image[sr][sc] = newColor
        while !queue.isEmpty {
            let x = queue.last!.0, y = queue.last!.1
            queue.removeLast()
            for i in 0..<4 {
                let mx = x + dx[i], my = y + dy[i]
                if mx >= 0 && mx < n && my >= 0 && my < m && image[mx][my] == curC {
                    queue.append((mx, my))
                    image[mx][my] = newColor
                }
            }
        }
        return image
    }
}

public class Node {
    public var val: Int
    public var neighbors: [Node?]
    public init(_ val: Int) {
        self.val = val
        self.neighbors = []
    }
}

class Solution {
    func cloneGraph(_ node: Node?) -> Node? {
        
    }
}

/**
 20. 有效的括号
 */
class Solution20 {
    func isValid(_ s: String) -> Bool {
        let map:[Character:Character] = [")":"(", "}":"{","]":"["]
        print(map)
        var stack = [Character]()
        
        if s.count % 2 == 1 {
            return false
        }
        
        for ch in s {
            stack.append(ch)
            if !stack.isEmpty && stack.count>1 {
                let top = stack.last!
                if stack[stack.count-2] == map[top] {
                    stack.removeLast()
                    stack.removeLast()
                }
            }
        }
        
//        print(stack)
        return stack.count == 0
    }
    
    func test(){
        isValid("()[]{}")
        isValid("{[]}")
    }
}
Solution20().test()

/**
 43. 字符串相乘
 */
class Solution43 {
    func multiply(_ num1: String, _ num2: String) -> String {
        let N1 = Array(num1)
        let N2 = Array(num2)
        
        
        
        
    }
}

/**
 130. 被围绕的区域
 */
class Solution {
    var n:Int!
    var m:Int!
    func dfs(_ board: inout [[Character]],_ x:Int, _ y:Int)
    {
        if x<0 || x>=n || y<0 || y>=m || board[x][y] != "O"  {
            return
        }
        board[x][y] = "A"
        dfs(&board, x+1, y)
        dfs(&board, x-1, y)
        dfs(&board, x, y+1)
        dfs(&board, x, y-1)

    }
    
    func solve(_ board: inout [[Character]]) {
        if board.count == 0 {
            return
        }
        n = board.count
        m = board.first!.count
        
        for i in 0..<n {
            dfs(&board, i, 0)
            dfs(&board, i, m-1)
        }
        
        for i in 0..<m-1 {
            dfs(&board, 0, i)
            dfs(&board, n-1, i)
        }
        
        for i in 0..<n {
            for j in 0..<m {
                if board[i][j] == "A" {
                    board[i][j] = "O"
                }else if board[i][j] == "O" {
                    board[i][j] = "X"
                }
            }
        }
        
    }
    /**
     被围绕的区间不会存在于边界上，换句话说，任何边界上的 'O' 都不会被填充为 'X'。 任何不在边界上，或不与边界上的 'O' 相连的 'O' 最终都会被填充为 'X'。如果两个元素在水平或垂直方向相邻，则称它们是“相连”的。

     */
    func test(){
        var b = tran([
            ["O","X","X","O","X"],
            ["X","O","O","X","O"],
            ["X","O","X","O","X"],
            ["O","X","O","O","O"],
            ["X","X","O","X","O"]])
        
        /*  [
             ["O","X","X","O","X"],
             ["X","X","X","X","O"],
             ["X","X","X","O","X"],
             ["O","X","O","O","O"],
             ["X","X","O","X","O"]]
        */
        solve(&b)
        print(b)
    }
    func tran(_ board: [[String]]) -> [[Character]] {
        let n = board.count
        let m = board.first!.count
        var T = [[Character]](repeating: [Character](repeating: "X", count: m), count: n)
        if board.count != 0 {
            for i in 0..<n {
                for j in 0..<m {
                    T[i][j] = Character(board[i][j])
                }
            }
        }
        return T
    }
    
}
Solution().test()

/**
 696. 计数二进制子串
 */
class Solution696 {
    func countBinarySubstrings(_ s: String) -> Int {
        //压缩
        var counts = [Int]()
        let S = Array(s)
        var pr = 0, n = S.count
//        s= "000011110011" = 4422
        while pr < n {
            let c = S[pr]
            var count = 0
            while  pr<n && c == S[pr] {
                pr += 1
                count += 1
            }
            counts.append(count)
        }
        print("...")
        var ans = 0
        
        for i in 1..<counts.count {
            ans += min(counts[i], counts[i-1])
        }
        
        return ans
        
    }
    
    func test(){
        countBinarySubstrings("00110")
    }
}
Solution696().test()

/**
 93. 复原IP地址
 */
class Solution {
    func restoreIpAddresses(_ s: String) -> [String] {
        let S = Array(s)
        let n = S.count
        var ans = [String]()
        var dotIndexs = [Int]()
        for i in 0..<n {
            
            
            
        }
        return ans
    }
}

/**
 336. 回文对
 */

class Solution336 {
    var wordsRev = [[Character]]()
    var indices = [String:Int]()
    // 官方解法之字典记录逆向的回文
    func palindromePairs(_ words: [String]) -> [[Int]] {
        let n = words.count
        for word in words {
            wordsRev.append(word.reversed())
        }
        
        for i in 0..<n {
            indices[String(wordsRev[i])] = i
        }
        print("...")
        var ans = [[Int]]()
        for i in 0..<n {
            let word = words[i]
            let m = words[i].count
            if m == 0 {
                continue
            }
            let W = Array(word)
            for j in 0...m {
                if isPalindrome(W, j, m-1) {
                    let leftId = findWord(W, 0, j-1)
                    if leftId != -1 && leftId != i {
                        ans.append([i, leftId])
                    }
                }
                print("..z")
                if j != 0 && isPalindrome(W, 0, j-1) {
                    let rightId = findWord(W, j, m-1)
                    if rightId != -1 && rightId != i {
                        ans.append([rightId, i])
                    }
                }
                
            }
            
        }
        return ans
    }
    
    func isPalindrome(_ S:[Character], _ left:Int, _ right:Int)->Bool {
        let len = right - left + 1
        for i in 0 ..< len/2 {
            if S[left + i] != S[right - i] {
                return false
            }
        }
        return true
    }
    
    func findWord(_ S:[Character], _ left:Int, _ right:Int) -> Int {
//        print("findword")
        let i = indices[String(S[left..<right+1])] ?? -1
//        print(i,"findword")
        return i
    }
    
    
    func test(){
        palindromePairs(["abcd","dcba","lls","s","sssll"])
    }
    
}

Solution336().test()



class Solution336_暴力 {
    
    // 暴力解法O(n^2*M), 其中M是字符串的平均长度
    func palindromePairs(_ words: [String]) -> [[Int]] {
        var ans = [[Int]]()
        if words.count==1 {
            if check(words[0], "") {
                return [[0]]
            }else{
                return ans
            }
        }
        let n = words.count
        for i in 0..<n {
            for j in 0..<n {
                if i != j {
                    if check(words[i], words[j]) {
                        ans.append([i,j])
                    }
                }
            }
        }
        return ans
    }
    
    func check(_ str1:String, _ str2:String)->Bool {
        let S = str1+str2
        let L = Array(S)
        
        
        let n:Int = L.count
        let m = n/2
        for i in 0...m {
            if L[i] != L[n-i-1] {
                return false
            }
        }
        
        return true
    }
    
    func test(){
        palindromePairs(["abcd","dcba","lls","s","sssll"])
    }
    
}




/**
 337. 打家劫舍 III
 */

//public class TreeNode {
//    public var val: Int
//    public var left: TreeNode?
//    public var right: TreeNode?
//    public init(_ val: Int) {
//        self.val = val
//        self.left = nil
//        self.right = nil
//    }
//}

extension TreeNode:Hashable {
    public static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(val)
        hasher.combine(left)
        hasher.combine(right)
    }
}
 
class Solution337 {
    
    //思路,  使用二元组，替代字典,还是动态规划
    // f(o) = g(l)+g(r), g(o) = max{f(l),g(l)} + max{ g(r),f(r)}
    
    class Solution_dp_pair {
        func rob(_ root: TreeNode?) -> Int {
            let r = robNode(root)
            return max(r.0,r.1)
        }
        
        func robNode(_ node:TreeNode?) -> (Int, Int) {
            if node == nil {
                return (0,0)
            }
            
            let l = robNode(node?.left)
            let r = robNode(node?.right)
            
            var res:(Int,Int) // 二元组相当于 (g(o), f(o))
            res.0 = max(l.0, l.1) + max(r.0, r.1)
            res.1 = node!.val + l.0 + r.0
            return res
        }
    }
    
    var f:[TreeNode:Int]!
    var g:[TreeNode:Int]!
    
    func dfs(_ node:TreeNode?) {
        if let n = node {
            dfs(n.left)
            dfs(n.right)
            
            f[n] = n.val
            g[n] = 0
//                + (n.left != nil ? (g[n.left!] ?? 0) : 0) + (n.right != nil ? (g[n.right!] ?? 0) : 0)
            
            if let r = n.right {
                f[n]! += g[r] ?? 0
                g[n]! += max(f[r] ?? 0,g[r] ?? 0)
            }
            if let l = n.left {
                f[n]! += g[l] ?? 0
                g[n]! = max(f[l] ?? 0,g[l] ?? 0)
            }
        }
    }

    func rob_dp_map(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        f = [TreeNode:Int]()
        g = [TreeNode:Int]()
        dfs(root)
        return max(f[root!]!, g[root!]!)
    }
}
Solution()

/**
 207. 课程表
 */
class Solution207 {
    var edges:[[Int]]!
    var indeg:[Int]!
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        edges = [[Int]](repeating: [Int](), count: numCourses)
        indeg = [Int](repeating: 0, count: numCourses)
        
        for info in prerequisites {
            edges[info[1]].append(info[0])
            indeg[info[0]] += 1
        }
        
        var queue = [Int]()
        for i in 0..<numCourses {
            if indeg[i] == 0 {
                queue.append(i) //记录入度为0的结点
            }
        }
        
        var cntVisited = 0 //记录访问的数量
        while !queue.isEmpty {
            cntVisited += 1
            let u = queue.removeFirst()
            for v in edges[u] {
                indeg[v] -= 1
                if indeg[v] == 0 {
                    queue.append(v)
                }
            }
        }
        
        return cntVisited == numCourses;
        
    }
    func test(){
        
    }
}
Solution207().test()

class Solution_ {
    func maxProfit(_ prices: [Int]) -> Int {
        var ans = 0
        var mP = Int.max
        for i in 0..<prices.count {
            if prices[i] < mP {
                mP = prices[i]
            }else if prices[i] - mP > ans {
                ans = prices[i] - mP
            }
        }
        return ans
    }
}

/**
 415. 字符串相加
 */
class Solution415 {
    func addStrings(_ num1: String, _ num2: String) -> String {
        var N1 = Array(num1)
        var N2 = Array(num2)
        if N1.count < N2.count {
            (N1,N2) = (N2,N1)
        }
        let n = N1.count,n2 = N2.count
        var ans = ""
        var jin = 0
        for i in 0..<n {
            var m:Int
            if i<n2 {
                m = N1[n-i-1].wholeNumberValue!+N2[n2-i-1].wholeNumberValue!+jin
            }else{
                m = N1[n-i-1].wholeNumberValue!+jin
            }
            jin = m/10
            m = m%10
            ans = "\(m)" + ans
        }
        return jin>0 ? "\(jin)" + ans : ans
    }
    
    func test(){
        addStrings("1", "9")=="10"
    }
    
    
    
}
Solution415().test()
