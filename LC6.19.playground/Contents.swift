import UIKit

let s = "abc"

//print(s[s.firstIndex(of: "b")!])
//let ai = s.index(s.startIndex, offsetBy: 1)
//print(ai)
//print(s[ai])
//let array = [2,3,1,2,4,3]

/**
 215. 数组中的第K个最大元素
 */
class Solution215 {
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        let sorted = nums.sorted()
        //        print(sorted)
        var j = 0
        for i in (0..<sorted.count).reversed() {//swift倒序的时候
            //            print(sorted[i])
            j += 1
            if j>=k {
                return sorted[i]
                
            }
        }
        return 0
    }
    
    func test() {
        findKthLargest([3,2,3,1,2,4,5,5,6], 4)==4
        findKthLargest([3,2,1,5,6,4], 2)==5
    }
}
Solution215().test()

// let str = "a"
//print(str)
/**
 长度最小的子数组
 */
class Solution209 {
    // 前缀和+二分查找 O(nlogn)
    func minSubArrayLen(_ s: Int, _ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        //
        var S = [Int](repeating: 0, count: nums.count+1)
        for i in 1...nums.count {
            S[i] = S[i-1] + nums[i-1]
        }
//        print(nums)
//        print(S)
        
        var ans = Int.max
        for i in 1...nums.count {
            let target = S[i-1] + s
            var bound = binarySearch(S, target)
//            print( bound,i-1, target)
            if bound == -1 {
                continue
            }
            if bound <= nums.count {
                ans = min(ans, bound - (i-1))
            }
        }
        return ans == Int.max ? 0 : ans
    }
    
    func binarySearch(_ nums:[Int],_ target:Int) -> Int {
        var l = 0, r = nums.count - 1
        while l < r {
            let mid = (l+r)>>1
            if nums[mid] < target {
                l = mid+1
            }else{
                r = mid
            }
            
        }
        return nums[l] >= target ? l : -1
        
    }
    
    
    func minSubArrayLen_sliceWindow(_ s: Int, _ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        var l = 0, r = 0, res=Int.max
        while r < nums.count {
            while l<=r && isMin(nums,l,r, s) {
                res = min(res, r-l+1)
                l += 1
            }
            r += 1
        }
        if res == Int.max {
            return 0
        }
        return res
    }
    func isMin(_ nums:[Int], _ l:Int, _ r:Int,_ s:Int)->Bool {
        var sum = 0
        for i in l...r {
            sum += nums[i]
        }
        return sum >= s
    }
    
    func test() {
        minSubArrayLen(100, [])
//        minSubArrayLen(7, [2,3,1,2,4,3])==2
//        minSubArrayLen(4, [1,4,4])
        
//        minSubArrayLen(3, [1,1])
    }
}
Solution209().test()

/**
191.位1的个数
 */
class Solution191 {
    func hammingWeight(_ n: Int) -> Int {
        let N = String(n, radix: 2)
        var res = 0
        for char in N {
            if char == "1" {
                res += 1
            }
        }
        return res
    }
}

/**
 合并两个有序数组 88
 给你两个有序整数数组 nums1 和 nums2，请你将 nums2 合并到 nums1 中，使 nums1 成为一个有序数组。

 说明:

 初始化 nums1 和 nums2 的元素数量分别为 m 和 n 。
 你可以假设 nums1 有足够的空间（空间大小大于或等于 m + n）来保存 nums2 中的元素。
  
 */
class Solution88 {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        let N = nums1.count
        var i=0,j=0
        while j<n {
            if i >= m+j {
                nums1.insert(nums2[j], at: i)
                j += 1
            }else{
                if nums2[j] < nums1[i] {
                    nums1.insert(nums2[j], at: i)
                    j += 1
                }
            }
            i += 1
        }
        while nums1.count > N {
            nums1.remove(at: nums1.count-1)
        }
    }
    
    func test(){
        var tmp = [0,0,0,0,0,0,0,0]
        merge(&tmp, 3, [2,5,6], 3)
        print(tmp)
        tmp == [1,2,2,3,5,6]
//        var tmp = [0]
//        merge(&tmp, 0, [1], 1)
//        tmp == [1]
    }
}

