import UIKit

//let aword = String("abcd")
//let index = aword.index(aword.startIndex, offsetBy: 2)
//aword[index]


/**
 329. 矩阵中的最长递增路径
 */
class Solution329 {
    var ans = 0
    var memo:[[Int]]!
    var dirs = [[-1, 0], [1,0],[0, -1], [0, 1]]
    func longestIncreasingPath(_ matrix: [[Int]]) -> Int {
        let n = matrix.count
        let m = matrix.first!.count
        memo = [[Int]](repeating: [Int](repeating: 0, count: m), count: n)
        for i in 0..<n {
            for j in 0..<m {
                ans = max(ans, dfs(matrix, i, j))
            }
        }
        return ans
    }
    
    func dfs(_ matrix: [[Int]], _ x:Int, _ y:Int)->Int {
        if memo[x][y] != 0 {
            return memo[x][y]
        }
        memo[x][y] += 1
        
        let n = matrix.count
        let m = matrix.first!.count
        
        for dir in dirs {
            let nx = x + dir[0]
            let ny = y + dir[1]
            if nx >= 0 && ny >= 0 && nx<=n && ny <= m &&
                matrix[nx][ny] >  matrix[x][y] {
                memo[x][y] = max(memo[x][y], )
            }
            
        }

        
        return memo[x][y]
    }
    
    func test(){
        longestIncreasingPath([
          [9,9,4],
          [6,6,8],
          [2,1,1]
        ] ) == 4
    }
}
Solution329().test()

/**
 410. 分割数组的最大值
 */
class Solution {
    
    
    func splitArray(_ nums: [Int], _ m: Int) -> Int {
        var left = 0, right = 0
        let n = nums.count
        for i in 0..<n {
            right += nums[i]
            if left < nums[i] {
                left = nums[i]
            }
        }
        
        while left < right {
            let mid = (left+right)>>1
            if check(nums, mid, m) {
                right = mid
            }else{
                left = mid + 1
            }
        }
        return left
    }
    func check(_ nums:[Int], _ x:Int, _ m:Int) -> Bool{
        var sum = 0
        var cnt = 1
        let n = nums.count
        for i in 0..<n {
            if sum + nums[i] > x {
                cnt += 1
                sum = nums[i]
            }else{
                sum += nums[i]
            }
        }
        
        return cnt <= m
    }
    
    func test(){
        splitArray([7,2,5,10,8], 2) == 18
    }
}
Solution().test()

/**
 64. 最小路径和
 */
class Solution64 {
    var dp:[[Int]]!
    func dfs(_ grid:[[Int]],_ x:Int,_ y:Int) -> Int {
        let m = grid.count, n = grid.first!.count
        if x >= m || y >= n {
            return Int.max
        }
        if dp[x][y] > 0 {
            return dp[x][y]
        }
        if x==m-1 && y == n-1 {
            return grid[x][y]
        }
        let r = dfs(grid, x, y+1)
        let d = dfs(grid, x+1, y)
        dp[x][y] = min(r, d) + grid[x][y]
        return dp[x][y]
    }
    func minPathSum_dfs(_ grid: [[Int]]) -> Int {
        let m = grid.count, n = grid.first!.count
        dp = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        
        return dfs(grid, 0, 0)
    }
    
    func minPathSum_dp(_ grid: [[Int]]) -> Int {
        let m = grid.count, n = grid.first!.count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        
        dp[0][0] = grid[0][0]
        for i in 0..<m {
            for j in 0..<n {
                if i == 0 && j > 0 {
                    dp[i][j] = dp[i][j-1] + grid[i][j]
                }
                if j == 0 && i > 0 {
                    dp[i][j] = dp[i-1][j] + grid[i][j]
                }
                if j>0 && i > 0 {
                    dp[i][j] = min(dp[i-1][j], dp[i][j-1]) + grid[i][j]
                }
            }
        }
        
        return dp[m-1][n-1]
    }
    
    func test(){
        minPathSum_dfs([
          [1,3,1],
          [1,5,1],
          [4,2,1]
        ])==7
    }
}
Solution64().test()

/*
 167. 两数之和 II - 输入有序数组
 */
