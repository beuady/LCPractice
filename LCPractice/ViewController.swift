//
//  ViewController.swift
//  LCPractice
//
//  Created by beuady on 2020/5/20.
//  Copyright © 2020 beuady. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView:UITableView!
    var refreshControl:UIRefreshControl!
    
    private var nums = [Int]()
    private let numOfRows = 10
    private let maxNum = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: self.view.bounds)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isEditing = true
        self.view.addSubview(self.tableView)
        
        configureTableDataSource()
        
        let refreshControl1 = UIRefreshControl()
        refreshControl1.addTarget(self, action: Selector.handleRefresh, for: .valueChanged)
        self.refreshControl = refreshControl1
        tableView.addSubview(refreshControl1)
        
    }
    
    @objc func handleRefresh() {
        configureTableDataSource()
        refreshControl.endRefreshing()
    }
    
    func configureTableDataSource() {
        generateionRandomNums()
        tableView.reloadData()
    }
    
    func generateionRandomNums() {
        nums.removeAll()
        
        for _ in 0..<numOfRows {
            nums.append(Int(arc4random_uniform(UInt32(maxNum))))
        }
    }
    

}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(nums[indexPath.row])"
        return cell
    }
    
    
}

extension ViewController:UITableViewDelegate
{
    // MARK: -
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveNum = nums[sourceIndexPath.row]
        nums.remove(at: sourceIndexPath.row)
        nums.insert(moveNum, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            nums.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }
    
    
    
}

extension Selector{
    static let handleRefresh = #selector(ViewController.handleRefresh)
}