Solution88().test()

/**
 41. 缺失的第一个正数
 */
class Solution41 {
    //原地哈算法
    // -1 4 1 3 origins
    // 1 -1 3 4  nums
    // 0 1  2 3  indexs
    func firstMissingPositive(_ nums: [Int]) -> Int {
        var nums = nums
        for i in 0..<nums.count {
            // can swap &&  no repeat
            while nums[i]>=1 && nums[i] <= nums.count && nums[nums[i]-1] != nums[i] {
                (nums[i], nums[nums[i]-1]) = (nums[nums[i]-1], nums[i])
            }
        }
        
        for i in 0..<nums.count {
            if nums[i]-1 != i {
                return i+1
            }
        }
        return nums.count+1
    }
}

/**
  外观数列 38
 */

class Solution38 {
    func countAndSay(_ n: Int) -> String {
        var i = 1
        var last = "1"
        var res = ""
        var count = 0
        while i < n  {
            res = ""
            count = 0
            var lastCh = last.first!
            for ch in last {
                if ch != lastCh {
                    res += "\(count)\(lastCh)"
                    lastCh = ch
                    count = 1
                }else{
                    count += 1
                }
                
            }
            res += "\(count)\(lastCh)" //计算last最后相等的部分
//            print(res)
            last = res
            i += 1
        }

        return last
    }
    
    func countAndSay_enum(_ n: Int) -> String {
        var i = 1
        var last = "1"
        var res = ""
        while i < n  {

            res = ""
            let S = Array(last)
            var j = 1
            var count = 1
            
            while j <= S.count {
                if j == S.count {
                    res += "\(count)\(S[j-1])"
                }else{
                    if S[j-1] != S[j] {
                        res += "\(count)\(S[j-1])"
                        count = 1
                    }else{
                        count += 1
                    }
                }
                j += 1
            }
            
            last = res
           
            i += 1
        }
        return last
    }
    
    func test(){
//        countAndSay(1) == "1"
//        countAndSay(3) == "21"
        countAndSay(4) == "1211"
//        countAndSay(5) == "111221"
//        countAndSay(6) == "312211"

    }
}
Solution38().test()

/**
 有效的字母异位词 242
 */
class Solution242 {
    func isAnagram_sort(_ s: String, _ t: String) -> Bool {
        return s.sorted() == t.sorted()
    }
    func isAnagram(_ s: String, _ t: String) -> Bool {
        if s.count != t.count {
            return false
        }
        let S = Array(s)
        let T = Array(t)
        var map = [Character:Int]()
        for i in 0..<S.count {
            let ch = S[i]
            map[ch] = (map[ch] ?? 0) + 1
        }
        
        for ch in T {
            if let n = map[ch] {
                if n == 0 {
                    return false
                }
                map[ch] = n - 1
            }else{
                return false
            }
        }

        return true
    }
    
    func test() {
        isAnagram("anagram", "nagaram")==true
        isAnagram("rat", "car")==false
    }
}
Solution242().test()

/**
 旋转图像
 */
class Solution48 {
    func rotate(_ matrix: inout [[Int]]) {
        let n = matrix[0].count
        //转置+翻转
//        print(matrix)
        for i in 0..<matrix.count {
            for j in i..<n {
                (matrix[i][j], matrix[j][i]) = ( matrix[j][i],matrix[i][j])
            }
        }
//        print(matrix)
        for i in 0..<matrix.count {
            for j in 0..<n/2 {
                (matrix[i][j], matrix[i][n-j-1]) = ( matrix[i][n-j-1],matrix[i][j])
            }
        }
//        print(matrix)
    }
    
    func test(){
        var inp = [[1,2,3],
        [4,5,6],
        [7,8,9]]
        rotate(&inp)
        
//            [7,4,1],
//            [8,5,2],
//            [9,6,3]

    }
    
}
Solution48().test()


