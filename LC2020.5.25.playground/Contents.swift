import UIKit

/**
 需要理解的知识点:
 1.dummyHead、dummyTail
 2. 双链表
 3. 哈希表
 补充知识学习: swift的字典的增删改查的细节
 
 什么是LRU?
 答: 能有让目标项有序，且满足最近最少使用原则的算法。集合LRUCache来说，目标项get的次数越多，就是最近使用越多的，随着每一个目标项从LRUCache中get的次数越多，目标项在队列中按频次有序排列，总是让频次最高的在表头，让频次最低的再表尾。第二特性是，当LRUCache容器达到指定数量缓存目标项后，从表尾删除最少频次使用的目标项，再在表头新增新的目标项。
 
 什么是LRUCache?
 答: 基于LRU算法的一种系统缓存管理机制。抽象上有init、get、put三个操作。至于具体特性完全继承LRU算法的特性
 
 什么是双向链表?
 答: 一般链表都指单向链表，每个node中有next指针指向下一个node就是单向链表。特性是每次对其操作，都是从表头开始，遍历到表尾。搜索是O(n),增删都是O(n)。
 然后双向的意思就是，每个node除了next指针，还有一个prev指针指向前一个Node。这样遍历的时候就可以反向遍历。假设双向链表保存一份有序链表数据，双向链表就是多了反序遍历的操作。
 
 为什么要用dummyHead和dummyTail指针？
 答: 因为在LRU算法中，每次进行get操作，需要把存在的缓存放到表头，dummyHead就可以更方便表头的插入。
 最后一点是，当LRU数据结构的容器达到最大容量时候，需要从表尾删除最少用的目标项。为了便利这个操作，就需要dummyTail直接找到链表的表尾进行删除操作。这两个行为的Time Complex都是O(1)
 
 为什么LRU要用哈希表+双链表?
 从算法性能目标来说，这样的设计能让LRU算法的put和get操作的时间复杂度都能达到O(1)
    1) 为什么是双链表机制不是单链表？
        因为对目标项进行移动的时候，实际上是先从链表中第n个项先删除，然后在表头插入。那么，如果是单链表，通过哈希表能直接找到这个第n个项，假设删除这个n项的操作是f(n)，那么f(n)在单向链表的删除的时间复杂度还是O(n-1)。因为需要第n-1个节点，然后才能进行删除。
        双向链表就解决了这个问题。当需要删除第n项的时候，通过指针prev就可以知道n-1节点，删除效率变成了O(1)
    2) 为什么是哈希表?
        LRU当中，get操作属于高频操作，也是一种搜索操作，而哈希表的特性就是高效的搜索能力，时间复杂度就是O(1)。
    3) 为什么是哈希表+双链表组合，难道其他组合不能实现get和put在TimeComplex上是O(1)吗？
        个人认为，是因为这已经是满足LRU特性上最简洁的结构了。假设换其他结构，那些数据结构能实现搜索O(1)。其实是有的哈，我推断是这样的结构: 双向图+哈希表
 */

class DLinkNode {
    var next:DLinkNode?
    var prev:DLinkNode?
    var key:Int?
    var value:Int?
    init() {
        
    }
    init(key:Int, value:Int) {
        self.key = key
        self.value = value
    }
}

class LRUCache {
    private var cache:[Int:DLinkNode] //哈希表
    private var dummyHead:DLinkNode
    private var dummyTail:DLinkNode
    private var capacity:Int
    private var size:Int

    init(_ capacity: Int) {
        self.capacity = capacity
        dummyHead = DLinkNode()
        dummyTail = DLinkNode()
        
        //伪双指针...如何理解？
        dummyHead.next = dummyTail // ??
        dummyTail.prev = dummyHead // ??
        
        cache = [Int:DLinkNode]()
        self.size = 0
        print("init")
    }
    
    func get(_ key: Int) -> Int {
        print("get",key)
        // if map[key] 存在
        // moveTohead(key)
        // return map[key]
        // 否则,返回-1
        if let node = cache[key] {
            moveToHead(node)
            return node.value ?? -1
        }else{
            return -1
        }
    }
    
    func put(_ key: Int, _ value: Int) {
        print("put",key,value)
        // 构建当前node结点
        // 如果存在, removeNode(node),  moveToHead(node)
        // 如果不存在
        //      如果满cache.size() == self.size
        //          则 lastNode = removeNodeTail()且cache.remove(lastNode.key),
        //      直接addNodeToHead且cache[key] = value
        if let existNode = cache[key] {
            existNode.value = value
            removeNode(existNode)
            addToHead(existNode)
        }else{
            self.size += 1
            let node = DLinkNode(key: key, value: value)
            cache[key] = node
            if self.size > self.capacity {
                let tail:DLinkNode? = removeTail()
                if let atail = tail {
                    cache.removeValue(forKey: atail.key!)
                }
                self.size -= 1
            }
            
            addToHead(node)
        }
    }
    
    private func removeNode(_ node:DLinkNode?) {
        node?.prev?.next = node?.next
        node?.next?.prev = node?.prev

    }
    
    private func moveToHead(_ node:DLinkNode?){
//        print("moveToHead")
        removeNode(node)
        addToHead(node)
    }
    private func addToHead(_ node:DLinkNode?){
//        print("addToHead")
        // h -> n1 -> n2 ->... ->n(i)
        node?.prev = dummyHead
        node?.next = dummyHead.next
        dummyHead.next?.prev = node
        dummyHead.next = node
                
    }
    
