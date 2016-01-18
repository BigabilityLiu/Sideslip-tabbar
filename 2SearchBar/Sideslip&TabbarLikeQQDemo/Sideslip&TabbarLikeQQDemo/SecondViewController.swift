//
//  SecondViewController.swift
//  Sideslip&TabbarLikeQQDemo
//
//  Created by 刘旭东 on 15/12/26.
//  Copyright © 2015年 刘旭东. All rights reserved.
//

import UIKit

class SecondViewController: UITableViewController {

    let items:NSMutableArray = [["name":"大本事","code":"10001"],["name":"二本事","code":"10010"],["name":"三本事","code":"10100"],["name":"四本事","code":"11000"],["name":"小本事","code":"11111"],["name":"没本事","code":"12301"],["name":"没文化","code":"12303"],["name":"迪迦","code":"20223"],["name":"奥特","code":"20339"],["name":"钢铁侠","code":"34303"],["name":"雷神","code":"30002"],["name":"绿巨人","code":"30434"],["name":"美国队长","code":"30043"],["name":"黑寡妇","code":"30234"]]
    var searchController: UISearchController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSearchController()
    }
    func initSearchController(){
        //1
        
        let searchResultsController = ResultsTableViewController()
        searchResultsController.originalArray = items
        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = searchResultsController
        
        //2
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = true
        //3
        let searchBar = searchController.searchBar
        self.tableView.tableHeaderView = searchBar
        searchBar.sizeToFit()
        //4
        //把取消按钮的文本从cancel改成取消
        searchBar.setShowsCancelButton(true, animated: true)
        let button = searchBar.valueForKey("cancelButton")
        button?.setTitle("取消", forState: .Normal)
        searchBar.setShowsCancelButton(false, animated: true)
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]["name"] as? String
        cell.detailTextLabel?.text = items[indexPath.row]["code"] as? String
        
        return cell
    }
}
