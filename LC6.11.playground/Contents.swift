import UIKit

var str = "Hello, playground"

let list = [5,4,3,2,1]
let n = list.firstIndex(of: 1)
type(of: n)

/**
 根据每日 气温 列表，请重新生成一个列表，对应位置的输出是需要再等待多久温度才会升高超过该日的天数。如果之后都不会升高，请在该位置用 0 来代替。

 例如，给定一个列表 temperatures = [73, 74, 75, 71, 69, 72, 76, 73]，你的输出应该是 [1, 1, 4, 2, 1, 1, 0, 0]。

 提示：气温 列表长度的范围是 [1, 30000]。每个气温的值的均为华氏度，都是在 [30, 100] 范围内的整数。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/daily-temperatures
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 =========
遍历每日的温度值，需要找到比当日大的温度值在后面的第x天，如果没有就是0
 
 */
class Solution739 {
    /**
     单调递减栈，就完美适配这种具有连续单调性的题目
     */
    func dailyTemperatures(_ T: [Int]) -> [Int] {
        var res = [Int](repeating: 0, count: T.count)
        var stack = [Int]()
        for i in 0..<T.count {
            
            // 栈里的每一个都比T[i]大，才记录对应pre的温度差值
            while !stack.isEmpty && T[i] > T[stack.last!] {
                let pre = stack.popLast()!
                res[pre] = i - pre
            }
            
            
            stack.append(i)
        }
        
        return res
    }
    
    func dailyTemperatures_TimeComplex_n2(_ T: [Int]) -> [Int] {
        let sets = Set<Int>(T).sorted()
        var res = [Int](repeating: 0, count: T.count)

        for i in 0..<T.count {
            if sets.firstIndex(of: T[i])! < sets.count - 1 {
                for j in i+1..<T.count {
                    if T[j] > T[i] {
                        res[i] = j - i
                        break
                    }
                }
            }
        }
        print(res)
        return res
    }
    
    func dailyTemperaturesTimeout(_ T: [Int]) -> [Int] {
        if T.count == 0 {
            return []
        }
        var tempIndexMap = [Int:[Int]]()
        var res = [Int](repeating: 0, count: T.count)
        
        for i in 0..<T.count {
            let temp = T[i]
            if let _ = tempIndexMap[temp] {
                var indexs:[Int] = tempIndexMap[temp]! //swift这个地方有点无奈，提取后，需要手动定义可变数组
                indexs.append(i)
                tempIndexMap[temp] = indexs  //这里也充分体现了map存入的不是可变类型,需要重新赋值
            }else{
                tempIndexMap[temp] = [i]
            }
        }
                
        let tempOrders = tempIndexMap.keys.sorted()
        for i in 0..<T.count {
            let temp = T[i]
            let orderIndex = tempOrders.firstIndex(of: temp)!
            if  orderIndex < tempOrders.count-1  {//存在更高的温度(未来或以前)
                for betterI in (orderIndex+1)..<tempOrders.count{
                    let betterTemp = tempOrders[betterI]
                    let indexs = tempIndexMap[betterTemp]!
                    for index in indexs {
                        // found one day
                        if i < index {
                            if(res[i] != 0){
                                res[i] = min(res[i], index - i)
                            }else{
                                res[i] = index - i
                            }
                            break
                        }
                    }
                }
            }
            
        }
//        print("res=\(res)")
        return res
    }
    
    func testCase(){
        dailyTemperatures([73, 74, 75, 71, 69, 72, 76, 73]) == [1, 1, 4, 2, 1, 1, 0, 0]
//        dailyTemperatures([55,38,53,81,61,93,97,32,43,78])==[3,1,1,2,1,1,0,1,1,0]
//        dailyTemperatures([34,80,80,34,34,80,80,80,80,34])==[1,0,0,2,1,0,0,0,0,0]
    }
}

Solution739().testCase()
