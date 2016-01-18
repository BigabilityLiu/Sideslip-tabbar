//
//  ResultsTableViewController.swift
//  Sideslip&TabbarLikeQQDemo
//
//  Created by tayoMIS on 16/1/18.
//  Copyright © 2016年 刘旭东. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController,UISearchResultsUpdating {

    var originalArray = NSMutableArray()
    var resultsArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        self.automaticallyAdjustsScrollViewInsets = false
        //手动加个头试图，高度为searchbar的高度44加上系统状态栏高度20
        let headView = UIView(frame: CGRectMake(0,0,view.frame.width,44+20))
        tableView.tableHeaderView = headView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let target = searchBar.text
        var filteredArray = NSMutableArray()
        //名字包含输入内容或者工号以输入内容开头
        let predicate = NSPredicate(format: "name CONTAINS %@ || code BEGINSWITH %@",target!,target!)
        let results = originalArray.filteredArrayUsingPredicate(predicate)
        
        for item in results{
            filteredArray.addObject(item)
        }
        resultsArray = filteredArray
        filteredArray = []
        self.tableView.reloadData()
        print(resultsArray)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return resultsArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell
        cell.textLabel?.text = resultsArray[indexPath.row]["name"] as? String
        cell.detailTextLabel?.text = resultsArray[indexPath.row]["code"] as? String
        
        return cell
    }


}