/**
 8 字符串转换整数 (atoi)
 */
class Solution {
     // 状态转换之间的表
     //     ' '    +/-    number    other
     //  start    start    signed    in_number    end
     //  signed    end    end    in_number    end
     //  in_number    end    end    in_number    end
     //  end    end    end    end    end
    let table = [
        "start":["start", "sign", "in_num", "end"],
        "sign":["end", "end", "in_num", "end"],
        "in_num":["end", "end","in_num", "end"],
        "end":["end","end","end","end"],
    ]
    //状态表方法
    func myAtoi(_ str: String) -> Int {
        var res = 0
        
        let S = Array(str)
        var isSub = 0
        var state = "start"
        for ch in S {
            var nextState = 0
            if ch == " " {
                nextState = 0
            }else if ch == "+" || ch == "-" {
                nextState = 1
            }else if ch.isWholeNumber {
                nextState = 2
            }else {
                nextState = 3
            }
            state = table[state]![nextState]
            if state == "sign" {
                isSub = ch == "-" ? 1 : 0
            }else if state == "in_num" {
                res = res * 10 + ch.wholeNumberValue!
                if res > Int32.max {
                    return Int(isSub == 1 ? Int32.min : Int32.max)
                }
            }else if state == "end"{
                break
            }
        }
        res = isSub==1 ? -res : res
        return res
    }
    

    
    /**
     这样下面判断枚举的做法有一个问题，就是对于字符串的变化判断较多。有什么机制可以减少判断的难度？
     答案就是状态机，LeeCode官方题解成为
     */
    func myAtoi_enum(_ str: String) -> Int {
        var res = 0
        let S = Array(str)
        var isSub:Bool?
        var i = 0
        while i < S.count {
            let char = S[i]
                        
            if char == " " {
                if isSub != nil {
                    break
                }
            }else if char == "+" || char == "-" {
                if isSub==nil {
                    isSub = false
                    if char == "-"{
                        isSub = true
                    }
                }else{
                    break
                }
            }else{
                if char.isWholeNumber {
                    if isSub==nil {
                        isSub = false
                    }
                    let temp = res&*10 + char.wholeNumberValue!
                    if  temp > Int32.max {
                        return Int(isSub! ? Int32.min : Int32.max)
                    }
                    res = temp
                }else{
                    break
                }
            }
            
            i += 1
        }
                
        if let sub = isSub, sub{
            return -res
        }
        return res
    }
    
    func test(){
        myAtoi("42")==42
        myAtoi("   -42") == -42
        myAtoi("4193 with words") == 4193
        myAtoi("words and 987") == 0
        myAtoi("+-2")==0
        myAtoi("+1")==1
        myAtoi("-91283472332") == -2147483648
        myAtoi("   +0 123")==0
        myAtoi("2147483648")==Int32.max
        myAtoi("0-1")==0
    }
}
//print(Int32.max)
//print(Int32.min)
Solution().test()

 public class ListNode {
     public var val: Int
     public var next: ListNode?
     public init(_ val: Int) {
         self.val = val
         self.next = nil
     }
 }
/**
 面试题 02.01 移除重复节点
 */
class Solution0201 {
    func removeDuplicateNodes(_ head: ListNode?) -> ListNode? {
        var set = Set<Int>()
        var pre = head
        var cur = head
        while cur != nil {
            if set.contains(cur!.val) {
                pre?.next = cur?.next
            }else{
                set.insert(cur!.val)
                pre = cur
            }
            cur = cur?.next
        }
        return head
    }
}

/**
   实现 strStr()
 */
class Solution28 {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        let H = Array(haystack)
        let N = Array(needle)

        if N.count == 0 {
            return 0
        }
        if H.count == 0 && N.count != 0 {
            return -1
        }
        
