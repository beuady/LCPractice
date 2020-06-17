import UIKit

var str = "Hello, playground"

//let list = [5,4,3,2,1]
//let n = list.firstIndex(of: 1)
//type(of: n)

var list = [Int?]()
list = [1,2,nil,0]


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
 297 hard,二叉树的序列化与反序列化 序列化是将一个数据结构或者对象转换为连续的比特位的操作，进而可以将转换后的数据存储在一个文件或者内存中，同时也可以通过网络传输到另一个计算机环境，采取相反方式重构得到原数据。

 请设计一个算法来实现二叉树的序列化与反序列化。这里不限定你的序列 / 反序列化算法执行逻辑，你只需要保证一个二叉树可以被序列化为一个字符串并且将这个字符串反序列化为原始的树结构。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/serialize-and-deserialize-binary-tree
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


class Codec {
    func serialize(_ root: TreeNode?) -> String {
        var tmp = _serialize(root, "")
        tmp = String(tmp.prefix(tmp.count-1))
        return "[\(tmp)]"
    }
    
    func deserialize(_ data: String) -> TreeNode? {
        let adata = data[(data.index(after: data.startIndex))..<(data.index(before: data.endIndex))]
        var list = adata.split(separator: ",")
//        print(list)
        return _deserialize(&list)

    }
    func _serialize(_ root: TreeNode?, _ str:String) -> String {
        var str = str
        if root == nil {
            str += "null,"
        }else{
            str += "\(root!.val),"
            str = _serialize(root?.left, str)
            str = _serialize(root?.right, str)
        }
        return str
    }
    
    func _deserialize(_ list:inout [Substring]) -> TreeNode?{
        guard list.count != 0 else {
            return nil
        }
        let str = list.remove(at: 0)
//        print(str)
        if str == "null" {
            return nil
        }else{
            let node = TreeNode(Int(String(str))!)
            node.left = _deserialize(&list)
            node.right = _deserialize(&list)
            return node
        }
    }
    
}

 var codec = Codec()
let node = codec.deserialize("[1,2,3,null,null,4,5]")
codec.serialize(node) == "[1,2,3,null,null,4,5]"


class Codec_Fail_序列化失败 {
    func serialize(_ root: TreeNode?) -> String {
        var data = ""
        
        var queue = [TreeNode?]()
        if let node = root {
            queue.append(node)
        }
        
        while queue.count != 0 {
            let n = queue.count
            
            var isAllNil = true
            for node in queue {
                if node != nil {
                    isAllNil = false
                    break
                }
                
            }
                        
            if isAllNil {
                break
            }
            
            for _ in 0 ..< n {
                let node = queue.removeFirst()
                if node != nil {
                    queue.append(node?.left)
                    queue.append(node?.right)
                    data += "\(node!.val),"
                }else{
//                    print("null")
                    data += "null,"

                }
            }
//            print(queue)
        }
        
        
        return "[\(data[..<(data.index(before: data.endIndex))])]"
    }
    
    /**
     思路: 通过画图可知， 对于第i个结点，f(i) = left,left表示左孩纸在整颗树的索引,
     而这个左孩子的父节点的索引一定是 p(i) = left/2,
     */
    func deserialize(_ data: String) -> TreeNode? {
        let adata = data[(data.index(after: data.startIndex))..<(data.index(before: data.endIndex))]
        let list = adata.split(separator: ",")
        var queue = [TreeNode?]() //statck

        for i in 0..<list.count {
            let str = list[i]
            if str == "null" {
                queue.append(nil)
            }else{

                let val = Int(String(str))!
                let node = TreeNode(val)
                queue.append(node)
            }
        }

        var level = 1
        for i in 0..<queue.count {
            let index = i+1
           
            if index <= level && index != 1 {
                if index % 2 == 0 {//左孩子
                    let pIndex:Int = index/2
                    print("pIndex", pIndex)
                    print(index, index+1)
                    
                    let parent = queue[pIndex]
                    parent?.left = queue[index]
                    parent?.right = queue[index+1]
                }
            }else{
                level *= 2
            }
        }
        return queue.first!
    }
}