class Solution {
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        // 有序，故可以用双指针，基于测量值和target的关系移动指针
        let n = numbers.count
        var l=0, r = n-1
        while l < r {
            
            let sum = numbers[l] + numbers[r]
            if sum == target {
                return [l+1, r+1]
            }else if sum < target {
                l += 1
            }else {
                r -= 1
            }
            
        }
        return []
    }
    
    func twoSum_binary(_ numbers: [Int], _ target: Int) -> [Int] {
        let n = numbers.count
        for i in 0..<n {
            let p = target - numbers[i]
            var l = 0, r = n - 1
            while l < r {
                let midI = (l+r)>>1
                let mid = numbers[midI]
                
                if p == numbers[midI] {
                    if midI == i {
                        break
                    }
                    return i<midI ? [i+1, midI+1] : [midI+1, i+1]
                }else if p < mid {
                    r = midI
                }else {
                    l = midI+1
                }
            }
        }
        
        
        return []
    }
    
    func test(){
        twoSum([2,3,4],6)
    }
}
Solution().test()

/**
 97. 交错字符串
 */
class Solution97 {
    func isInterleave(_ s1: String, _ s2: String, _ s3: String) -> Bool {
        let S1 = Array(s1)
        let S2 = Array(s2)
        let S3 = Array(s3)
        
        var r = 0
        
        
        
        return false
    }
    func test1() {
//        aadbbcbcac
//        aab c c
//        dbb b ac
        isInterleave("aabcc",
        "dbbca",
        "aadbbcbcac")==true
    }
}
Solution97().test1()


/*
 1466. 重新规划路线
 */
class Solution1466 {
    
    func getroot(_ k:inout [Int], _ now:Int)->Int {
        if k[now] != now {
            k[now] = getroot(&k, k[now])
        }
        return k[now]
    }
    
    func minReorder(_ n: Int, _ connections: [[Int]]) -> Int {
        var k = [Int](repeating: 0, count: n+1)
        var sum = 0, ret = 0
        for i in 0..<n {
            k[i] = i
        }
        repeat{
            ret = 0
            for i in 0..<connections.count {
                if getroot(&k, connections[i][0]) == 0 &&
                    getroot(&k, connections[i][1]) != 0 {
                    k[getroot(&k, connections[i][1])] = getroot(&k, connections[i][0])
                    sum += 1
                    ret = 1
                }else if getroot(&k, connections[i][1]) == 0 {
                    k[getroot(&k, connections[i][0])] = getroot(&k, connections[i][1])
                }
            }
        } while ret != 0
        return sum
    }
    
    func test(){
        minReorder(5,
        [[4,3],[2,3],[1,2],[1,0]])==2
    }
}
Solution1466().test()

/**
 35. 搜索插入位置
 */
class Solution35 {
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        let n = nums.count
        for i in 0..<n {
            if nums[i] == target {
                return i
            }else if target < nums[i] {
                return i
            }
        }
//        if target > nums[n-1] {
//            return n
//        }

        return n
    }
    func test() {
        searchInsert([1,3,5,6], 5)==2
        searchInsert([1,3,5,6], 2)==1
        searchInsert([1,3,5,6], 7)==4
        searchInsert([1,3,5,6], 0)==0
        searchInsert([1], 2)==1
    }
}
Solution35().test()
/**
 785. 判断二分图
 */
class Solution785 {
    var valid = true
    var colors = [Int]() //0, 1=red, 2=green
    func isBipartite(_ graph: [[Int]]) -> Bool {
        let n = graph.count
        colors = [Int](repeating: 0, count: n)
        
        for v in 0..<n {
            if colors[v]==0 {
//                dfs(v,1, graph)
                bfs(v,1, graph)
            }
            if !valid {
                return false
            }
        }
        
        
        return valid
    }
    
    func bfs(_ vertex:Int,_ color:Int, _ graph:[[Int]]) {
        colors[vertex] = color
        var queue = [Int]()
        queue.append(vertex)
        while !queue.isEmpty {
            let v = queue.removeFirst()
            let cc = colors[v] == 1 ? 2 : 1
            for next in graph[v] {
                
                if colors[next] == 0 {
                    queue.append(next)
                    colors[next] = cc
                }else if colors[next] != cc {
                    valid = false
                    return
                }
            }
        }
        
    }
    
