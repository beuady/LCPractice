import UIKit

//let d = 1e9 // 10的9次方写法

class Solution {
    var visited = [Int]() //访问过的结点
    var maxProb:Double = 0
    func maxProbability(_ n: Int, _ edges: [[Int]], _ succProb: [Double], _ start: Int, _ end: Int) -> Double {
        
        for _ in 0..<n{
            visited.append(0)
        }
        
        // 求权值最大的路径
        dfs(start, n, edges, succProb, end, 1)
        
        
        return maxProb
    }
    
    func dfs(_ vertex:Int, _ n:Int, _ edges: [[Int]], _ succProb: [Double],_ end:Int,_ last:Double)-> Double {
        visited[vertex] = 1
        var prob:Double = 0
        let edgeN = edges.count
        for i in 0..<edgeN {
            
//            print(edges[i][0], vertex, next)
            var next = -1
            if edges[i][0] == vertex {
                next = edges[i][1]
            }
            if edges[i][1] == vertex {
                next = edges[i][0]
            }
            if next != -1 && visited[next] == 0 {
                prob = succProb[i]
                if next == end {
                    print("end, ",prob, last)
                    maxProb = max(maxProb, prob*last)
                    return prob * last
                }else{
                    print("leiji", prob)
                    dfs(next, n, edges, succProb, end,prob)
                }
            }
        }
        return prob
    }
    
    func test() {
//        maxProbability(
//        3,
//        [[0,1],[1,2],[0,2]],
//        [0.5,0.5,0.2],
//        0,
//        2)==0.25
//        maxProbability(
//        3,
//        [[0,1]],
//        [0.5],
//        0,
//        2)==0
        
//        maxProbability(
//        5,
//        [[2,3],[1,2],[3,4],[1,3],[1,4],[0,1],[2,4],[0,4],[0,2]],
//        [0.06,0.26,0.49,0.25,0.2,0.64,0.23,0.21,0.77],
//        0,
//        3)==0.16
//        maxProbability(
//        5,
//        [[1,4],[2,4],[0,4],[0,3],[0,2],[2,3]],
//        [0.37,0.17,0.93,0.23,0.39,0.04],
//        3,
//            4)==0.2139
        
    }
}
Solution().test()

//var visited = [Int](repeating: 0, count: n)
//func dfsz(_ n:Int, _ vertex:Int) {
//    visited[vertex] = true
//    for i in 0..<n {//vertexs
//        if visited[i] == 0 {
//            dfsz(n, i)
//        }
//    }
//}

class Solution2 {
    func numSub(_ s: String) -> Int {
        
        var ones = [Int](repeating: 0, count: s.count)
        let S = Array(s)
        var step = 0
        
        for num in S {
            if num == "1" {
                ones[step] += 1
//                print(ones)
            }else{
                step += 1
            }
        }
        
        var ans = 0
        for count in ones {
            if count > 0 {
                for i in 1...count {
                    ans += i
                }
                
            }
        }
        ans = ans % Int(1000000000+7)
        return ans
    }
    
    func test(){
        numSub("")==200542505
    }
}
//Solution().test()

class Solution1 {
    func numIdenticalPairs(_ nums: [Int]) -> Int {
        var ans = 0
        for i in 0..<nums.count {
            for j in i..<nums.count {
                if i<j && nums[i] == nums[j] {
                    ans += 1
                }
            }
        }
        return ans
    }
    
    func test(){
        numIdenticalPairs([1,2,3,1,1,3])==4
        numIdenticalPairs([1,1,1,1])==6
        
    }
}
//Solution().test()


