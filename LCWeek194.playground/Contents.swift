import UIKit

/**
 保证文件名唯一 显示英文描述
 通过的用户数0
 尝试过的用户数0
 用户总通过次数0
 用户总提交次数0
 题目难度Medium
 给你一个长度为 n 的字符串数组 names 。你将会在文件系统中创建 n 个文件夹：在第 i 分钟，新建名为 names[i] 的文件夹。

 由于两个文件 不能 共享相同的文件名，因此如果新建文件夹使用的文件名已经被占用，系统会以 (k) 的形式为新文件夹的文件名添加后缀，其中 k 是能保证文件名唯一的 最小正整数 。

 返回长度为 n 的字符串数组，其中 ans[i] 是创建第 i 个文件夹时系统分配给该文件夹的实际名称。
 
 输入：names = ["kaido","kaido(1)","kaido","kaido(1)"]
 输出：["kaido","kaido(1)","kaido(2)","kaido(1)(1)"]
 解释：注意，如果含后缀文件名被占用，那么系统也会按规则在名称后添加新的后缀 (k) 。
 */
class Solution5441 {
    func getFolderNames(_ names: [String]) -> [String] {

        var ins = [String]()
        var map = [String:Int]()
        var i = 0
        for name in names {
            if let n = map[name] {
                let newName = n>=0 ? "\(name)(\(n+1))" : name
                print(newName)
                if let m = map[newName] {
                    map[newName] = m + 1
                }else{
                    map[newName] = 0
                }
                ins.append(newName)
                map[name] = n + 1
            }else{
                let index = name.lastIndex(of: "(")
                let fName:String = index != nil ? String(name.prefix(upTo: index!)) : name
                if let n = map[fName] {
                    map[fName] = n + 1
                }else{
                    map[fName] = -1
                }

                map[name] = 0
                ins.append(name)
//                print(name,i)
            }
            i += 1
        }
        print(ins)
        return ins
    }
    
    func test() {
//        getFolderNames(["pes","fifa","gta","pes(2019)"]) == ["pes","fifa","gta","pes(2019)"]
//        getFolderNames(["wano","wano","wano","wano"]) == ["wano","wano(1)","wano(2)","wano(3)"]
        getFolderNames(["kaido","kaido(1)","kaido","kaido(1)"]) == ["kaido","kaido(1)","kaido(2)","kaido(1)(1)"]
//        getFolderNames(["kaido","kaido(1)","kaido","kaido(1)","kaido(2)"]) == ["kaido","kaido(1)","kaido(2)","kaido(1)(1)","kaido(2)(1)"]
//        getFolderNames(["kingston(0)","kingston","kingston"]) == ["kingston(0)","kingston","kingston(1)"]
//        getFolderNames(["onepiece","onepiece(1)","onepiece(2)","onepiece(3)","onepiece"])==["onepiece","onepiece(1)","onepiece(2)","onepiece(3)","onepiece(4)"]
//
//        getFolderNames(["m","t","y(4)","t","a","p","h","h","z","z(2)(2)","x(3)","h(4)(3)","l","z(1)","h","s(1)(2)","y(3)(2)","m(3)","i","h","u","j(1)(4)","q","j(1)","c","n(4)","k","s(1)(4)","p(2)","m","r(1)(4)","k(3)","d(3)(1)","e(4)"])==["m","t","y(4)","t(1)","a","p","h","h(1)","z","z(2)(2)","x(3)","h(4)(3)","l","z(1)","h(2)","s(1)(2)","y(3)(2)","m(3)","i","h(3)","u","j(1)(4)","q","j(1)","c","n(4)","k","s(1)(4)","p(2)","m(1)","r(1)(4)","k(3)","d(3)(1)","e(4)"]
    }
    
}

Solution5441().test()

/*
 5440. 数组异或操作
 */

class Solution5440 {
    func xorOperation(_ n: Int, _ start: Int) -> Int {
        var res = -1
        var num = -1
        for i in 0..<n{
            num = start + 2 * i
            if res == -1 {
                res = num
            }else{
                res = res ^ num
            }
        }
        
        
        return res
    }
    
    
    
}
