//
//  SecondViewController.swift
//  thebs
//
//  Created by Imad Rajwani on 1/1/18.
//  Copyright © 2018 Imad Rajwani. All rights reserved.
//

import UIKit
import WebKit

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "https://www.facebook.com/thebatesstudent/")
        let request = URLRequest(url: url!)
        
        webView.load(request)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }


}

