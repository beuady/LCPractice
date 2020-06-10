//iamport UIKit
import Foundation

//for i in stride(from: 0, to: 5, by: 1){
//    print(i)
//}
//print("...")
//for i in stride(from: 0, through: 5, by: 1){
//    print(i)
//}

//let sets = Set<Int>([1,4,3,3,2,1])
//for num in sets.sorted(){//Set是不会自动排序的
//    print(num)
//}

let str:Character = "a"
let str2:Character = "B"

str.asciiValue
str2.asciiValue

let num = 123
var nums = Array(String(num))

"258".compare("25", options: .literal, range: nil, locale: nil).rawValue


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

extension TreeNode : Equatable {
    public static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs==rhs
    }
}

/**
 235. 二叉搜索树的最近公共祖先
 */
class Solution235 {
    /**
     解法1:
     情况1，  p是q的祖先,  helper(p)是否含有q
     情况2,   q是p的祖先，helper(q)是否含有p
     情况3,  q和p存在非自身的公共祖先
            helper'(root)是否含有q和p,继续找直到helper'(root)都含有q和p,并且下一个helper'(root.left)等于q|p或者helper'(root.right)等于q|p.这时候的root就是目标祖先
     
     解法2:
        找到p的所有祖先的结点N。假设p是公共祖先，从p出发向下找q，如果找到q就是祖先，找不到，就找上一个祖先，再重复以假设的祖先结点，向下遍历找到q，则这个祖先N'就是目标值
     
     官方解法:
        因为这个是搜索树，是有顺序的。就可以通过递归，加入p、q的值都比根结点root大，p和q就在root.right为根结点root'的子树里面， 就递归寻找root.right里。
        如果p和q都比root.val小，肯定都在root.left为根结点root'的子树里面。直到都不在左子树或右子树，迭代到当前的root结点就是最近祖先
     */
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        if root == nil || p == nil || q == nil {
            return nil
        }
        let rVal = root!.val
        let pVal = p!.val
        let qVal = q!.val

        if rVal < pVal && rVal < qVal {
            return lowestCommonAncestor(root?.right, p, q)
        }else if rVal > pVal && rVal > qVal {
            return lowestCommonAncestor(root?.left, p, q)
        }else{
            return root
        }

    }
    
}

/**
 设第i-1位和第i位形成数字x,
 f(i) = f(i-1)+f(i-2), [i-1>=0, 10<=x<=25]
 边界条件:
    
 */
class Solution46 {
        func translateNum(_ num: Int) -> Int {
            var dp = [Int](repeating: 0, count: 3) //滚动数组
            dp[0] = 0
            dp[1] = 1
            dp[2] = 1
            let nums = Array(String(num))
            
            if nums.count < 2 {
                return 1
            }
            for i in 1..<nums.count {
                dp[0] = dp[1]
                dp[1] = dp[2]
                
                dp[2] = 0
                dp[2] += dp[1]
                
                let sub = Int("\(nums[i-1])\(nums[i])")!

                if sub<=25 && sub>=10 {
                    dp[2] = dp[0] + dp[1]
                }
                            
            }
            return dp[2]
        }
    
    // 失败的思路
    func translateNumFail(_ num: Int) -> Int {

        var solution = 1 // 一个一个翻译的情况默认是第一个种解
        
        // calculate length of num
        var len:UInt = UInt(num)
        var n = 0
        while len != 0 {
            len /= 10
            n += 1
        }
        
        //寻找其余两个两个一组的解法的可能性
        var window:UInt = UInt(num)
        for _ in 0 ..< n {
            let aWindow = window % 100
            if (10...25).contains(aWindow) {
                solution += 1
            }
            window /= 10
        }
        return solution
    }

    
    func testCase() {
//        translateNum(12258) == 5
        translateNum(25) == 2
//        translateNum(18822) == 4
    }
}

Solution46().testCase()


