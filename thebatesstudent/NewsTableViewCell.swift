//
//  NewsTableViewCell.swift
// Imad Rajwani
//

import UIKit

enum CellState {
    case expanded
    case collapsed
    
}

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel:UILabel! {
    //whenever description label gets set, do this,
    didSet {
        descriptionLabel.numberOfLines = 5
    }
    }
    @IBOutlet weak var dateLabel:UILabel!
    
    var item: News! {
        didSet {
            titleLabel.text = item.title
            dateLabel.text = item.pubDate
            authorLabel.text = item.author
            descriptionLabel.text = item.description
        }
        
    }
}
