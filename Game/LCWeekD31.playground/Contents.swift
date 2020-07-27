import UIKit

class Solution {
    func numOfSubarrays(_ arr: [Int]) -> Int {
        var A = [Int:Int]()
        A[0] = 0
        A[1] = 0
        for num in arr {
            if num % 2 == 0 {
                A[0] = A[0] ?? 0 + 1
            }else{
                A[1] = A[1] ?? 0 + 1
            }
        }
        let len = arr.count
        var ans = 0
        var sum = 0
        for n in 1...len {
            if n==1 {
                ans += A[1]!
                continue
            }
            for j in 0..<n {
                sum = 0
                var p = j
                while p < n {
                    sum += arr[p]%2==1 ? 1 : 0
                    p += 1
                }
                
                if sum % 2 == 1 {
                    ans += 1
                }
            }
        }
        return ans % (Int(1e9)+7)
    }
    func test(){
        numOfSubarrays( [1,2,3,4,5,6,7])==16
        numOfSubarrays([100,100,99,99])==4
    }
}
Solution().test()


class Solution1 {
    func countOdds(_ low: Int, _ high: Int) -> Int {
        
        var count = high - low-1
        if low % 2 == 1 {
            if high%2==1 {
                return (count)/2+(count>0 ? 2 : 1)
            }else{
                return count/2+1
            }
        }else{
            if high%2==1 {
                return count/2+1
            }else{
                return count>0 ? (count/2*2==count ? count/2 : count/2+1) : 0
            }
        }
        
        return 0
    }
    
    func test(){
        countOdds(14, 17)==2
        countOdds(8, 10)==1
        countOdds(3, 7)==3
        countOdds(17, 17)==1
        countOdds(21, 22)==1
        countOdds(3, 5)==2
        countOdds(0, 10)==5
        countOdds(2, 2)==0
        countOdds(13, 18)==3
    }
}
//Solution().test()