    func dfs(_ vertex:Int, _ color:Int, _ graph:[[Int]]) {
        colors[vertex] = color
        let c = color == 1 ? 2 : 1
        for next in graph[vertex] {
            if colors[next] == 0 {
                dfs(next, c, graph)
                if !valid {
                    return
                }
            }else if colors[next] == color {// ?
                print(next, colors)
                valid = false
                return
            }
        }
    }
    
    
    
    func test(){
        isBipartite([[1,3],[0,2],[1,3],[0,2]])==true
//        isBipartite([[1,2,3], [0,2], [0,1,3], [0,2]])==false
    }
}
Solution785().test()

class Solution96 {
    func numTrees(_ n: Int) -> Int {
        
        var C:Int = 1
        for i in 0..<n {
            C = C*2 * (2*i + 1) / (i+2)
        }
        return C
    }
}

class Solution120 {
    //状态压缩
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        let n = triangle.count
        var dp = [Int](repeating: 0, count: n)
        var dp1 = [Int](repeating: 0, count: n)
        dp[0] = triangle[0][0]
        for i in 1..<n {
            
            dp1[0] = dp[0] + triangle[i][0]
            for j in 1..<i {
                dp1[j] = min(dp[j-1], dp[j]) + triangle[i][j]
            }
            dp1[i] = dp[i-1] + triangle[i][i]
            
            (dp1, dp) = (dp, dp1)
        }
        
        return dp.min()!
    }
    
    // 状态转移方程
    func minimumTotal_dp(_ triangle: [[Int]]) -> Int {
        let n = triangle.count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)//创建二维状态数组
        
        dp[0][0] = triangle[0][0] //
        for i in 1..<n {
            
            dp[i][0] = dp[i-1][0] + triangle[i][0] //边界状态1
            for j in 1..<i {
                dp[i][j] = min(dp[i-1][j-1], dp[i-1][j]) + triangle[i][j]
            }
            dp[i][i] = dp[i-1][i-1] + triangle[i][i] //边界状态2
            
        }
                
        return dp[n-1].min()! // dp[i][0] ... dp[i][n]的之间的最大值
    }
    
    func test() {
        minimumTotal([[2],[3,4],[6,5,7],[4,1,8,3]])==11
        minimumTotal([[-1],[2,3],[1,-1,-3]]) == -1
        minimumTotal([[2],[3,4],[6,5,7],[4,1,8,3]])==11
    }
    
}
Solution120().test()

class Solution350 {
    // sorted
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var ans = [Int]()
        
        let s1 = nums1.sorted()
        let s2 = nums2.sorted()
        let n1 = s1.count, n2 = s2.count
        var i=0, j=0
        while i < n1 && j < n2 {
            if s1[i] == s2[j] {
                ans.append(s1[i])
                i += 1
                j += 1
            }else if s1[i] > s2[j] {
                j += 1
            }else{
                i += 1
            }
        }
        
        return ans

    }
    func intersect_map(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        let slice = nums1.map{($0,1)}
        var map1 = Dictionary(slice, uniquingKeysWith: +)
        var ans = [Int]()
        for num in nums2 {
            if let n = map1[num], n > 0 {
                map1[num] = n - 1
                ans.append(num)
            }
        }
        return ans
    }
    
    func test(){
        intersect([1,2,2,1], [2,2])
    }
}
Solution350().test()


/**
 309. 最佳买卖股票时机含冷冻期
 */
class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        var ans = 0
        let n = prices.count
        
        for i in 0..<n {
//            let mx = max(
        }
    }
    
    func test(){
        
    }
}

Solution().test()



/*
class Solution {
    static final long P = Integer.MAX_VALUE;
    static final long BASE = 41;


    public long getHash(String s) {
        long hashValue = 0;
        for (int i = s.length() - 1; i >= 0; --i) {
            hashValue = (hashValue * BASE + s.charAt(i) - 'a' + 1) % P;
        }
        return hashValue;
    }
 
     public int respace(String[] dictionary, String sentence) {
     Set<Long> hashValues = new HashSet<Long>();
     for (String word : dictionary) {
     hashValues.add(getHash(word));
     }
     
     int[] f = new int[sentence.length() + 1];
     Arrays.fill(f, sentence.length());
     
     f[0] = 0;
     for (int i = 1; i <= sentence.length(); ++i) {
         f[i] = f[i - 1] + 1;
         long hashValue = 0;
         for (int j = i; j >= 1; --j) {
             int t = sentence.charAt(j - 1) - 'a' + 1;
             hashValue = (hashValue * BASE + t) % P;
             if (hashValues.contains(hashValue)) {
                f[i] = Math.min(f[i], f[j - 1]);
             }
        }
     }
     
     return f[sentence.length()];
     }
}
*/

