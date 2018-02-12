//
//  SportsTableViewController.swift
//  thebatesstudent
//
//  Created by Imad Rajwani on 1/18/18.
//  Copyright © 2018 Imad Rajwani. All rights reserved.
//

import UIKit

class SportsTableViewController: UITableViewController {

    private var sports: [Sports]?
    private var sportscellStates: [SportsCellState]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.blue], for: .selected)
        //        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.orange], for: .normal)
        tableView.estimatedRowHeight = 155.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        fetchSports()
        
    }
    
    private func fetchSports()
    {
        let feedParser = FeedParser_sports()
        feedParser.parseFeed(url: "http://athletics.bates.edu/composite?print=rss") {
            (sports) in
            self.sports = sports
            //because we don't know how many items will be eligible for collapse
            self.sportscellStates = Array(repeating: .collapsed, count: sports.count)
            OperationQueue.main.addOperation {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .left)
            }
            
        }
    }
    
    // MARK: - Table view data source
    
    /// 11 - implement table view datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard let sports = sports else {
            
            return 0
        }
        //news.count
        return sports.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SportsTableViewCell
        if let item = sports?[indexPath.item] {
            cell.item = item
            cell.selectionStyle = .none
            //if we get the cell states,
            if let sportscellStates = sportscellStates {
                cell.descriptionLabel.numberOfLines = (sportscellStates[indexPath.row] == .expanded) ? 0 : 5
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //hey table view, deselect the row
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! SportsTableViewCell
        tableView.beginUpdates()
        cell.descriptionLabel.numberOfLines = (cell.descriptionLabel.numberOfLines == 0) ? 5 : 0 //to see full description. If it were 1, it'd only show 1 line of the full description
        
        //now before we finish the update, we
        sportscellStates?[indexPath.row] = (cell.descriptionLabel.numberOfLines == 0) ? .expanded : .collapsed
        tableView.endUpdates()
    }
    
}
