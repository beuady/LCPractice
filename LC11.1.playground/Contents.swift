import UIKit



//1122. 数组的相对排序
class Solution1122 {
    func relativeSortArray(_ arr1: [Int], _ arr2: [Int]) -> [Int] {
        
        let b = arr1.map{($0, 1)}
        var map = Dictionary(b, uniquingKeysWith: +)
        var ans = [Int]()
        var tail = [Int]()
        for num in arr2 {
            
            if let count = map[num] {
                for _ in 0..<count {
                    ans.append(num)
                }
                if count != 0 {
                    //                map[num] = 0
                    map.removeValue(forKey: num)
                }
            }
        }
        
        for (num,count) in map {
            for _ in 0..<count {
                tail.append(num)
            }
        }
        tail = tail.sorted()
        ans = ans + tail
//        print(ans)
        return ans
        
    }
    func test() {
        relativeSortArray([2,3,1,3,2,4,6,7,9,2,19], [2,1,4,3,9,6]) ==
            [2,2,2,1,4,3,3,9,6,7,19]
    }
}
Solution1122().test()


//922. 按奇偶排序数组 II
/**
 给定一个非负整数数组 A， A 中一半整数是奇数，一半整数是偶数。

 对数组进行排序，以便当 A[i] 为奇数时，i 也是奇数；当 A[i] 为偶数时， i 也是偶数。

 你可以返回任何满足上述条件的数组作为答案。

  

 示例：

 输入：[4,2,5,7]
 输出：[4,5,2,7]
 解释：[4,7,2,5]，[2,5,4,7]，[2,7,4,5] 也会被接受。

 */
class Solution922 {
    func sortArrayByParityII(_ A: [Int]) -> [Int] {
        var ans = [Int](repeating: 0, count: A.count)
        var j = 0
        for i in 0..<A.count {
            if A[i] % 2 == 0 {
                ans[j] = A[i]
                j += 2
            }
        }
        j = 1
        for i in 0..<A.count {
            if A[i] % 2 == 1 {
                ans[j] = A[i]
                j += 2
            }
        }
        return ans
    }
}

//31. 下一个排列
class Solution31 {
//    func nextPermutation(_ nums: inout [Int]) {
//
//    }
//    func test() {
//        nextPermutation(<#T##nums: &[Int]##[Int]#>)
//    }
}

class Solution973 {
    func kClosest(_ points: [[Int]], _ K: Int) -> [[Int]] {
        if K >= points.count {
            return points
        }
        let n = points.count
        var map = [(Int,Int)]()
        for i in 0..<n{
            let p = points[i]
            let value = p[0]*p[0] &+ p[1]*p[1]
            map.append((i, value))
        }

        let S = map.sorted{ $0.1 < $1.1}
//        print(S)
        var ans = [[Int]]()
        for i in 0..<K {
            let value = S[i].1
            let index:Int = S[i].0
            ans.append(points[index])
        }
        
        return ans
    }
    
    func test() {
//        kClosest([[1,3],[-2,2]], 1) == [[-2,2]]
        kClosest([[1,3],[-2,2],[2,-2]], 2) == [[-2,2],[2,-2]]
    }
    
}
Solution973().test()

class Solution327 {
    func countRangeSum(_ nums: [Int], _ lower: Int, _ upper: Int) -> Int {
        if nums.count == 0 {
            return 0
        }
        var pre_sum = [Int](repeating: 0, count: nums.count)
        var suffix_sum = [Int](repeating: 0, count: nums.count)
        
        pre_sum[0] = nums[0]
        for i in 1..<nums.count {
            pre_sum[i] = pre_sum[i-1] + nums[i]
        }
    
        suffix_sum[nums.count-1] = nums.last!
        for i in (0..<nums.count-1).reversed() {
            suffix_sum[i] = suffix_sum[i+1] + nums[i]
        }
        print(pre_sum)
        print(suffix_sum)
        var ans = 0
        for sum in pre_sum {
            if lower <= sum && sum <= upper {
                ans += 1
            }
        }
        
        for sum in suffix_sum {
            if lower <= sum && sum <= upper {
                ans += 1
            }
        }
        return ans-1
    }
    
    func test() {
        countRangeSum([2147483647,-2147483648,-1,0],
                      -1,
                      0) == 4
    }
}
Solution327().test()

//1356. 根据数字二进制下 1 的数目排序
class Solution1356 {
    
    func get(_ x:Int)->Int {
        var x = x
        var res = 0
        while x != 0 {
            res += x % 2
            x /= 2
        }
        return res
    }
    
    func sortByBits(_ arr: [Int]) -> [Int] {
        var counts = [Int:Int]()
        for num in arr {
            counts[num] = get(num) //
        }


        let news = arr.sorted { (num0, num1) -> Bool in
                                    
            if counts[num0]! < counts[num1]! {
                return true
            }
            if counts[num0]! > counts[num1]! {
                return false
            }
            return num0 < num1
        }
        
        return news
    }
    
    func test(){
        sortByBits([0,1,2,3,4,5,6,7,8]) == [0,1,2,4,8,3,5,6,7]
    }
    
}
Solution1356().test()


let tmp  = UnicodeScalar(97)
let zz = Character(tmp!)
//127. 单词接龙
class Solution127 {
    var wordSet:Set<String>!
    var queue = [String]()
    var visited = Set<String>()
    func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
        self.wordSet = Set<String>(wordList)

        if wordSet.count == 0 || !wordSet.contains(endWord) {
            return 0
        }
        
        self.queue = [String]()
        queue.append(beginWord)
        self.visited = Set<String>()
        visited.insert(beginWord)
        