    private func removeTail() -> DLinkNode? {
//        print("removeTail")
        let res = dummyTail.prev
        removeNode(res)
        return res
    }

}


func testCase(_ keys:[String], _ ress:[[Int]],_ targetRes:[Int?]) -> Bool{
    keys.count == ress.count
    
    var algorithmRes = [Int?]()
    var obj:LRUCache?
    for i in 0 ..< keys.count {
        let key = keys[i]
        let res = ress[i]
        if key == "LRUCache" {
            obj = LRUCache(res[0])
            
            algorithmRes.append(nil)
        }else if key == "get" {
            let v = obj!.get(res[0])
            algorithmRes.append(v)
        }else if key == "put"{
            obj!.put(res[0], res[1])
            algorithmRes.append(nil)
        }
    }
    
    return targetRes == algorithmRes
}

//testCase(["LRUCache","put","put","get","put","get","put","get","get","get"], [[2],[1,1],[2,2],[1],[3,3],[2],[4,4],[1],[3],[4]],
//    [nil,nil,nil,1,nil,-1,nil,-1,3,4])
//testCase(["LRUCache","put","put","get","put","put","get"], [[2],[2,1],[2,2],[2],[1,1],[4,1],[2]], [nil,nil,nil,2,nil,nil,-1])


// let obj = LRUCache(capacity)
//for key in keys {
//     let ret_1: Int = obj.get(key)
//     obj.put(key, value)
//}


/**
 * Your LRUCache object will be instantiated and called as such:
 * let obj = LRUCache(capacity)
 * let ret_1: Int = obj.get(key)
 * obj.put(key, value)
 */


//给定一个整数数组 A，返回其中元素之和可被 K 整除的（连续、非空）子数组的数目
class Solution {
    func subarraysDivByK(_ A: [Int], _ K: Int) -> Int {
        var map = [Int:Int]()
        map[0] = 1 // sum % k == 0 则是有效子数组
        var res = 0
        var sum = 0
        for l in 0..<A.count {
           sum += A[l]
            let modulus = (sum % K + K ) % K  //求正数的取模
            let same = map[modulus]
            if same != nil {
                map[modulus]! += 1
            }
            res += same ?? 0
            map[modulus] = (same ?? 0) + 1
        }
        return res
    }
    
    func testCase() {
        subarraysDivByK([4,5,0,-2,-3,1], 5) == 7
    }
}
Solution().testCase()

/**
 https://leetcode-cn.com/problems/largest-rectangle-in-histogram/
 */
class Solution84 {
    /**
     思路1：
     找出 H(min), 并且找到左右相邻的H>=H(min)的数量n, 面积result = H(min)*n*1 = H(min)*n
        这时候是时间复杂度是O(n^2), 实则上，思路1就是枚举高
     思路2:和思路1类似，就是枚举宽,时间复杂度都是O(n^2)
     */
    func largestRectangleAreaAll(_ heights: [Int]) -> Int {
        if heights.count == 0 {
            return 0
        }
            
        var res = Int.min
        for i in 0 ..< heights.count{
            let center = i, minH = heights[i]
            var l = center-1
            var S = minH
            while l >= 0 {
                if heights[l] >= minH {
                    S += minH
                }else {
                    break
                }
                l -= 1
            }
//            print("S(l)=",S)
            var r = center + 1
            while r < heights.count {
                if heights[r] >= minH {
                    S += minH
                }else {
                    break
                }
                r += 1
            }
//            print("S(r)=",S)
            res = max(res, S)
        }
        
        return res
    }
    
    /*
     思路3： 1）单调栈求出目标区间的左、右边界，分别为L、R。并在每次出栈的是时候知道当前栈的值就是最小最近的高度值,设为H,
     则可以计算每次确定后的面积为 (L-R-1)*H。最后找出所有的区间面积中最大的，就是问题的答案。 这个方式的时间复杂度大概是O(n)*3, O(n)的左边界枚举，O(n)的右边界枚举，O(n)的找出所有面积最大的值
        2）这里-1是枚举左边界的时候，放正栈尾的哨兵。目标是计算区间长度，计算的时候相当于实际只是区间索引的下标，整体左移一个值，比如区间[0,5]，的索引下标的表示方式就是[-1,4]。
        3）注意这里的右边界的哨兵是N+1,N是目标区间右端的索引值
     */
    func largestRectangleArea(_ heights: [Int]) -> Int {
        let n = heights.count
        var left = [Int](repeating: 0, count: heights.count), right = [Int](repeating: 0, count: heights.count)
        
        var mono_stack = [Int]()
        for i in 0 ..< n {
            while !mono_stack.isEmpty && heights[mono_stack.last!] >= heights[i] {
                mono_stack.popLast()
            }
            left[i] = mono_stack.isEmpty ? -1 : mono_stack.last!
            mono_stack.append(i)
        }
        mono_stack.removeAll()
        for i in (0 ..< n).reversed() {
            while !mono_stack.isEmpty && heights[mono_stack.last!] >= heights[i] {
                mono_stack.popLast()
            }
            right[i] = mono_stack.isEmpty ? n : mono_stack.last!
            mono_stack.append(i)
        }
        var ans = 0
        for i in 0 ..< n {
            ans = max(ans, (right[i]-left[i] - 1)*heights[i])
        }
        return ans
    }
}
Solution84().largestRectangleArea(
[2,1,5,6,2,3]) == 10