// Your Codec object will be instantiated and called as such:
//var node = TreeNode(1)
//node.left = TreeNode(2)
//node.right = TreeNode(3)
//node.right?.left = TreeNode(4)
//node.right?.right = TreeNode(5)

/**
 两个数组的交集 II
 */
class Solution {
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        if nums1.count > nums2.count {
            return intersect(nums2, nums1)
        }
        // nums1长度最小
        var res:[Int] = [Int]()
        
        let nnums2 = nums2.sorted()
        let nnums1 = nums1.sorted()

        for i in 0..<nnums2.count {
            var ares = [Int]()
            for j in 0..<nnums1.count {
                
                if i+j < nnums2.count && nnums1[j] == nnums2[i+j] {
                    ares.append(nnums1[j])
                    print(ares)
                }
            }
            res = ares.count > res.count ? ares : res
        }
        
        return res
    }
    
    func test() {
        intersect([1,2,2,1], [2,2]) == [2,2]
        intersect([4,9,5], [9,4,9,8,4]) == [4,9]
        intersect([2,1], [1,2]) == [1,2]
        intersect([3,1,2], [1,3]) == [1,3]
    }
}
Solution().test()

/**
 移动零
 */
class Solution283 {
    func moveZeroes(_ nums: inout [Int]) {
        var n = 0
        for i in 0..<nums.count {
            if nums[i] != 0 {
                nums.swapAt(n, i)
                n += 1
            }
        }
    }
    func test(){
        var t = [0,1,0,3,12]
        moveZeroes(&t)
        t
    }
}
Solution283().test()

/**
 最长公共前缀
 */
class Solution14 {
    // 分治法
    func longestCommonPrefix(_ strs: [String]) -> String {
        var res = ""
        
        
        
        return res
    }
    func longestCommonPrefix_横向解法(_ strs: [String]) -> String {
        var res = ""
        if strs.count == 0 {
            return res
        }
        let amin = strs.min()!.count
        for i in 0...amin {
            var r:String? = nil
            var isPre = true
            for str in strs {
                if r == nil {
                    r = String(str.prefix(i+1))
//                    print(r, "..")
                }else{
//                    print(r, String(str.prefix(i+1)))
                    if r == String(str.prefix(i+1)) {
                        
                    }else{
                        isPre = false
                    }
                }
            }
            if isPre {
                res = r!
            }
        }
        return res
    }
    
    func test() {
        longestCommonPrefix(["","b"]) == ""
    }
}
Solution14().test()

/**
 1300. 转变数组后最接近目标值的数组和
 给你一个整数数组 arr 和一个目标值 target ，请你返回一个整数 value ，使得将数组中所有大于 value 的值变成 value 后，数组的和最接近  target （最接近表示两者之差的绝对值最小）。

 如果有多种使得和最接近 target 的方案，请你返回这些整数中的最小值。

 请注意，答案不一定是 arr 中的数字。

 */
class Solution1300 {
    func findBestValue(_ arr: [Int], _ target: Int) -> Int {
        let avg:Int = target / arr.count
        let amax = arr.max()!
//        var amin = arr.min()!
        // 双指针滑动
        var pr_l = avg, pr_r = avg
        var res = target
        var lastAbsValue = Int.max
        while pr_l >= 1 || pr_r <= amax {
            let recentAbs = calTarget(arr, pr_l,target)
            if pr_l >= 1 && recentAbs < lastAbsValue {
                lastAbsValue = recentAbs
                res = pr_l
                print(lastAbsValue, pr_l, "left")
            }
            pr_l -= 1
            let recentAbs2 = calTarget(arr, pr_r, target)
            if pr_r <= amax && recentAbs2 < lastAbsValue {
                lastAbsValue = recentAbs2
                res = pr_r
                print(lastAbsValue, pr_r, "right")
            }
            pr_r += 1
            
//            print("break",recentAbs, recentAbs2, lastAbsValue)
            if recentAbs > lastAbsValue && recentAbs2 > lastAbsValue {
                break
            }

            
            
            if lastAbsValue == 0 {
                break
            }
        }
        
        return res
    }
    