        var l = 0, r = 0
        while l < H.count && r < H.count {
            if H[l] == N[0] {
                r = l
                var match = true
                if l+N.count > H.count {//溢出
                    match = false
                }else{
                    while r < l+N.count {
                        if H[r] != N[r-l] {//有一大部分的重复判断
                            match = false
                            break
                        }
                        r += 1
                    }
                }
                if match {
                    return l
                }
            }
            l += 1
        }
        return -1
    }
    
    //其他人的解法
    func strStr_other1(_ haystack: String, _ needle: String) -> Int {
        //边界条件值得学习
        guard !needle.isEmpty else {
            return 0
        }
        guard !haystack.isEmpty else {
            return -1
        }
        
        //太依赖语法糖，算法逻辑没得到锻炼
        var pos = -1;
        if let range = haystack.range(of: needle, options: .literal) {
            if !range.isEmpty {
                pos = haystack.distance(from: haystack.startIndex, to: range.lowerBound)
            }
        }
        
        return pos
    }

    //值得学习的部分字符串API的使用
    func strStr_other2(_ haystack: String, _ needle: String) -> Int {
        if needle == "" { return 0 }
        if needle.count > haystack.count { return -1}
        
        var index: Int = -1
        let step = needle.count
        
        // i = index, c = char
        for (i, c) in haystack.enumerated().makeIterator() {
            if i + step > haystack.count {// 要检查的startIndex+needle.count大于haystack长度，肯定不匹配了
                break
            }
            
            if c == needle.first {//匹配第一个字符
                let start = haystack.index(haystack.startIndex, offsetBy: i)
                let end = haystack.index(start, offsetBy: step)
                // 语法糖找到这个[start..<end]区间，用subscript提取字符串进行匹配判断
                if haystack[start..<end] == needle {
                    index = i
                    break
                }
            }
        }
        
        return index
    }
    
        
    //O(n^2)
    func strStr_timeout(_ haystack: String, _ needle: String) -> Int {
        let H = Array(haystack)
        let N = Array(needle)
        
        for i in 0...H.count {
                        
            var match = true
            if H.count - i < N.count {
                match = false
            }
            for j in i..<H.count {
                if j-i<N.count {
//                    print( j, j-i, H[j], N[j-i])
                    if H[j] != N[j-i] {
                        match = false
                        break
                    }
                }
            }
            if match {
                return i
            }
              
        }
        
        return -1
    }
    
    func test(){
        strStr("a", "")==0
        strStr("", "a") == -1
        strStr("aaaaa","bba") == -1
        strStr("", "")==0
        strStr("hello", "ll") == 2
        strStr("aaaaa", "bba") == -1
    }
}
Solution28().test()

/**
 13. 罗马数字转整数
 easy
 */
class Solution13 {
    // 相对简洁写法，前一个方法的思路如果解析了两个罗马数，就直接跳到未解析的索引继续解析；
    // 这次的思路是逐个解析，当遇到特殊情况，实际上是回差值，由于遍历两遍这个组合罗马字符就回两倍差值即可。
    func romanToInt(_ s: String) -> Int {
        let map:[Character:Int] = ["I":1, "V":5, "X":10, "L":50, "C":100, "D":500, "M":1000]

        let S = Array(s)
        var lastChar = Character(" ")
        var res:Int = 0
        for char in S {
            res += map[char] ?? 0
            if lastChar == "I" && (char == "V" || char == "X") {
                res -= 1*2
            }else if lastChar == "X" && (char == "L" || char == "C") {
                res -= 10*2
            }else if lastChar == "C" && (char == "D" || char == "M") {
                res -= 100*2
            }
                         
            lastChar = char
        }
//        print(res)
        return res
    }
    
    func test(){
//        romanToInt("LVIII")==58
        romanToInt("MCMXCIV")==1994
    }
}
Solution13().test()


class Solution36 {
    //思路，暴力破解
    // 定义三类集合(Set)， 全局遍历，并存入三类集合，
    // 存入后，一边遍历，一边判断当前结点对应的三类集合是否有重复数字
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        //三类集合
        var boxs = [Set<Character>]()
        var cols = [Set<Character>]()
        var rows = [Set<Character>]()

