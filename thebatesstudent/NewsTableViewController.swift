//
//  NewsTableViewController.swift
//  Imad Rajwani
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    private var news: [News]?
    private var cellStates: [CellState]?
  
    override func viewDidLoad() {
        super.viewDidLoad()
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.blue], for: .selected)
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.orange], for: .normal)
        tableView.estimatedRowHeight = 155.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        fetchNews()
        
    }
    
    private func fetchNews()
    {
        let feedParser = FeedParser()
        feedParser.parseFeed(url: "https://feeds.feedburner.com/TheBatesStudent") {
            (news) in
            self.news = news
            //because we don't know how many items will be eligible for collapse
            self.cellStates = Array(repeating: .collapsed, count: news.count)
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
        guard let news = news else {
            
            return 0
        }
        //news.count
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell //cast cell as NewsTableViewCell
        if let item = news?[indexPath.item] {
            cell.item = item
            cell.selectionStyle = .none
            //if we get the cell states,
            if let cellStates = cellStates {
                cell.descriptionLabel.numberOfLines = (cellStates[indexPath.row] == .expanded) ? 0 : 5
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //hey table view, deselect the row
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! NewsTableViewCell
        tableView.beginUpdates()
        cell.descriptionLabel.numberOfLines = (cell.descriptionLabel.numberOfLines == 0) ? 5 : 0 //to see full description. If it were 1, it'd only show 1 line of the full description
        
        //now before we finish the update, we
        cellStates?[indexPath.row] = (cell.descriptionLabel.numberOfLines == 0) ? .expanded : .collapsed
        tableView.endUpdates()
    }
    
    
}
