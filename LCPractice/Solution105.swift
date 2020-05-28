//
//  Solution105.swift
//  LCPractice
//
//  Created by beuady on 2020/5/22.
//  Copyright © 2020 beuady. All rights reserved.
//

import UIKit
/**
105. 从前序与中序遍历序列构造二叉树
 前序遍历 preorder = [3,9,20,15,7]
 中序遍历 inorder = [9,3,15,20,7]

 ///返回如下的二叉树：

   3
  / \
 9  20
   /  \
  15   7
 */
/**
* Definition for a binary tree node.
* public class TreeNode {
*     public var val: Int
*     public var left: TreeNode?
*     public var right: TreeNode?
*     public init(_ val: Int) {
*         self.val = val
*         self.left = nil
*         self.right = nil
*     }
* }
*/
class Solution105: NSObject {
    
    var inorderIndex = [Int:Int]()
    
    func helper(_ preorder: [Int], _ inorder: [Int], _ preL:Int, _ preR:Int,_ inorL:Int, _ inorR:Int) -> TreeNode? {
        if preL > preR {
            return nil
        }
        
        let pre_root = preL
        let root_val = preorder[pre_root]
        let node = TreeNode(root_val)
        let inor_root = inorderIndex[root_val]!
        let tree_left_size = inor_root - inorL // 搜索左子树的节点总数
        
        node.left = helper(preorder, inorder, preL+1, preL+tree_left_size, inorL, inor_root - 1)
        node.right = helper(preorder, inorder, preL+tree_left_size+1, preR, inor_root+1, inorR)
        return node
    }
    
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        for i in 0..<inorder.count {
            inorderIndex[inorder[i]] = i
        }
        
        return helper(preorder, inorder, 0, preorder.count-1, 0, inorder.count-1)
    }
    
    func testCase() {
        let preorder = [3,9,20,15,7]
        let inorder = [9,3,15,20,7]
        let node = buildTree(preorder, inorder)
        print(node)
    }
}
