import UIKit

/**
 https://leetcode-cn.com/problems/check-if-a-word-occurs-as-a-prefix-of-any-word-in-a-sentence/
 给你一个字符串 sentence 作为句子并指定检索词为 searchWord ，其中句子由若干用 单个空格 分隔的单词组成。

 请你检查检索词 searchWord 是否为句子 sentence 中任意单词的前缀。

 如果 searchWord 是某一个单词的前缀，则返回句子 sentence 中该单词所对应的下标（下标从 1 开始）。
 如果 searchWord 是多个单词的前缀，则返回匹配的第一个单词的下标（最小下标）。
 如果 searchWord 不是任何单词的前缀，则返回 -1 。
 字符串 S 的 「前缀」是 S 的任何前导连续子字符串。

 输入：sentence = "i love eating burger", searchWord = "burg"
 输出：4
 解释："burg" 是 "burger" 的前缀，而 "burger" 是句子中第 4 个单词。

 */
class Solution5416_fail {
    func isPrefixOfWord(_ sentence: String, _ searchWord: String) -> Int {
        let S = Array(sentence)
        let Word = Array(searchWord)
        
        var numberIndex = 0
        var lastLen = Int.max
        var res = [-1,-1,-1] // numberIndex, left,right
        var valid = 0
        var wordStartIndex = 0
        for i in 0 ..< S.count {
            
            // prefix
            if valid==0 && (i==0 || S[i-1] == " ") {
                wordStartIndex = i
            }
            if S[wordStartIndex] == Word[0] && valid < Word.count && S[i] == Word[valid] {
                
                valid += 1
                
                if(valid == Word.count){
                    res[1] = i - Word.count + 1 //find left
//                    valid = 0
                }
                
            }
            
            if S[i] == " " || i==S.count-1 {
                valid = 0
                numberIndex += 1
                res[2] = i - 1
                
                print(res[1],res[2])
                // find min target
                if res[0] == -1 && valid == Word.count {
                    res[0] = numberIndex
                }
            }
        }
        
        
        return res[0]
    }
    
    func test() {
//        let input = "i love eating burger"
//        isPrefixOfWord(input, "burg")
//        let input = "this problem is an easy problem"
//        isPrefixOfWord(input, "pro")
        
        let input = "leetcode corona"
        isPrefixOfWord(input, "leetco")
    }
}

//Solution().test()

class Solution5416 {
    func isPrefixOfWord(_ sentence: String, _ searchWord: String) -> Int {
        let words = sentence.split(separator: " ")
        
        var res = -1
        for i in 0..<words.count {
            let word = words[i]
            if word.prefix(searchWord.count) == searchWord {
                res = i+1
                break
            }
        }
        return res
    }
}

/**
  定长子串中元音的最大数目
https://leetcode-cn.com/problems/maximum-number-of-vowels-in-a-substring-of-given-length/
 给你字符串 s 和整数 k 。

 请返回字符串 s 中长度为 k 的单个子字符串中可能包含的最大元音字母数。

 英文中的 元音字母 为（a, e, i, o, u）。
 
 输入：s = "abciiidef", k = 3
 输出：3
 解释：子字符串 "iii" 包含 3 个元音字母。
 
 提示：

 1 <= s.length <= 10^5
 s 由小写英文字母组成
 1 <= k <= s.length
*/

class Solution5417 {
    func maxVowels2(_ s: String, _ k: Int) -> Int {
        let S = Array(s)
        let vowelMap:Set<Character> = ["a","i","e","o","u"]
        var res = 0
        var queue = [Character]()
        
        if s.count < k {
            return 0
        }
        
        var curRes = 0
        for i in 0 ..< S.count {
            let char = S[i]
               
            if vowelMap.contains(char) {
                curRes += 1
            }
                        
            queue.append(char)
            if(queue.count>k){
                // count > k
                let ch = queue.removeFirst()
                if vowelMap.contains(ch) {
                    curRes -= 1
                }
            }
            res = max(curRes, res)
//            print(queue, curRes)

        }
        
        return res
    }
    
    func maxVowels(_ s: String, _ k: Int) -> Int {
        let S = Array(s)
        let vowelMap:Set<Character> = ["a","i","e","o","u"]
        var res = 0
        var l = 0, r = 0
        
        if s.count < k {
            return 0
        }
        
        var curRes = 0
        while r < S.count {
            let char = S[r]
            
            if vowelMap.contains(char) {
                curRes += 1
            }
            
            if(r-l+1 > k){
                // count > k
                let ch = S[l]
                l += 1
                if vowelMap.contains(ch) {
                    curRes -= 1
                }
            }
            
            r += 1
            res = max(curRes, res)

        }
        
        return res
    }
    
    func testCase() {
        maxVowels("leetcode",3)==2
        maxVowels("abciiidef", 3)==3
        maxVowels("ramadan",2)==1
        maxVowels("ibpbhixfiouhdljnjfflpapptrxgcomvnb", 33)==7
    }
}
Solution5417().testCase()

/**
 TODO
 https://leetcode-cn.com/contest/weekly-contest-190/problems/pseudo-palindromic-paths-in-a-binary-tree/
 */

/**
 TODO
 https://leetcode-cn.com/contest/weekly-contest-190/problems/max-dot-product-of-two-subsequences/
 */