/**
 面试题 17.13. 恢复空格
 */
class Solution {
    let P = Int64.max
    let BASE:Int64 = 41
    func respace(_ dictionary: [String], _ sentence: String) -> Int {
        var hashValues = Set<Int64>()
        for word in dictionary {
            hashValues.insert(getHash(word))
        }
        print(hashValues)
        let sendLength = sentence.count
        var f = [Int](repeating: 0, count: sentence.count+1)
        
        f[0] = 0
        print("...")
        for i in 1...sendLength {
            f[i] = f[i-1] + 1
            var hashValue:Int64 = 0
            print(i, "i")
            for j in stride(from: i, to: 1, by: -1) {
                print(i,j, "j")
                let t = sentence[sentence.index(sentence.startIndex, offsetBy: j-1)]
                hashValue = (hashValue * BASE + Int64(t.asciiValue!)) % P
                if hashValues.contains(hashValue) {
                    f[i] = min(f[i], f[j-1])
                }
            }
        }
        return f[sendLength]
    }
    
    func getHash(_ s:String) -> Int64  {
        
        var hashValue:Int64 = 0
        let n = s.count
        for i in stride(from: n-1, to: 0, by: -1) {
            var index = s.index(s.startIndex, offsetBy: i)
            let sub = Int64(s[index].asciiValue! - Character("a").asciiValue!)
            hashValue = (hashValue * BASE + sub + 1) % P
        }
        return hashValue
    }
    
    func test(){
        respace(["looked","just","like","her","brother"],
        "jesslookedjustliketimherbrother")==7
    }
}
//Solution().test()

/**
 面试题 16.11. 跳水板
 */
class Solution16_11 {
   func divingBoard(_ shorter: Int, _ longer: Int, _ k: Int) -> [Int] {
        if k == 0 {
            return []
        }
        if shorter == longer {
            return [shorter*k]
        }
        var ans = [Int](repeating: 0, count: k+1)
        var res = 0
        for i in 0...k {
            if i > 0 {
                res = ans[i-1] + longer - shorter
            }else{
                res = (k-i)*shorter + i*longer
            }
            ans[i] = res

        }
        return ans.sorted()
    }
    
    func test(){
        divingBoard(2,
        1118596,
        979)
    }
}
Solution().test()

/**
367. 有效的完全平方数
 */
class Solution367 {
    func isPerfectSquare(_ num: Int) -> Bool {
        var l:Int = 1
        var r = num
        while l <= r {
            let mid = (l+r)>>1
//            print(l, r, mid)
                let target = mid*mid
            if target == num {
                return true
            }else if target < num {
                l = mid+1
            }else if target > num {
                r = mid-1
            }
        }
        return false
    }
    
    func test(){
        isPerfectSquare(2100)==false
    }
}
Solution().test()

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
 669. 修剪二叉搜索树
 */
class Solution {
    func trimBST(_ root: TreeNode?, _ L: Int, _ R: Int) -> TreeNode? {
        if root == nil {
            return nil
        }
        if root!.val > R {
            return trimBST(root?.left, L, R)
        }
        if root!.val < L {
            return trimBST(root?.right, L, R)
        }
        
        root?.left = trimBST(root?.left, L, R)
        root?.right = trimBST(root?.right, L, R)

        return root
    }
        
}

class Solution1361 {
    func validateBinaryTreeNodes(_ n: Int, _ leftChild: [Int], _ rightChild: [Int]) -> Bool {
        if n == 1 {
            return true
        }
        // 图转为最小生成树的基本概念
        // 树至多只有两个子节点的树就是二叉树
        // 抓住一点: 一个合法的树, 边数等于结点数 - 1, 且无环无孤立的点
        var inVs = [Int](repeating: 0, count: n)
        var outVs = [Int](repeating: 0, count: n)
        var edges = 0
        for i in 0..<n {
            if leftChild[i] != -1 {
                edges += 1
                inVs[leftChild[i]] += 1
                outVs[i] += 1
            }
            
            if rightChild[i] != -1 {
                edges += 1
                inVs[rightChild[i]] += 1
                outVs[i] += 1
            }
        }
        
        if edges != n - 1 {
            return false
        }
        
        for i in 0..<n {
            //
            if inVs[i] == 0 && outVs[i] == 0 {//如果结点入度和出度都为0，就是孤立结点
                return false
            }
        }
        
        
        return true
    }
}


