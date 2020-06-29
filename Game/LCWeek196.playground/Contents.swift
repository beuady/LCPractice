import UIKit


class Solution {
    func numSubseq(_ nums: [Int], _ target: Int) -> Int {
        var S = nums.sorted()
        
        // 移除上界溢出
        var p = S.count
        for i in 0..<S.count {
            if S[i] > target {
                p = i
                break
            }
        }
        
        var SS = Array(S[0..<p])
        
        
        
        
        // 子序列长度
        // 排除法
        var res = 0
        for n in (1..<SS.count).reversed() {
            for l in 0...(SS.count - n) {
                if l+n < SS.count {
                    
                    if (SS[l] + SS[l+n]) <= target {
                        res += n
                    }
                }
            }
        }
        return res
    }
}

func test() {
    Solution().numSubseq([3,5,6,7], 9)==4
//    Solution().numSubseq([3,5,6,8], 10)==6
}
test()


class Solution2 {
    func canArrange(_ arr: [Int], _ k: Int) -> Bool {
        var sum = 0
        for num in arr {
            sum += num
        }
        return sum % k == 0
    }
    func canArrange_fail(_ arr: [Int], _ k: Int) -> Bool {
        let S = arr.sorted()
        print(S)
        if arr.count == 0 {
            return true
        }
        
        var l = 0
        let n2 = arr.count/2
//        var arr2 = S[n2..<arr.count] //这样有问题
        var arr2 = Array(S[n2..<arr.count])
        while l < n2 {
            for r in 0..<arr2.count {
                if (S[l] + arr2[r]) % k == 0 {
                    arr2.remove(at: r)
                    break
                }
            }
            l += 1
        }
        print(arr2)
        return arr2.count == 0
    }
}

//func test() {
//    Solution().canArrange([1,2,3,4,5,10,6,7,8,9], 5)==true
//    Solution().canArrange([1,2,3,4,5,6], 7)==true
//    Solution().canArrange([1,2,3,4,5,6], 10)==false
//    Solution().canArrange([-10,10], 2)==true
//    Solution().canArrange([-1,1,-2,2,-3,3,-4,4], 3)==true
//    Solution().canArrange([75,5,-5,75,-2,-3,88,10,10,87],85)==true
//}
//test()


/**
 
 */
class Solution1 {
    func isPathCrossing(_ path: String) -> Bool {
        var set = Set<String>()
        var x=0,y=0
        set.insert("00")
        for origin in path {
            
            switch origin {
            case "N":
                y += 1
            case "S":
                y -= 1
            case "E":
                x += 1
            case "W":
                x -= 1
            default:
                break
            }
            let pos = "\(x)\(y)"
//            print(pos)
            if set.contains(pos) {
                return true
            }else{
                set.insert(pos)
            }
        }
        return false
    }
}

//func test(){
//    Solution1().isPathCrossing("NES")==false
//    Solution1().isPathCrossing("NESWW")==true
//    Solution1().isPathCrossing("ES")==false
//}
//test()