/**
 学习总结:
 请务必看官方解读视频。并查集的时间复杂度是平均时间下O(1),但实际时间是很难计算的。并查集disjoin-set有两种方式，
 1）按秩合并
    是指在合并过程中，使得【高度】更低的树的根结点指向【高度】更高的根结点，以避免合并后的树高度增加
 2) 路径压缩(度数最小)
    2.1完全压缩（递归)
    2.2隔代压缩 (相对完全压缩性能更好)
 
 990. 等式方程的可满足性
 给定一个由表示变量之间关系的字符串方程组成的数组，每个字符串方程 equations[i] 的长度为 4，并采用两种不同的形式之一："a==b" 或 "a!=b"。在这里，a 和 b 是小写字母（不一定不同），表示单字母变量名。

 只有当可以将整数分配给变量名，以便满足所有给定的方程时才返回 true，否则返回 false。

  

 示例 1：

 输入：["a==b","b!=a"]
 输出：false
 解释：如果我们指定，a = 1 且 b = 1，那么可以满足第一个方程，但无法满足第二个方程。没有办法分配变量同时满足这两个方程。


 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/satisfiability-of-equality-equations
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution990 {
    func equationsPossible(_ equations: [String]) -> Bool {
        var parent = [UInt8](repeating: 0, count: 26)
        for i in 0..<26{
            parent[i] = UInt8(i)
        }
        
        for str in equations {
            let chars:[Character] = Array(str)
            if chars[1] == "=" {
                let index1 = chars[0].asciiValue! - Character("a").asciiValue!
                let index2 = chars[3].asciiValue! - Character("a").asciiValue!
                union(&parent, index1, index2)
            }
        }
        
        for str in equations {
            let chars:[Character] = Array(str)
            if chars[1] == "!" {
                let index1 = chars[0].asciiValue! - Character("a").asciiValue!
                let index2 = chars[3].asciiValue! - Character("a").asciiValue!
                if find(&parent, index1) == find(&parent, index2) {
                    return false
                }
            }
        }
        
        return true
    }
    
    func union(_ parent:inout [UInt8], _ index1:UInt8, _ index2:UInt8) {
        parent[Int(find(&parent, index1))] = find(&parent, index2)
    }
    
    func find(_ parent:inout [UInt8], _ index8:UInt8) -> UInt8 {
        var index:Int = Int(index8)
        while parent[index] != index {
            parent[index] = parent[Int(parent[index])]
            index = Int(parent[index])
        }
        return UInt8(index)
    }
    
    func testCase(){
        equationsPossible(["a==b","b!=a"]) == false
    }
}

Solution().testCase()

/**
 128. 最长连续序列
 给定一个未排序的整数数组，找出最长连续序列的长度。
 
 要求算法的时间复杂度为 O(n)。
 示例:

 输入: [100, 4, 200, 1, 3, 2]
 输出: 4
 解释: 最长连续序列是 [1, 2, 3, 4]。它的长度为 4。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/longest-consecutive-sequence
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 学习总结:
 1.一定要优先注意边界，包括起始边界，还有终点边界
 2.关注算法性能问题,如果发现O(n^2)基本上是不会pass的解法。
 3.要仔细考虑题目给的目标区间,比如整数这个条件，就需要考虑负数
 4.一旦产出思考逻辑过渡复杂的时候，其实极大可能思路是错误的。要学会不断评估已有算法的逻辑是否清晰和简明
 */
class Solution {
    
    func longestConsecutive2(_ nums: [Int]) -> Int {
        if nums.count < 2 {
            return nums.count
        }
        
        let sets = Set<Int>(nums)
        var curRes = 1
        var res = 1
        for num in sets {
            var curNum = num
            if !sets.contains(num-1) {
                curRes = 1
                
                while(sets.contains(curNum+1)){
                    curNum += 1
                    curRes += 1
                }
                
                res = max(res, curRes)
            }
        }
        return res
    }
    
    func longestConsecutive(_ nums: [Int]) -> Int {
        if nums.count < 2 {
            return nums.count
        }
        let sortNums = nums.sorted() // O(logn)
        var res = 0
        let n = sortNums.count
        var l=0, repeatCount = 0
        for i in stride(from: 1, to: n, by: 1) {
            if sortNums[i-1] == sortNums[i] {
                repeatCount += 1
            }else {
                if sortNums[i-1] + 1 != sortNums[i] {
                    l = i
                    repeatCount = 0
                }
            }
            res = max(res, i - l + 1 - repeatCount)
        }
        
        return res
    }
    
    func testCase() {
        longestConsecutive([100, 4, 200, 1, 3, 2]) == 4
        longestConsecutive([0,0]) == 1
        longestConsecutive([1,2,0,1]) == 3
        longestConsecutive([0,0,-1]) == 2
        longestConsecutive([9,1,4,7,3,-1,0,5,8,-1,6]) == 7
    }
    
    
}
Solution().testCase()

/*
class Solution {
    var sortNums:[Int]!
    func longestConsecutive(_ nums: [Int]) -> Int {
        if nums.count < 2 {
            return nums.count
        }
        let sorts = nums.sorted() // O(logn)
        sortNums = sorts //O(logm+m)
        var res = 0
        
        var l = 0, r = 0, n = sortNums.count
        while r < n {
            let (con,repeatCnt) = isContinuous(l, r)
            if !con {
                l = r
            }else{
                res = max(res, r-l+1 - repeatCnt)
            }
            
            r += 1
        }
        
        return res
    }
    
    func isContinuous(_ l:Int, _ r:Int) -> (Bool,Int) {
        var repeatCount = 0
        if l == r {
            return (true,repeatCount)
        }
        for i in stride(from: l+1, through: r, by: 1) {
            if sortNums[i-1] == sortNums[i] {
                repeatCount += 1
                continue
            }else if sortNums[i-1] + 1 != sortNums[i] {
                return (false,repeatCount)
            }
        }
        
        return (true,repeatCount)
    }
    
}
 */

/**
 面试题29. 顺时针打印矩阵
 https://leetcode-cn.com/problems/shun-shi-zhen-da-yin-ju-zhen-lcof/
 */
