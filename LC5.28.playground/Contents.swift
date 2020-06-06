//iamport UIKit
import Foundation

//for i in stride(from: 0, to: 5, by: 1){
//    print(i)
//}
//print("...")
//for i in stride(from: 0, through: 5, by: 1){
//    print(i)
//}
/**
 学习总结:
 1.一定要优先注意边界，包括起始边界，还有终点边界
 2.关注算法性能问题,如果发现O(n^2)基本上是不会pass的解法。
 3.要仔细考虑题目给的目标区间,比如整数这个条件，就需要考虑负数
 4.一旦产出思考逻辑过渡复杂的时候，其实极大可能思路是错误的。要学会不断评估已有算法的逻辑是否清晰和简明
 */
class Solution {
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
