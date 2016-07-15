//
//  MainTableViewController.swift
//  DevTable
//
//  Created by Алексей Агапов on 15/07/16.
//  Copyright © 2016 ru.testing.project. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
  
  var dataSource: [Int] = [] {
    didSet {
      self.tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let refreshingControl: UIRefreshControl = {
      let control = UIRefreshControl()
      control.addTarget(self, action: #selector(refreshDataSource), forControlEvents: UIControlEvents.ValueChanged)
      return control
    }()
    self.refreshControl = refreshingControl
    self.tableView.tableHeaderView?.addSubview(refreshingControl)
    self.refreshControl?.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
    
    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .None
    
    dataSource = Array(1...20)
  }
}

// MARK: - Table view data source
extension MainTableViewController {
  func reloadData() {
    self.tableView.reloadData()
    dispatch_after(dispatch_time_t(2.0), dispatch_get_main_queue()) {
      self.refreshControl?.endRefreshing()
    }
  }
  
  func refreshDataSource() {
    dataSource = Array(1...15)
    reloadData()
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCellWithIdentifier("diagonalTableViewCell") as? DiagonalTableViewCell else {
      return UITableViewCell()
    }
    
    cell.title.text = String(dataSource[indexPath.row])
    
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 54.0
  }
}