        var step = 1
        while !queue.isEmpty {
            
            let currentSize = queue.count
            for _ in 0..<currentSize {
                let curWord = queue.removeFirst()
                if changeWordEveryOneLetter(curWord, endWord) {
                    return step + 1
                }
            }
            
            step += 1
        }
        
        return 0
    }
    
    func changeWordEveryOneLetter(_ curWord:String, _ endWord:String) -> Bool {
        var C = Array(curWord)
        let E = Array(endWord)
        
        let aIndex = Character("a").asciiValue!
        let zIndex = Character("z").asciiValue!
//        print(aIndex, zIndex)
        for i in 0..<E.count {
            // save
            let originChat = C[i]
            
            for k in aIndex...zIndex {
                let char = Character(UnicodeScalar(k))
//                print(char)
                if char == originChat {
                    continue
                }
                
                C[i] = char
                
                let nextWord = String(C)
//                print("nextword= ", nextWord)
                if wordSet.contains(nextWord) {
                    if nextWord == endWord {
                        return true
                    }
                    
                    if !visited.contains(nextWord) {
                        queue.append(nextWord)
                        visited.insert(nextWord)
                    }
                    
                }
                
            }
            // restore
            C[i] = originChat
        }
        return false
    }
    
    func test(){
        ladderLength("hit", "cog", ["hot","dot","dog","lot","log","cog"]) == 5
    }
}

Solution127().test()

//57. 插入区间
class Solution57 {
    /**
     目标： 输出有序不重叠区间列表
        交集判断
        并集合并
        直到所有交集区间都合并咯
     */
    func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        var left = newInterval[0], right = newInterval[1]
        
        var isPlace = false // 是否找到了插入位置
        var targets = [[Int]]()
        for interval in intervals {
            let l = interval[0]
            let r = interval[1]
            
            if r < left {//在插入区间的左边界
                
                targets.append(interval)
                
            }else if right < l {//在插入区间的右边界
                
                if !isPlace {//插入这个新区间
                    targets.append([left, right])
                    isPlace = true
                }
                
                targets.append(interval)
                
            }else{ // 存在交集
                // 输出新的并集区间
                left = min(l ,left)
                right = max(r, right)
            }
            
        }
        
        if !isPlace {
            targets.append([left,right])
        }
        return targets
    }
    
    func test() {
        insert([[1,2],[3,5],[6,7],[8,10],[12,16]], [4,8]) == [[1,2],[3,10],[12,16]]
    }
}
Solution57().test()

//941. 有效的山脉数组
class Solution941 {
    // 线性描述
    func validMountainArray(_ A:[Int]) -> Bool {

        var i = 0,j = A.count - 1
        
        while i+1 < A.count && A[i] < A[i+1] {
            i += 1
        }
        
        while j-1 >= 0 && A[j-1] > A[j] {
            j -= 1
        }
        
        return i == j && i>0 && j < A.count-1
    }
    func validMountainArray2(_ A:[Int]) -> Bool {
        if A.count < 3 {
            return false
        }
        var stack = [Int]()
        var hasTop = false
        for num in A {
            
            if !hasTop {
                if stack.isEmpty || stack.last! < num {
                    stack.append(num)
                }else if stack.last! > num {
                    if stack.count == 1 {
                        break
                    }
                    hasTop = true
                    stack.append(num)
                }
            }else {
                if stack.last! > num {
                    stack.append(num)
                }
            }
            
        }
        return stack.count == A.count && hasTop
    }
    func validMountainArray_暴力(_ A: [Int]) -> Bool {
        if A.count <= 2 {
            return false
        }
        var n1 = A.first!
        var isDesc = false
        for i in 1..<A.count {
            let num = A[i]
            if i == 1 && n1 < num {
                return false
            }
            if isDesc == false {
                if n1 < num {
                    n1 = num
                }else if n1 == num {
                    return false
                }else{
                    isDesc = true
                    n1 = num
                }
            }else{
                if n1 > num  {
                    n1 = num
                }else if n1 == num  {
                    return false
                }else {
                    return false
                }
            }
        }
        return isDesc == true
    }
    func test(){
        validMountainArray([2,1]) == false
        validMountainArray([3,5,5]) == false
        validMountainArray([0,3,2,1]) == true
        validMountainArray([1,3,2]) == true
        validMountainArray([0,1,2,3,4,5,6,7,8,9]) == false
        validMountainArray([2,0,2]) == false
        validMountainArray([9,8,7,6,5,4,3,2,1,0]) == false
    }
}
Solution941().test()

//349. 两个数组的交集
class Solution349 {
    // 双指针
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        let N1 = nums1.sorted()
        let N2 = nums2.sorted()
        var i=0,j=0, index = 0
        var ans = [Int]()
        while i < N1.count && j < N2.count {
            let n1 = N1[i], n2 = N2[j]
            if n1 == n2{
                if index == 0 || n1 != ans[index - 1] {
                    ans.append(n1)
                    index += 1
                }
                i += 1
                j += 1
            }else if n1 < n2 {
                i += 1
            }else {
                j += 1
            }
        }
        return ans
    }
    
    func intersection2(_ nums1: [Int], _ nums2: [Int]) -> [Int] {

        var map = Set<Int>(nums1)
        
        var ans = Set<Int>()
        for num in nums2 {

            if map.contains(num) {

                ans.insert(num)
            }
        }
        return ans.sorted()
    }
}

//140. 单词拆分 II
class Solution140 {
    
    func wordBreak(_ s: String, _ wordDict: [String]) -> [String] {
        
    }
    
    func test(){
        
    }
}
Solution140().test()