        for _ in 0..<9 {
            boxs.append(Set<Character>())
            cols.append(Set<Character>())
            rows.append(Set<Character>())
        }
//        print("...")
        for row in 0..<9 {
            for col in 0..<9 {
                let num = board[row][col]
                if num != "." {
                    let boxIndex:Int = (row/3)*3+col/3
                    print(num, boxIndex)
                    
                    if rows[row].contains(num) || cols[col].contains(num) || boxs[boxIndex].contains(num){
                        return false
                    }
                    
                    rows[row].insert(num)
                    cols[col].insert(num)
                    boxs[boxIndex].insert(num)
                }
                
            }
        }
        return true
    }
    
    func test(){
        isValidSudoku([
          ["5","3",".",".","7",".",".",".","."],
          ["6",".",".","1","9","5",".",".","."],
          [".","9","8",".",".",".",".","6","."],
          ["8",".",".",".","6",".",".",".","3"],
          ["4",".",".","8",".","3",".",".","1"],
          ["7",".",".",".","2",".",".",".","6"],
          [".","6",".",".",".",".","2","8","."],
          [".",".",".","4","1","9",".",".","5"],
          [".",".",".",".","8",".",".","7","9"]
        ])==true
    }
    
}
Solution36().test()

/**
 139. 单词拆分
 */
class Solution139 {
    
    func wordBreak_dp(_ s: String, _ wordDict: [String]) -> Bool {
        let mapDict = Set<String>(wordDict)

        let S = Array(s)
        var dp = [Bool](repeating: false, count: S.count+1)
        dp[0] = true
        for i in 1...S.count {
            let iIndex = s.index(s.startIndex, offsetBy: i)
            for j in 0..<i{
                let jIndex = s.index(s.startIndex, offsetBy: j)
                let s2 = s[jIndex..<iIndex]
//                print(s2, dp[j], mapDict.contains(String(s2)))
                if dp[j] && mapDict.contains(String(s2)) {
                    dp[i] = true
                    break //因为连续监测之后，后续匹配的单词也是基于前面好几次的dp[j]是否为true,所以，每次迭代只需要找到一个dp[j]&check(j-i)即可
                }
            }
        }
        return dp[s.count]
    }
    
    // BFS
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        let mapDict = Set<String>(wordDict)
        let S = Array(s)
        