class Solution112 {
    func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
        var queue = [TreeNode]()
        var queueVal = [Int]()
        while queue.count != 0 {
            let node = queue.removeFirst()
            let temp = queueVal.removeFirst()
            if node.left == nil && node.right == nil {
                if temp == sum {
                    return true
                }
                continue
            }

            if node.left != nil {
                queue.append(node.left!)
                queueVal.append(node.left!.val+temp)
            }

            if node.right != nil {
                queue.append(node.right!)
                queueVal.append(node.right!.val+temp)
            }

        }
        return false
    }
}

class Solutionxxx {
    func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
        let m = obstacleGrid.count
        let n = obstacleGrid.first!.count
        var dp0 = obstacleGrid[0][0] == 1 ? 0 : 1,
//        var dp1 = obstacleGrid[0][0] == 1 ? 0 : dp0+dp1
        
        
    }
    func uniquePathsWithObstacles1(_ obstacleGrid: [[Int]]) -> Int {
        let m = obstacleGrid.count
        let n = obstacleGrid.first!.count
        var dp = [Int](repeating: 0, count: n) // 滚动数组
        dp[0] = obstacleGrid[0][0] == 1 ? 0 : 1;
        for i in 0..<m {
            for j in 0..<n {
                // f(i,j) = {
                //              0, u(i,j)=0
                //              f(i-1,j)+f(i,j-1), u(i,j)!=0
                //             }
                if obstacleGrid[i][j] == 1 {
                    dp[j] = 0
                    continue
                }
                if j-1>=0 && obstacleGrid[i][j-1]==0 {
                    dp[j] = dp[j] + dp[j-1]
                }
            }
        }
        return dp[n-1] //
    }
}

/**
 32. 最长有效括号
 */
class Solution32 {
    func longestValidParentheses(_ s: String) -> Int {
        let n = s.count
        if n < 2 {
            return 0
        }
        let S = Array(s)
        var stack = [Int]()
        stack.append(-1)
        var maxLen = 0
        for i in 0..<n {
            if S[i] == "(" {
                stack.append(i)
            }else {
                stack.removeLast()
                if stack.isEmpty {
                    stack.append(i)
                }else{
                    maxLen = max(maxLen, i - (stack.last ?? 0))
                }
            }
        }
        return maxLen
    }
    func longestValidParentheses_dp(_ s: String) -> Int {
        let n = s.count
        if n == 0 {
            return 0
        }
        let S = Array(s)
        var dp = [Int](repeating: 0, count: n+1)
        for i in 0..<n {

            if S[i] == ")" && i-dp[i]-1>=0 && S[i-dp[i]-1]=="(" {
                print("..",i, i-dp[i] + 2)
                dp[i+1] = 2 + dp[i] + dp[i+1-dp[i] - 2]
            }
        }
        return dp.max()!
    }
    // 暴力法
    func longestValidParentheses_暴力(_ s: String) -> Int {
        let S = Array(s)
        let n = S.count
        var ans = 0
        var len = n%2==0 ? n : n - 1
        var stack = [Int]()
//        for len in stride(from: n-1, to: 0, by: -2) {
        while len >= 0 {
            let count = n - len+1
            for i in 0..<count{
                // check
                var validCount = 0
                for step in 0..<len {
                    if S[i+step] == "(" {
                        stack.append(i+step)
                    }else{
                        if !stack.isEmpty {
                            stack.removeLast()
                            validCount += 2
                        }
                    }
                }

                if validCount==len {
                    ans = max(ans, len)
                }else{
                    stack.removeAll()
                }

            }
            len -= 2
        }
        return ans
    }
    func test(){
        longestValidParentheses(")()())")==4
//        longestValidParentheses("()")==2
    }
}
Solution().test()

/**
剑指 Offer 53 - II. 0～n-1中缺失的数字
 */
class Solution53 {
    func missingNumber(_ nums: [Int]) -> Int {
        return binarySearch(nums, 0, nums.count-1)
    }
    
