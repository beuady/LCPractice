import UIKit

var str = "Hello, playground"

//let list = [5,4,3,2,1]
//let n = list.firstIndex(of: 1)
//type(of: n)


/**
 三数之和
 */
class Solution15 {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        let sorts = nums.sorted()
        var res = [[Int]]()
        for i in 0..<sorts.count {
            if i>0 && sorts[i] == sorts[i - 1] {//3元组的第一个元素不重复提取
                continue
            }
            let target = -sorts[i]
            var j = i+1
            var k = sorts.count - 1
            // 双指针, 还要充分利用排序数组的优势，是让j继续去重搜索，还是用k,用排序数组的尾巴反向搜索。这两种都是充分利用排序的优势，提高搜索性能
            while j < k {
                let sum = sorts[j] + sorts[k]
                if sum == target {
                    res.append([sorts[i], sorts[j],sorts[k]])
                    while j<k && sorts[j] == sorts[j+1] {
                        j += 1
                    }
                    while j<k && sorts[k] == sorts[k-1] {
                        k -= 1
                    }
                    j += 1
                    k -= 1
                }else if sum < target {
                    j += 1
                }else{
                    k -= 1
                }
                
            }
           
        }
        print(res)
        return res
    }
    /**
    测试结果：292 / 313 个通过测试用例， 花了那么多时间大约1h+，虽然不是最终答案，但是学会了如下内容：
     1）迭代算法，发现子问题。当前子问题是暴力求解过程中，得到了大量重复的三元组集合。如果暴力去重，时间复杂度只可能是O(n^3)，
     所以子问题就是如何有效得到不重复的集合。
     2)以上是暴力求解过程的思路，强调自身不要否认这些不是最优或者符合时间范围内解决的方案。基于暴力（常规）思维再进行改进和革新，这就是一个自我提高的过程。
     但也不要夸大其意义。从粗略的方案到合理的方案之间，总是有很大的鸿沟，要善于发掘问题的关键点。
     3)以后暴力求解应该在规定时间内停止，因为很有可能花费大量的时间在错误的思路上。
     */
    func threeSum_timeout(_ nums: [Int]) -> [[Int]] {
        if nums.count < 3 {
            return [[Int]]()
        }
        var map = [Int:Int]()
        for i in 0..<nums.count {
            if let z = map[nums[i]]{
                map[nums[i]] = z + 1
            }else{
                map[nums[i]] = 1
            }
        }
        
        var res = [[Int]]()
        var a = 0, b = 0, c = 0
        for i in 0..<nums.count {
            a = nums[i]
            for j in i+1..<nums.count{
                b = nums[j]
                
                let num3 = 0 - (a + b)
                if let _ = map[num3] {
                    c = num3
                    
                    var tmpMap = [Int:Int]()
                    tmpMap[a] = 1
                    if let _ = tmpMap[b]{
                        tmpMap[b]! += 1
                    }else{
                        tmpMap[b] = 1
                    }
                    
                    if let _ = tmpMap[c]{
                        tmpMap[c]! += 1
                    }else{
                        tmpMap[c] = 1
                    }
                    
                    if tmpMap[a]! <= map[a]! &&
                        tmpMap[b]! <= map[b]! &&
                        tmpMap[c]! <= map[c]! {
                        let sorted = [a,b,c].sorted()
                        var has = false
                        for list in res {
                            if list[0] == sorted[0] && list[1] == sorted[1] && list[2] == sorted[2] {
                                has = true
                                break
                            }
                        }
                        if !has {
                            res.append(sorted)
                        }
                    }

                }
                
            }
        }
//        print(res)
        return res
    }
    
    func testCase() {
        threeSum([-1, 0, 1, 2, -1, -4]) == [
          [-1, 0, 1],
          [-1, -1, 2]
        ]
//        threeSum([0,1,1])
//        threeSum([0,0,0,0])
    }
    
}

Solution15().testCase()

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

//Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

/**
 关于树的几个基础问题
 */
class Solution {
    // 最大深度
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        if root?.left == nil && root?.right == nil {
            return 1
        }else if root?.left != nil && root?.right == nil{
            return 1 + maxDepth(root?.left)
        }else if root?.right != nil && root?.left == nil {
            return 1 + maxDepth(root?.right)
        }else{
            return 1 + maxDepth(root?.left)+maxDepth(root?.right)
        }
    }
    
    //验证二叉搜索树
    func isValidBST(_ root: TreeNode?) -> Bool {
        
        return helper(root, Int.min, Int.max)
    }
    
    func helper(_ root:TreeNode?, _ left:Int,_ right:Int)->Bool {
        if root == nil {
            return true
        }
        
        if root!.val <= left || root!.val >= right {
            return false
        }
        return helper(root?.left, left, root!.val) && helper(root?.right, root!.val, right)
    }
    
    // 对称二叉树
    func isSymmetric(_ root: TreeNode?) -> Bool {
        if root == nil {
            return true
        }
        
        var left = root?.left
        var right = root?.right
        var rs = left?.val == right?.val
        return rs && isMirror(left?.left,right?.right) && isMirror(left?.right, right?.left)
    }
    
    func isMirror(_ left:TreeNode?, _ right:TreeNode?) -> Bool {
        if left == nil && right == nil {
            return true
        }else if left != nil && right != nil {
            let rs = left!.val == right!.val
            return rs && isMirror(left?.left,right?.right) && isMirror(left?.right, right?.left)
        }else{
            return false
        }
    }
    
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var res = [[Int]]()
        if root == nil {
            return res
        }
        var queue = [TreeNode]()
        queue.append(root!)
        
        while queue.count != 0 {
            let n = queue.count
            var list = [Int]()
            for _ in 0 ..< n {
                let node = queue.removeFirst()
                list.append(node.val)
                if let lnode = node.left {
                    queue.append(lnode)
                }
                if let rnode = node.right {
                    queue.append(rnode)
                }
            }
            res.append(list)
        }
        return res
    }
    
    // 将有序数组转换为二叉搜索树
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        return helper2(nums, 0, nums.count)
    }
    
    func helper2(_ nums:[Int],_ start:Int,_ end:Int) -> TreeNode? {
        if start >= end {
            return nil
        }
        
        var center:Int = start + (end - start)/2
        if (end - start) % 2 == 1 {
            center += 1
        }
        
        let node = TreeNode(nums[center])
        node.left = helper2(nums, 0, center-1)
        node.right = helper2(nums, center+1, end)
        return node
    }
}

