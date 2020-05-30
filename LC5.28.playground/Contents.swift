//iamport UIKit
import Foundation

let s = "2"
Int(s)
let s2 = "a"
Int(s2)

print("hello world")
let pattern = #"[a-z,A-Z]"#
let ch = "a"
NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: ch)

/*
 /// https://leetcode-cn.com/problems/decode-string/
 学习总结:
    swift基础:
    swift的判断字符是否为数字，用类型转换+optional判断，判断字符是否为字母，用ascii码，[a,z] = (64, 91)和 [A,Z] = (96,123)。
    其实也可以用正则表达式
    算法方面:
        递归思想
        关键是 res + getStr()
        边界条件是 pr == S.count || S[pr] == "]"
        转码核心逻辑:
            let str = getStr()
            while repeatTime!=0{
                str += str
                repeatTime -= 1
            }
            res = res + str
        另外一个很重要的递归出口因子，字符索引指针pr一定是 0..<S.count的
 
 */
class Solution394 {
    var S:[Character] = [Character]()
    var pr:Int = 0 // index pointer
        
    func decodeString(_ s: String) -> String {
        S = Array(s)
        pr = 0
        return getStr()
    }
    
    func getDigit() -> Int {
        var char = S[pr]
        var d = 0
        var i = Int(String(char))
        while i != nil {
            d = d*10 + i!
            pr += 1
            char = S[pr]
            i = Int(String(char))
        }
        return d
    }
    
    func getStr() -> String {
        if pr == S.count || S[pr] == "]" {
            return ""
        }
        
        let cur = S[pr]
        var repeatTimes = 1
        var res = ""
        
        if Int(String(cur)) != nil {
            repeatTimes = getDigit()
                        
            pr += 1 // 跳过[
            
            let str = getStr()
            
            pr += 1 //跳过]
            
            for _ in 0..<repeatTimes{
                res += str
            }
            
        }else if isLetter2(cur) {
            res = res + String(cur)
            pr += 1
        }else{
            pr += 1
        }

        return res + getStr()
    }
    
    func isLetter(_ char:Character) -> Bool {
        let ascii = char.asciiValue!
        if (ascii > 64 && ascii < 91) || (ascii > 96 && ascii < 123) {
            return true
        }
        
        return false
    }        
    
    func isLetter2(_ char:Character) -> Bool {
        let pattern = #"[a-z,A-Z]"#
        if NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: String(char)){
            return true
        }
        return false
    }
    
}
Solution394().decodeString("3[a]2[bc]")
