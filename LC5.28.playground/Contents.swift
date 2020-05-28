//iamport UIKit


let s = "2"
Int(s)
let s2 = "a"
Int(s2)

print("hello world")

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
            
        }else if isLetter(cur) {
            res = res + String(cur)
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
}
Solution().decodeString("3[a]2[bc]")