    func binarySearch(_ nums:[Int],_ l:Int, _ r:Int) ->Int {
        var l = l , r = r
        while l<r   {
            print(l, r)
            let mid = (l+r)>>1
            if nums[mid] == mid {
                l = mid+1
            }else{
                r = mid-1
            }
        }
        print(nums[l], l)
        return nums[l]==l ? l+1 : l
    }
    
    func test(){
        missingNumber([0,1,3])==2
        missingNumber([0,1,2,3,4,5,6,7,9])==8
        missingNumber([0,1])==2
    }
}
Solution().test()

/**
 剑指 Offer 66. 构建乘积数组
 */
class Solution66 {
    func constructArr(_ a: [Int]) -> [Int] {
        let n = a.count
        if n == 0 {
            return []
        }
        var B = [Int](repeating: 1, count: n)
        var Br = [Int](repeating: 1, count: n)
        B[0] = a[0]
        for i in 1..<n {
            B[i] = B[i-1] * a[i]
        }
        print(B)
        Br[n-1] = a[n-1]
        for i in (0..<n-1).reversed() {
            Br[i] = a[i] * Br[i+1]
        }
        print(Br)
        
        var ans = [Int](repeating: 0, count: n)
        for i in 0..<n {
            if i == 0 {
                ans[i] = Br[i+1]
            }else if i == n - 1 {
                ans[i] = B[i-1]
            }else{
                ans[i] = B[i-1] * Br[i+1]
            }
        }
        return ans
    }
    
    func test(){
//        constructArr([1,2,3,4,5])==[120,60,40,30,24]
        constructArr([7, 2, 2, 4, 2, 1, 8, 8, 9, 6, 8, 9, 6, 3, 2, 1])==[286654464,1003290624,1003290624,501645312,1003290624,2006581248,250822656,250822656,222953472,334430208,250822656,222953472,334430208,668860416,1003290624,2006581248]
    }
}

//Solution().test()


/**
 剑指 Offer 59 - I. 滑动窗口的最大值
 */
class Solution59 {
    // 1<=k<= nums.count
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        if nums.count == 0 {
            return []
        }
        var ans = [Int]()
        var queue = [Int]()
        for i in 0..<k {
            while !queue.isEmpty && nums[queue.last!]<nums[i]{
                queue.removeLast()
            }
            queue.append(i)
        }
        
        ans.append(nums[queue.first!])
        for i in k..<nums.count {
            if queue.first! == i-k {
                queue.removeFirst()
            }
            while !queue.isEmpty && nums[queue.last!]<nums[i]{
                queue.removeLast()
            }
            queue.append(i)
            ans.append(nums[queue.first!])
        }
        return ans
    }
    
    // 单调栈+滑动窗口
    func maxSlidingWindow2(_ nums: [Int], _ k: Int) -> [Int] {
        if nums.count == 0 {
            return []
        }
        var l = 0, r = 0
        var ans = [Int](repeating: 0, count: nums.count-k+1)
        var ascQueue = [Int]() //升序队列
        while r < nums.count {

            while !ascQueue.isEmpty && nums[ascQueue.last!]<nums[r] {
                ascQueue.removeLast()
            }
            ascQueue.append(r)
            
            if r-l+1 == k {
                ans[l] = nums[ascQueue.first!]
                if ascQueue.first! == l {
                    ascQueue.removeFirst()
                }
                l += 1
            }

            
            r += 1
        }
        
        return ans
    }
    
    func test() {
//        maxSlidingWindow([1,3,-1,-3,5,3,6,7], 3)==[3,3,5,5,6,7]
//        maxSlidingWindow([1], 1)==[1]
//        maxSlidingWindow([1,-1], 1)==[1,-1]
        maxSlidingWindow([7,2,4], 2)==[7,4]
    }
}

/**
 剑指 Offer 50. 第一个只出现一次的字符

 */
class Solution50 {
    func firstUniqChar(_ s: String) -> Character {
        let S = Array(s)
        let slice = S.map{($0,1)}
        var map = Dictionary(slice, uniquingKeysWith: +)
        for char in S {
            if map[char] == 1 {
                return char
            }
        }
        return S[0]
    }
}

/**
 剑指 Offer 42. 连续子数组的最大和
 */