    func calTarget(_ arr:[Int], _ value:Int,_ target:Int) -> Int {
        var sum = 0
        for num in arr {
            sum += num > value ? value : num
        }
        return abs(sum-target)
    }
    
    func test() {
//        findBestValue([60864,25176,27249,21296,20204], 56803) == 11361
//        findBestValue([1547,83230,57084,93444,70879], 71237) == 17422
        findBestValue([4,9,3], 10)==3
//        findBestValue([2,3,5], 10) == 5
    }
}

Solution1300().test()

class Solution217 {
    // 存在重复的元素
    func containsDuplicate(_ nums: [Int]) -> Bool {
        let sorted = nums.sorted()
        for i in 1..<sorted.count {
            if sorted[i] == sorted[i-1]{
                return true
            }
        }
        return false
    }
    
    /**LC
     给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。

     说明：

     你的算法应该具有线性时间复杂度。 你可以不使用额外空间来实现吗？
     */
    //只出现一次的数字
    func singleNumber(_ nums: [Int]) -> Int {
        var res = 0
        for num in nums {
            res ^= num
        }
        return res
    }
    
    /**LC66 加一
     给定一个由整数组成的非空数组所表示的非负整数，在该数的基础上加一。

     最高位数字存放在数组的首位， 数组中每个元素只存储单个数字。

     你可以假设除了整数 0 之外，这个整数不会以零开头。
     */
    func plusOne(_ digits: [Int]) -> [Int] {
        var nums = [Int](repeating: 0, count: digits.count)
        var up = 0
        for i in (0..<digits.count).reversed() {
            if i == digits.count - 1{
                nums[i] = (digits[i]+1)%10
                up = digits[i] == 9 ? 1 : 0
            }else{
                nums[i] = (digits[i]+up)%10
                up = (digits[i]+up) == 10 ? 1 : 0
            }
        }
        if up == 1 {
            nums.insert(1, at: 0)
        }
        return nums
    }
}
class Solution26 {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        for i in (0..<nums.count).reversed() {
            if i>=1 &&  nums[i] == nums[i-1] {
                nums.remove(at: i)
            }
        }
        return nums.count
    }
}

/**
 70. 爬楼梯
 
 f(n) = f(n-1) + f(n-2), f(n)只能从走一步f(n-1)或者走两步f(n-2)达到f(n)，那么f(n)的方案数就是前者的公式,
   p q r
 f(0) = 0
 f(1) = 1
 f(2) = 2
 f(3) = f(2) + f(1) = 3
 f(4) = f(3) + f(2) = 3 + 2
 */
class Solution70 {
    // 递归
    var memo:[Int]!
    func climbStairs(_ n: Int) -> Int {
        if memo == nil {
            memo = [Int](repeating: 0, count: n+1)
        }
        if memo[n]>0 {
            return memo[n]
        }
        if n < 3 {
            memo[n] = n
            return n
        }
        memo[n] = climbStairs(n-1) + climbStairs(n-2)
        return memo[n]
    }
    
    // 动态规划
    func climbStairs_dp(_ n: Int) -> Int {
        var dp = [Int](repeating: 0, count: 3)
        dp[2] = 1
        for _ in 1...n {
            dp[0] = dp[1]
            dp[1] = dp[2]
            dp[2] = dp[0] + dp[1]
            print(dp)
        }
        return dp[2]
    }
}
Solution70().climbStairs(4) == 5

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
