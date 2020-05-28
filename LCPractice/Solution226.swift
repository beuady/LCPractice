//
//  Solution1371.swift
//  LCPractice
//
//  Created by beuady on 2020/5/20.
//  Copyright © 2020 beuady. All rights reserved.
//

import Foundation


//Definition for a binary tree node.
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

extension TreeNode: Equatable {
    public static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.val == rhs.val && lhs.left == rhs.left && lhs.right == rhs.right
    }
    
}


/// https://leetcode-cn.com/problems/invert-binary-tree/
class Solution226 {
//   func invertTree(_ root: TreeNode?) -> TreeNode? {
//        if root == nil {
//            return nil
//        }
//        var l = invertTree(root?.left)
//        var r = invertTree(root?.right)
//        root?.left = r
//        root?.right = l
//        return root
//    }
//// 方法2
//    func invertTree2(_ root: TreeNode?) -> TreeNode? {
//        if root == nil {
//            return nil
//        }
//        
//        root?.left = r
//        root?.right = l
//        
//        var l = invertTree(root?.left)
//        var r = invertTree(root?.right)
//        
//        return root
//    }
//    
    
}