        var q = [Int]()
        q.append(0) //假设空值的时候是solution的
        var visited = Set<Int>()
        while q.count > 0 {
            
            let start = q.removeFirst()
            
            if visited.contains(start){
                continue
            }
            visited.insert(start)
            
            for end in start...S.count {
                if mapDict.contains(String(S[start..<end])) {
                    if end == s.count {
                        return true
                    }
                    
                    q.append(end)
                }
            }
        }
        return false
    }
    
    func test() {
        wordBreak("leetcode", ["leet","code"])==true
        wordBreak("applepenapple", ["apple", "pen"])==true
        wordBreak("catsandog", ["cats", "dog", "sand", "and", "cat"])==false
        wordBreak("a", ["a"])==true
wordBreak("fohhemkkaecojceoaejkkoedkofhmohkcjmkggcmnami", ["kfomka","hecagbngambii","anobmnikj","c","nnkmfelneemfgcl","ah","bgomgohl","lcbjbg","ebjfoiddndih","hjknoamjbfhckb","eioldlijmmla","nbekmcnakif","fgahmihodolmhbi","gnjfe","hk","b","jbfgm","ecojceoaejkkoed","cemodhmbcmgl","j","gdcnjj","kolaijoicbc","liibjjcini","lmbenj","eklingemgdjncaa","m","hkh","fblb","fk","nnfkfanaga","eldjml","iejn","gbmjfdooeeko","jafogijka","ngnfggojmhclkjd","bfagnfclg","imkeobcdidiifbm","ogeo","gicjog","cjnibenelm","ogoloc","edciifkaff","kbeeg","nebn","jdd","aeojhclmdn","dilbhl","dkk","bgmck","ohgkefkadonafg","labem","fheoglj","gkcanacfjfhogjc","eglkcddd","lelelihakeh","hhjijfiodfi","enehbibnhfjd","gkm","ggj","ag","hhhjogk","lllicdhihn","goakjjnk","lhbn","fhheedadamlnedh","bin","cl","ggjljjjf","fdcdaobhlhgj","nijlf","i","gaemagobjfc","dg","g","jhlelodgeekj","hcimohlni","fdoiohikhacgb","k","doiaigclm","bdfaoncbhfkdbjd","f","jaikbciac","cjgadmfoodmba","molokllh","gfkngeebnggo","lahd","n","ehfngoc","lejfcee","kofhmoh","cgda","de","kljnicikjeh","edomdbibhif","jehdkgmmofihdi","hifcjkloebel","gcghgbemjege","kobhhefbbb","aaikgaolhllhlm","akg","kmmikgkhnn","dnamfhaf","mjhj","ifadcgmgjaa","acnjehgkflgkd","bjj","maihjn","ojakklhl","ign","jhd","kndkhbebgh","amljjfeahcdlfdg","fnboolobch","gcclgcoaojc","kfokbbkllmcd","fec","dljma","noa","cfjie","fohhemkka","bfaldajf","nbk","kmbnjoalnhki","ccieabbnlhbjmj","nmacelialookal","hdlefnbmgklo","bfbblofk","doohocnadd","klmed","e","hkkcmbljlojkghm","jjiadlgf","ogadjhambjikce","bglghjndlk","gackokkbhj","oofohdogb","leiolllnjj","edekdnibja","gjhglilocif","ccfnfjalchc","gl","ihee","cfgccdmecem","mdmcdgjelhgk","laboglchdhbk","ajmiim","cebhalkngloae","hgohednmkahdi","ddiecjnkmgbbei","ajaengmcdlbk","kgg","ndchkjdn","heklaamafiomea","ehg","imelcifnhkae","hcgadilb","elndjcodnhcc","nkjd","gjnfkogkjeobo","eolega","lm","jddfkfbbbhia","cddmfeckheeo","bfnmaalmjdb","fbcg","ko","mojfj","kk","bbljjnnikdhg","l","calbc","mkekn","ejlhdk","hkebdiebecf","emhelbbda","mlba","ckjmih","odfacclfl","lgfjjbgookmnoe","begnkogf","gakojeblk","bfflcmdko","cfdclljcg","ho","fo","acmi","oemknmffgcio","mlkhk","kfhkndmdojhidg","ckfcibmnikn","dgoecamdliaeeoa","ocealkbbec","kbmmihb","ncikad","hi","nccjbnldneijc","hgiccigeehmdl","dlfmjhmioa","kmff","gfhkd","okiamg","ekdbamm","fc","neg","cfmo","ccgahikbbl","khhoc","elbg","cbghbacjbfm","jkagbmfgemjfg","ijceidhhajmja","imibemhdg","ja","idkfd","ndogdkjjkf","fhic","ooajkki","fdnjhh","ba","jdlnidngkfffbmi","jddjfnnjoidcnm","kghljjikbacd","idllbbn","d","mgkajbnjedeiee","fbllleanknmoomb","lom","kofjmmjm","mcdlbglonin","gcnboanh","fggii","fdkbmic","bbiln","cdjcjhonjgiagkb","kooenbeoongcle","cecnlfbaanckdkj","fejlmog","fanekdneoaammb","maojbcegdamn","bcmanmjdeabdo","amloj","adgoej","jh","fhf","cogdljlgek","o","joeiajlioggj","oncal","lbgg","elainnbffk","hbdi","femcanllndoh","ke","hmib","nagfahhljh","ibifdlfeechcbal","knec","oegfcghlgalcnno","abiefmjldmln","mlfglgni","jkofhjeb","ifjbneblfldjel","nahhcimkjhjgb","cdgkbn","nnklfbeecgedie","gmllmjbodhgllc","hogollongjo","fmoinacebll","fkngbganmh","jgdblmhlmfij","fkkdjknahamcfb","aieakdokibj","hddlcdiailhd","iajhmg","jenocgo","embdib","dghbmljjogka","bahcggjgmlf","fb","jldkcfom","mfi","kdkke","odhbl","jin","kcjmkggcmnami","kofig","bid","ohnohi","fcbojdgoaoa","dj","ifkbmbod","dhdedohlghk","nmkeakohicfdjf","ahbifnnoaldgbj","egldeibiinoac","iehfhjjjmil","bmeimi","ombngooicknel","lfdkngobmik","ifjcjkfnmgjcnmi","fmf","aoeaa","an","ffgddcjblehhggo","hijfdcchdilcl","hacbaamkhblnkk","najefebghcbkjfl","hcnnlogjfmmjcma","njgcogemlnohl","ihejh","ej","ofn","ggcklj","omah","hg","obk","giig","cklna","lihaiollfnem","ionlnlhjckf","cfdlijnmgjoebl","dloehimen","acggkacahfhkdne","iecd","gn","odgbnalk","ahfhcd","dghlag","bchfe","dldblmnbifnmlo","cffhbijal","dbddifnojfibha","mhh","cjjol","fed","bhcnf","ciiibbedklnnk","ikniooicmm","ejf","ammeennkcdgbjco","jmhmd","cek","bjbhcmda","kfjmhbf","chjmmnea","ifccifn","naedmco","iohchafbega","kjejfhbco","anlhhhhg"])==true
    }
    
}
Solution139().test()

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
 124. 二叉树中的最大路径和
 */
