//
//  SportsTableViewCell.swift
//  thebatesstudent
//
//  Created by Imad Rajwani on 1/18/18.
//  Copyright © 2018 Imad Rajwani. All rights reserved.
//

import UIKit


enum SportsCellState {
    case expanded
    case collapsed
    
}

class SportsTableViewCell: UITableViewCell {

        
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel:UILabel! {
        //whenever description label gets set, do this,
        didSet {
            descriptionLabel.numberOfLines = 5
        }
    }
    
    var item: Sports! {
        didSet {
            titleLabel.text = item.title
            categoryLabel.text = item.category
            descriptionLabel.text = item.description
        }
        
    }

}
