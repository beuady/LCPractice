/// 5424
class Solution5424 {
    func maxProductViolence(_ nums: [Int]) -> Int {
        var res = 0;
        for i in 0 ..< nums.count {
            for j in i ..< nums.count {
                if(i != j){
                    res = max(res,(nums[i]-1)*(nums[j]-1))
                }
            }
        }
        return res
    }
    
    func maxProduct(_ nums: [Int]) -> Int {
        if nums.count < 2 {
            return 0
        }
        var res = 0
        
        var ns = nums.sorted()
        res = (ns.popLast()! - 1)*(ns.popLast()! - 1)
        
        return res
    }
    
    func testCase() {
        maxProduct([3,4,5,2])==12
        maxProduct([1,5,4,5])==16
        maxProduct([3,7])==12
    }
}
//Solution().testCase()


class Solution {
    func maxArea(_ h: Int, _ w: Int, _ horizontalCuts: [Int], _ verticalCuts: [Int]) -> Int {
        // 10^9+7
        var res = 0
        
        let horizontalCuts = horizontalCuts.sorted()
        var maxH = 0, maxW = 0
        for i in 0 ..< horizontalCuts.count-1 {
            maxW = max(maxW, horizontalCuts[i+1] - horizontalCuts[i])
        }
        maxW = max(maxW, horizontalCuts.first!)
        maxW = max(maxW,h - horizontalCuts.last!)

//        print("...")
        let verticalCuts = verticalCuts.sorted()
        for i in 0 ..< verticalCuts.count-1 {
            maxH = max(maxH, verticalCuts[i+1] - verticalCuts[i])
        }
//        print("...")
        maxH = max(maxH, verticalCuts.first!)
        print(h,verticalCuts.last!)
        maxH = max(maxH,w - verticalCuts.last!)

        
//        print("...")
        res = ( maxH &* maxW ) % (Int(pow(10,9))+7)
        
        return res
    }
    func pow(_ base:Double,_ exponet:Int) -> Double {
        var result:Double = 1.0
        var tempBase:Double = base
        var tempExponet:Int = exponet
        
        while tempExponet > 0 {
            if (tempExponet & 1) == 1{
                result *= tempBase
            }
            tempBase *= tempBase
            tempExponet = tempExponet>>1
        }
        return result
    }
    
    func testCase() {
        maxArea(5, 4, [1,2,4], [1,3]) == 4
        maxArea(5, 4, [3, 1], [1]) == 6
        maxArea(5, 4, [3], [3]) == 9
        maxArea(2, 7, [1], [2,1,5])

    }
    
}
Solution().testCase()
