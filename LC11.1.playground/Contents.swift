import UIKit
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
