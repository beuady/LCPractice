import UIKit


class Solution3 {
    var ans = [Int]()
    func maxNonOverlapping(_ nums: [Int], _ target: Int) -> Int {
        var set = Set<Int>()
        set.insert(0)
        var ps = 0, ans = 0
        
        for num in nums {
            ps += num //前缀和
            // 原理是:    设ps(i)是 x1+x2+...xi的前缀和, 则有ps(i) + target = ps(j),
            // 从i到j之间，一定存在。比如x3+...x6=target, 则ps(3)+target = ps(6), 则 ps(6) - target = ps(3)
            // 由于ps(i)的特性是i从0..n递增记录，所以，就有 ps(j) - target的值是否在字典计算过，如果有，则存在这样的连续子数组
            // 最后，为什么字典计算的ps(i)的值要重置，重新寻找？
            // 不太懂~只知道防止重复寻找ps(j)可能会依赖不同的ps(i)
            if set.contains(ps - target) { //
                print(set,"ps=", ps,"ps-target=", ps - target)
                ans += 1
                set.removeAll() //防止重叠
            }
            set.insert(ps)
        }
        return ans
    }
        
    func test() {
        maxNonOverlapping([1,1,1,1,1], 2)==2
//        maxNonOverlapping([-1,3,5,1,4,2,-9], 6)==2
//        maxNonOverlapping([-2,6,6,3,5,4,1,2,8], 10)==3
//        maxNonOverlapping([0,0,0], 0)==3
    }
}
//Solution3().test()

let wed = 2^2
var ccc = powf(2, 3)
let ik = Int(ccc)
type(of: ik)

class Solution2 {
    func findKthBit(_ n: Int, _ k: Int) -> Character {
        if n == 1 {
            //题目保证k有效
            return "0"
        }
        let len = powI(2, n) - 1
        var S = [Int](repeating: 0, count: len)
        // Si = Si-1 + 1 + reverse(si-1)
        // S1 = S[0]
        // S2 = S[0...len]
        for i in 2...n {
            let L = powI(2,i) - 1 //3
            let mid:Int = L/2
            //
            S[mid] = 1
            //
            var l = 0, r = mid-1
//            print(l, r, "l,r")
            let m = mid + 1
            l += m
            r += m
//            print(l, r, "l,r")
            for j in l...r {
                if(i==4){
                    print(j,  r-j );
                }
                // 计算区间，基于mid对称
                S[j] = S[r-j] == 0 ? 1 : 0
            }
            print(S)

        }
        
        return Character("\(S[k-1])")
    }
    
    func powI(_ x:Int, _ y:Int) ->Int {
        return Int(powf(Float(x), Float(y)))
    }
    
    func t(){
//        findKthBit(3, 1)=="0"
//        findKthBit(4, 11)=="1"
        findKthBit(4, 12)=="0"
    }
}
Solution2().t()


class Solution1 {
    func makeGood(_ s: String) -> String {
        if s.count <= 1 {
            return s
        }
        let S = Array(s)
        
        var stack = [Character]()
        let n = S.count
        
        for i in 0..<S.count {
            stack.append(S[i])
            while !stack.isEmpty && check(stack)  {
                stack.removeLast()
                stack.removeLast()
            }
        }
        
        return String(stack)
    }
    
    func check(_ stack:[Character]) ->Bool {
        if stack.count<2 {
            return false
        }
        
        let char = stack.last!
        
        let char_2 = stack[stack.count-2].lowercased().first
                
        if char_2 != char.lowercased().first {
            return false
        }
        
        if char.isLowercase && stack[stack.count-2].isUppercase {
            return true
        }
        
        if stack.last!.isUppercase && stack[stack.count-2].isLowercase {
            return true
        }
        
        return false
    }
    func test(){
//        makeGood("leEeetcode")=="leetcode"
        makeGood("abBAcC")==""
//        makeGood("mC")=="mC"
//        makeGood("Pp")==""
//        makeGood("abBAcC")==""
//        makeGood("RLlr")==""
    }
}
Solution().test()