class Solution42{
    func maxSubArray(_ nums: [Int]) -> Int {
        var dp = [Int](repeating: 0, count: nums.count)
        var res = 0
        for i in 1..<nums.count {
            dp[i] = nums[i] > 0 ? dp[i]+nums[i] : nums[i]
            res = min(res, dp[i])
        }
        return res
    }
}

/**
 面试题 03.02. 栈的最小值
 MinStack minStack = new MinStack();
 minStack.push(-2);
 minStack.push(0);
 minStack.push(-3);
 minStack.getMin();   --> 返回 -3.
 minStack.pop();
 minStack.top();      --> 返回 0.
 minStack.getMin();   --> 返回 -2.

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/min-stack-lcci
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class MinStack {

    /** initialize your data structure here. */
    var stack = [Int]()
    var deque = [Int]()
    init() {

    }
    
    func push(_ x: Int) {
        stack.append(x)
        if deque.isEmpty{
            deque.append(x)
        }else{
            deque.append(min(deque.last!, x))
        }
    }
    
    func pop() {
        stack.removeLast()
        deque.removeLast()
    }
    
    func top() -> Int {
        return stack.last ?? -1
    }
    
    func getMin() -> Int {
        return deque.last ?? -1
    }
}

/**
 剑指 Offer 59 - II. 队列的最大值
 */
class MaxQueue {
    var queue = [Int]()
    var deque = [Int]()//单调队列
    init() {
        
    }
    
    func max_value() -> Int {
        return deque.first ?? -1
    }
    
    func push_back(_ value: Int) {
        queue.append(value)
        
        while !deque.isEmpty && deque.last! < value {
            deque.removeLast()
        }

        deque.append(value)
    }
    
    func pop_front() -> Int {
        if let num = queue.first {
            queue.removeFirst()
            let n = deque.first ?? -1
            if n == num  {
                deque.removeLast()
            }
            return num
        }
        return -1
    }
}

/**
 * Your MaxQueue object will be instantiated and called as such:
 * let obj = MaxQueue()
 * let ret_1: Int = obj.max_value()
 * obj.push_back(value)
 * let ret_3: Int = obj.pop_front()
 */

/**
 378. 有序矩阵中第K小的元素
 */
class Solution378 {
    func kthSmallest(_ matrix: [[Int]], _ k: Int) -> Int {
        let n = matrix.count
        var left = matrix[0][0]
        var right = matrix[n-1][n-1]
        while left < right {
            let mid = left + ((right - left)>>1)
            if check(matrix,mid, k, n) {
                right = mid
            }else{
                left = mid + 1
            }
        }
        
        return left
    }
    
    func check(_ matrix:[[Int]], _ mid:Int, _ k:Int, _ n:Int)->Bool {
        var i = n-1
        var j = 0
        var num = 0
        while i >= 0 && j < n {
            if matrix[i][j] <= mid {
                num += i + 1
                j += 1
            }else{
                i -= 1
            }
        }
        return num >= k
    }
    
    func test(){
        kthSmallest([
           [ 1,  5,  9],
           [10, 11, 13],
           [12, 13, 15]
        ], 8)==13
    }
    
}
Solution378().test()

/**
 最长重复子数组
 */
class Solution718 {
    func findLength(_ A: [Int], _ B: [Int]) -> Int {
        let n = A.count, m = B.count
        var ans = 0

        for i in 0..<n {
            let len = min(m, n-i)
            let maxLen = maxLength(A,B, i , 0, len)
            ans = max(ans, maxLen)
        }
        
        for i in 0..<m {
            let len = min(n, m-i)
            let maxLen = maxLength(A,B, 0 , i, len)
            ans = max(ans, maxLen)
        }
        
        return ans
    }
    
    func maxLength(_ A:[Int],_ B:[Int], _ addA:Int, _ addB:Int, _ len:Int) -> Int{
        var res = 0, k = 0
        for i in 0..<len {
            if A[addA+i] == B[addB+i]{
                k += 1
            }else{
                k = 0
            }
            res = max(res, k)
        }
        return res
    }
    
    func test(){
        findLength([0,0,0,0,1], [1,0,0,0,0])==4
        findLength([0,0,0,0,0], [0,0,0,0,0])==5
    }
}
Solution718().test()
        
//        dp[i] = dp[i-1]&& target[i]
//        ans = max(ans, dp[i])