class Solution29 {
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        if matrix.count == 0 || matrix.first?.count == 0 {
            return []
        }
        let rows = matrix.count
        let cols = matrix.first!.count
        let n = rows * cols
        var res = [Int]()
        var visited = [[Int]](repeating: [Int](repeating: 0, count: cols), count: rows)
        let dirs = [[1,0], [0, 1], [-1,0], [0, -1]]
        var dir = 0
        var col = 0, row = 0
        for _ in 0 ..< n {
            let num = matrix[row][col]
            visited[row][col] = 1
            res.append(num)

            let nextRow = row + dirs[dir][1]
            let nextCol = col + dirs[dir][0]

            if nextRow>=rows || nextCol>=cols || nextCol < 0 || nextRow < 0 || visited[nextRow][nextCol]==1 {
                dir = (dir + 1)%4
            }
            row = row + dirs[dir][1]
            col = col + dirs[dir][0]
        }
        return res
    }
}
let tmp = Solution29().spiralOrder([[1,2,3],[4,5,6],[7,8,9]])
print(tmp)
tmp == [1,2,3,6,9,8,7,4,5]

/// 238. 除自身以外数组的乘积
/// https://leetcode-cn.com/problems/product-of-array-except-self/
class Solution238 {
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var res = [Int](repeating: 1, count: nums.count)
        var Left = 1
        var Right = 1
        for l in 0..<nums.count {
            res[l] *= Left
            Left = Left * nums[l]
            
            let r = nums.count-1-l
            res[r] *= Right
            Right = Right * nums[r]
            
        }
        return res
    }
}
Solution238().productExceptSelf([1,2,3,4]) == [24,12,8,6]

/*
 /// https://leetcode-cn.com/problems/decode-string/
 学习总结:
    swift基础:
    swift的判断字符是否为数字，用类型转换+optional判断，判断字符是否为字母，用ascii码，[a,z] = (64, 91)和 [A,Z] = (96,123)。
    其实也可以用正则表达式
    算法方面:
        递归思想
        关键是 res + getStr()
        边界条件是 pr == S.count || S[pr] == "]"
        转码核心逻辑:
            let str = getStr()
            while repeatTime!=0{
                str += str
                repeatTime -= 1
            }
            res = res + str
        另外一个很重要的递归出口因子，字符索引指针pr一定是 0..<S.count的
 
 */
class Solution394 {
    var S:[Character] = [Character]()
    var pr:Int = 0 // index pointer
        
    func decodeString(_ s: String) -> String {
        S = Array(s)
        pr = 0
        return getStr()
    }
    
    func getDigit() -> Int {
        var char = S[pr]
        var d = 0
        var i = Int(String(char))
        while i != nil {
            d = d*10 + i!
            pr += 1
            char = S[pr]
            i = Int(String(char))
        }
        return d
    }
    
    func getStr() -> String {
        if pr == S.count || S[pr] == "]" {
            return ""
        }
        
        let cur = S[pr]
        var repeatTimes = 1
        var res = ""
        
        if Int(String(cur)) != nil {
            repeatTimes = getDigit()
                        
            pr += 1 // 跳过[
            
            let str = getStr()
            
            pr += 1 //跳过]
            
            for _ in 0..<repeatTimes{
                res += str
            }
            
        }else if isLetter2(cur) {
            res = res + String(cur)
            pr += 1
        }else{
            pr += 1
        }

        return res + getStr()
    }
    
    func isLetter(_ char:Character) -> Bool {
        let ascii = char.asciiValue!
        if (ascii > 64 && ascii < 91) || (ascii > 96 && ascii < 123) {
            return true
        }
        
        return false
    }        
    
    func isLetter2(_ char:Character) -> Bool {
        let pattern = #"[a-z,A-Z]"#
        if NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: String(char)){
            return true
        }
        return false
    }
    
}
Solution394().decodeString("3[a]2[bc]")

/**
 * Definition for a binary tree node.
 * */
// public class TreeNode {
//      public var val: Int
//      public var left: TreeNode?
//      public var right: TreeNode?
//      public init(_ val: Int) {
//          self.val = val
//          self.left = nil
//         self.right = nil
//      }
//  }
 
/**
 主要是识别每次递归中左叶子节点，
 关键逻辑就是node.left==nil&&node.right==nil并且来自是上一层的左节点，满足三个条件就是左叶子节点啦~s
 */
class Solution404 {
    func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
        
        return helper(root?.left, isLeft: true)+helper(root?.right, isLeft: false)
    }
    
    func helper(_ node:TreeNode?,isLeft:Bool) -> Int {
        if node == nil {
            return 0
        }
        
        if isLeft==true {
            if node?.left == nil && node?.right == nil {
                return node!.val
            }
        }
        return helper(node?.left, isLeft: true)+helper(node?.right, isLeft: false)
    }
}


class Solution257 {
    var routes = [String]()
    func binaryTreePaths(_ root: TreeNode?) -> [String] {
        helper(root, path: "")
        return routes
    }
    
    func helper(_ node:TreeNode?, path:String ) {
        var path = path
        if node != nil {
            path += String( node!.val)
            if node?.left==nil && node?.right==nil {
                routes.append(path)
            }else{
                path += "->"
                helper(node?.left, path: path)
                helper(node?.right, path: path)
            }
        }
    }
    
    
}