class Solution124 {
    var amax = Int.min
    func maxPathSum(_ root: TreeNode?) -> Int {
        maxSum(root)
        return amax
    }
    func maxSum(_ root:TreeNode?)->Int{
        if root == nil {
            return 0
        }
        
        let val = root!.val
        let lSum = max(maxSum(root?.left),0)
        let rSum = max(maxSum(root?.right), 0)
        amax = max(amax, val+lSum+rSum)
        
        return val + max(lSum, rSum)
    }
}

/**
 旋转数组
 */
class Solution189 {
    func rotate(_ nums: inout [Int], _ k: Int) {
        let k = k % nums.count
        reverse(&nums, 0, nums.count - 1)
        reverse(&nums, 0, k-1)
        reverse(&nums, k, nums.count - 1)
    }
    
    func reverse(_ nums:inout [Int], _ start:Int, _ end:Int) {
        var l = start, r = end
        while l < r {
            (nums[l], nums[r]) = (nums[r], nums[l])
            l += 1
            r -= 1
        }
    }
    
    func rotate_(_ nums: inout [Int], _ k: Int) {
        
        let k = k % nums.count
        var count = 0, start = 0
        while count < nums.count {
            var current = start
            var prev = nums[current]
            repeat {
                let next = (current+k) % nums.count
                let temp = nums[next]
                nums[next] = prev
                prev = temp
                current = next
                count += 1
            }while start != current
        
            start += 1
        }

    }
    func test(){
        var tmp = [1,2,3,4,5,6,7]
        rotate(&tmp, 3)
        tmp == [5,6,7,1,2,3,4]
        
        tmp = [-1,-100,3,99]
        rotate(&tmp, 2)
        tmp == [3,99,-1,-100]

    }
    
}
Solution189().test()

/**
  最接近的三数之和
 */
class Solution16 {
    // 排序后，还能排除重复选择的数值，双指针找出最接近的两数之和接近target的值
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        let numsort = nums.sorted()
        var res = nums[0]+nums[1]+nums[2]
        for i in 0..<nums.count {
            var l = i+1 , r = nums.count - 1
            while l<r {
                let sum = numsort[l] + numsort[r] + numsort[i]
                if abs(target - sum) < abs(target - res) {
                    res = sum
                }
                
                if sum < target {
                    l += 1
                }else if sum > target {
                    r -= 1
                }else{
                    return sum
                }
            }
          
        }
        return res
    }
    
    func test() {
        threeSumClosest([-1,2,1,-4],1)==2
    }
}
Solution16().test()

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
 */*/*/*/*/
