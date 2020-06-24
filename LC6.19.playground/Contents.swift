import UIKit

let s = "abc"

print(s[s.firstIndex(of: "b")!])
let ai = s.index(s.startIndex, offsetBy: 1)
print(ai)
print(s[ai])


class Solution16 {

    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        
    }
    
}

/**
 
 */
class Solution752 {
    
    func openLock(_ deadends: [String], _ target: String) -> Int {
     
        var deadendSet = Set<String>(deadends)
        var visitedSet = Set<String>()
        var q = [String]()
        q.append("0000")
        
        var step = 0
        while !q.isEmpty {
            
            let len = q.count
            for _ in 0..<len {
                let cur = q.removeFirst()
                
                //
                if cur == target {
                    return step
                }
                if deadendSet.contains(cur) {
                    continue
                }
                    
                //
                for j in 0..<4 {
                    let vertex1 = down(cur, j)
                    if !visitedSet.contains(vertex1) {
                        visitedSet.insert(vertex1)
                        q.append(vertex1)
                    }
                    let vertex2 = up(cur, j)
                    if !visitedSet.contains(vertex2) {
                        visitedSet.insert(vertex2)
                        q.append(vertex2)
                    }
                }
            }
            step += 1
            
        }
        return -1
    }
    
    func down(_ z:String, _ index:Int) ->String {
        var s = Array(z)
        if s[index] == "0" {
            s[index] = "9"
        }else{
            s[index] = Character(String(s[index].wholeNumberValue! - 1))
        }
        return String(s)
    }
    
    func up(_ z:String, _ index:Int) ->String {
        var s = Array(z)
        if s[index] == "9" {
            s[index] = "0"
        }else{
            s[index] = Character(String(s[index].wholeNumberValue! + 1))
        }
        return String(s)
    }
    
    
    
}

// Definition for a binary tree node.
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

class Solution {
    func minDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        var q = [TreeNode]()
        q.append(root!)
        
        var depth = 1
        
        while !q.isEmpty {
            
            let len = q.count
            for i in 0..<len {
                
                let node = q.removeFirst()
                if node.left==nil && node.right == nil {
                    return depth
                }else{
                    if let l = node.left {
                        q.append(l)
                    }
                    if let r = node.right {
                        q.append(r)
                    }
                }
            }
            depth += 1
        }
        
        return depth
    }
}

/*
  二进制求和
/
class Solution67 {
    func addBinary(_ a: String, _ b: String) -> String {
        var ai = a.count-1
        var bi = b.count-1
        let aS = Array(a)
        let bS = Array(b)
        var ans = ""
        var cal:Int = 0
        while ai >= 0 || bi >= 0 {
            cal += ai>=0 ? aS[ai].wholeNumberValue! : 0
            cal += bi>=0 ? bS[bi].wholeNumberValue! : 0
            ans = String(cal%2) + ans
            cal = cal / 2
            ai -= 1
            bi -= 1
        }
        if cal > 0 {
            ans = "1" + ans
        }
        return ans
    }
    
    func addBinary_自己(_ a: String, _ b: String) -> String {
        if a.count < b.count {
            return addBinary(b, a)
        }
        
        var res = [Character](repeating: "0", count: a.count+1)
        let aList = Array(a)
        let bList = Array(b)
        var jin = 0
        for i in 0..<aList.count {
            var cal = 0
            let lIndex = aList.count - i - 1
            let rIndex = bList.count - i - 1
            if i < bList.count {
                cal = Int(aList[lIndex].description)! + Int(bList[rIndex].description)! + jin
            }else{
                cal = Int(aList[lIndex].description)! + jin
            }
            jin = cal>=2 ? 1 : 0
            res[lIndex+1] = cal % 2 == 1 ? "1" : "0"
            print(cal, i, jin)
        }
        if jin == 1 {
            res[0] = "1"
        }else{
            return String(res[1..<res.count])
        }
        return String(res)
    }
    
    func test() {
//        addBinary("1010", "1011") == "10101"
        addBinary("11", "1") == "100"

    }
    
}
Solution67().test()

/**
 16.18
/
//class Solution {
//    var map = [String:String]()
//    var set = Set<String>()
//    func patternMatching(_ pattern: String, _ value: String) -> Bool {
//
//    }
//}

/**
 给定一个字符串，验证它是否是回文串，只考虑字母和数字字符，可以忽略字母的大小写。
 说明：本题中，我们将空字符串定义为有效的回文串。
 
/
class Solution125 {
    func isPalindrome(_ s: String) -> Bool {
        let S = Array(s)
        var list = [Character]()
        for str in S {
            if str.isNumber {
                list.append(str)
            }else if str.isLetter {
                if str.isCased {
                    list.append(Character(str.lowercased()))
                }else{
                    list.append(str)
                }
            }
        }

        return list.reversed() == list
    }
    
    func test(){
        isPalindrome("A man, a plan, a canal: Panama") == true
        isPalindrome("race a car") == false
    }
}
Solution125().test()

/**
 给定一个字符串，找到它的第一个不重复的字符，并返回它的索引。如果不存在，则返回 -1。

 示例：

 s = "leetcode"
 返回 0

 s = "loveleetcode"
 返回 2
/
class Solution387 {
    func firstUniqChar(_ s: String) -> Int {
        let S = Array(s)
        let blist = S.map{($0,1)}
        // 闭包的几种写法对比
        // 从这里开始演化:
        //let map = Dictionary(blist, uniquingKeysWith: <#T##(_, _) throws -> _#>)
        // 完整闭包
        let map = Dictionary(blist) { (b0, b1) -> Int in
            return b0 + b1
        }
        /*
        // 简化成一行
        let map2 = Dictionary(blist) { (b0, b1) in return b0 + b1}
        // 简化return
        let map3 = Dictionary(blist) { b0, b1 in b0 + b1}
        // 简化返回值
        let map4 = Dictionary(blist) { (b0, b1) in
            return b0 + b1
        }
        // 参数名缩写
        let map5 = Dictionary(blist) {$0+$1}
        // 运算符缩写（最精简)
        let map6 = Dictionary(blist, uniquingKeysWith: +)
       /
        
        for i in 0..<S.count {
            if map[S[i]]! == 1 {
                return i
            }
        }
        return -1
    }
    
    func test() {
        firstUniqChar("aajjxdsewr")
    }
    
}
Solution387().test()