class Solution141 {
    func hasCycle(_ head: ListNode?) -> Bool {
        var fast:ListNode? = head?.next
        var slow:ListNode? = head
        while fast !== slow {
            if fast?.next == nil || fast == nil {
                return false
            }
            fast = fast?.next?.next
            slow = slow?.next
        }
        return true
    }
}

/**
 根据每日 气温 列表，请重新生成一个列表，对应位置的输出是需要再等待多久温度才会升高超过该日的天数。如果之后都不会升高，请在该位置用 0 来代替。

 例如，给定一个列表 temperatures = [73, 74, 75, 71, 69, 72, 76, 73]，你的输出应该是 [1, 1, 4, 2, 1, 1, 0, 0]。

 提示：气温 列表长度的范围是 [1, 30000]。每个气温的值的均为华氏度，都是在 [30, 100] 范围内的整数。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/daily-temperatures
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 =========
遍历每日的温度值，需要找到比当日大的温度值在后面的第x天，如果没有就是0
 
 */
class Solution739 {
    /**
     单调递减栈，就完美适配这种具有连续单调性的题目
     */
    func dailyTemperatures(_ T: [Int]) -> [Int] {
        var res = [Int](repeating: 0, count: T.count)
        var stack = [Int]()
        for i in 0..<T.count {
            
            // 栈里的每一个都比T[i]大，才记录对应pre的温度差值
            while !stack.isEmpty && T[i] > T[stack.last!] {
                let pre = stack.popLast()!
                res[pre] = i - pre
            }
            
            
            stack.append(i)
        }
        
        return res
    }
    
    func dailyTemperatures_TimeComplex_n2(_ T: [Int]) -> [Int] {
        let sets = Set<Int>(T).sorted()
        var res = [Int](repeating: 0, count: T.count)

        for i in 0..<T.count {
            if sets.firstIndex(of: T[i])! < sets.count - 1 {
                for j in i+1..<T.count {
                    if T[j] > T[i] {
                        res[i] = j - i
                        break
                    }
                }
            }
        }
        print(res)
        return res
    }
    
    func dailyTemperaturesTimeout(_ T: [Int]) -> [Int] {
        if T.count == 0 {
            return []
        }
        var tempIndexMap = [Int:[Int]]()
        var res = [Int](repeating: 0, count: T.count)
        
        for i in 0..<T.count {
            let temp = T[i]
            if let _ = tempIndexMap[temp] {
                var indexs:[Int] = tempIndexMap[temp]! //swift这个地方有点无奈，提取后，需要手动定义可变数组
                indexs.append(i)
                tempIndexMap[temp] = indexs  //这里也充分体现了map存入的不是可变类型,需要重新赋值
            }else{
                tempIndexMap[temp] = [i]
            }
        }
                
        let tempOrders = tempIndexMap.keys.sorted()
        for i in 0..<T.count {
            let temp = T[i]
            let orderIndex = tempOrders.firstIndex(of: temp)!
            if  orderIndex < tempOrders.count-1  {//存在更高的温度(未来或以前)
                for betterI in (orderIndex+1)..<tempOrders.count{
                    let betterTemp = tempOrders[betterI]
                    let indexs = tempIndexMap[betterTemp]!
                    for index in indexs {
                        // found one day
                        if i < index {
                            if(res[i] != 0){
                                res[i] = min(res[i], index - i)
                            }else{
                                res[i] = index - i
                            }
                            break
                        }
                    }
                }
            }
            
        }
//        print("res=\(res)")
        return res
    }
    
    func testCase(){
        dailyTemperatures([73, 74, 75, 71, 69, 72, 76, 73]) == [1, 1, 4, 2, 1, 1, 0, 0]
//        dailyTemperatures([55,38,53,81,61,93,97,32,43,78])==[3,1,1,2,1,1,0,1,1,0]
//        dailyTemperatures([34,80,80,34,34,80,80,80,80,34])==[1,0,0,2,1,0,0,0,0,0]
    }
}

Solution739().testCase()
