//
//  SideViewController.swift
//  Sideslip&TabbarLikeQQDemo
//
//  Created by 刘旭东 on 15/12/26.
//  Copyright © 2015年 刘旭东. All rights reserved.
//

import UIKit

class SideViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var items = [["name":"开通会员","image":"Ghost1"],
        ["name":"QQ钱包","image":"Ghost1"],
        ["name":"个性装扮","image":"Ghost1"],
        ["name":"我的收藏","image":"Ghost1"],
        ["name":"我的相册","image":"Ghost1"],
        ["name":"我的文件","image":"Ghost1"]]
        
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.clearColor()
    }
}

extension SideViewController:UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel!.text = items[indexPath.row]["name"]
        cell.imageView?.image = UIImage(named: items[indexPath.row]["image"]!)
        
        return cell
    }
}

extension SideViewController:UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(items[indexPath.row])
    }
}
