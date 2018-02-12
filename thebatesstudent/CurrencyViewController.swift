//  I must accredit that the app icon was uniquely created by me with simple MS Paint
//  CurrencyViewController.swift
//  thebs
//
//  Created by Imad Rajwani on 1/10/18.
//  Copyright © 2018 Imad Rajwani. All rights reserved.
//

import UIKit

struct Currency: Decodable {
    let base: String
    let date: String
    let rates: [String:Double]
}

class CurrencyViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var rateField: UITextField!
    @IBOutlet weak var conTableView: UITableView!
    
    var usd: Currency? //make this variable's type the structure you just created
    var baserate = 1.0 //just to make sure all values stay as Double (will be used in currency conversion formula)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        conTableView.dataSource = self
        
        //extra features for aesthetics:
        conTableView.allowsSelection = false //remove gray highlight when you press a currency
        conTableView.showsVerticalScrollIndicator = false
        rateField.textAlignment = .center //center user input in Text Field
        //
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if let because API is not guaranteed to work
        if let currencyfetched = usd {
            return currencyfetched.rates.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        if let currencyfetched = usd {
            cell.textLabel?.text = Array(currencyfetched.rates.keys)[indexPath.row]
            let selectedrate = baserate * Array(currencyfetched.rates.values)[indexPath.row]
            cell.detailTextLabel?.text = "\(selectedrate)"
            return cell
        }
        return UITableViewCell()
    }
    
    
    //converts to proper rates for currencies in table view based on user input
    @IBAction func convertPressed(_ sender: UIButton) {
        
        if let getstring = rateField.text {
            if let isdouble = Double(getstring) {
                baserate = isdouble
                fetchData()
            }
        }
    }
    
    
    func fetchData() {
        let url = URL(string: "https://api.fixer.io/latest?base=USD")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in if error == nil {
            //                implement a do-catch block because JSON decoder always throws. We use 'try' just because
            do {
                self.usd = try JSONDecoder().decode(Currency.self, from: data!)
                
            } catch {
                print("Parse Error")
                
            }
            DispatchQueue.main.async {
                self.conTableView.reloadData()
            }
        } else {
            
            print("Error")
            
            }
            
            }.resume()
    }
    

}


//import UIKit
//
//struct Paper : Decodable {
//    let title: [String:String]
//    //let excerpt: String
//}
//
//class PaperViewController: UIViewController, UITableViewDataSource {
//
//    @IBOutlet weak var newsTableView: UITableView!
//
//
//    var paper: Paper?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        getPaper()
//        newsTableView.dataSource = self
//
//        //authorLabel.text = paper?.author
//
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return paper!.title.count
//         //chooses apropriate number of table view cells
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//        if let paperfetched = paper {
//            cell.textLabel?.text = Array(paperfetched.title.values)[indexPath.row]
//            //cell.detailTextLabel?.text = "\(selectedrate)"
//            return cell
//        }
//        return UITableViewCell()
//    }
//
//    func getPaper() {
//        let url = URL(string: "thebatesstudent.com/wp-json/wp/v2/posts?context=view")
//        URLSession.shared.dataTask(with: url!) { (data, response, error) in if error == nil {
//            //                implement a do-catch block because JSON decoder always throws. We use 'try' just because
//            do {
//                self.paper = try JSONDecoder().decode(Paper.self, from: data!)
//
//            } catch {
//                print("Parse Error")
//
//            }
//            DispatchQueue.main.async {
//                self.newsTableView.reloadData() //dot something in API
//            }
//        } else {
//
//            print("Error")
//
//            }
//
//            }.resume()
//    }
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}

