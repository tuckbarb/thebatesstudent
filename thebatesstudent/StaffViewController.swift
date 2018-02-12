//
//  StaffViewController.swift
//  thebs
//
//  Created by Imad Rajwani on 1/14/18.
//  Copyright © 2018 Imad Rajwani. All rights reserved.
//

import UIKit

class StaffViewController: UIViewController {

    var copy_editor = UILabel()
    var gen_man = UILabel()
    var biz_ad = UILabel()
    var web_mstr = UILabel()
    var dist = UILabel()
    
    var forum = UILabel()
    var n = UILabel()
    var arts = UILabel()
    var sports = UILabel()
    var ph = UILabel()
    var l = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        copy_editor.frame = CGRect(x: 22, y: 120, width: 120, height: 27)
        copy_editor.text = "Jacob LeMoine\nSophie Mortman"
        copy_editor.numberOfLines = 2
        copy_editor.textAlignment = .center
        copy_editor.textColor = UIColor.black
        copy_editor.font = UIFont(name: "Georgia", size: 10)
        
        self.view.addSubview(copy_editor)
    
        gen_man.frame = CGRect(x: 22, y: 163, width: 120, height: 27)
        gen_man.text = "Jeanne Hua"
        gen_man.numberOfLines = 1
        gen_man.textAlignment = .center
        gen_man.textColor = UIColor.black
        gen_man.font = UIFont(name: "Georgia", size: 10)
        
        self.view.addSubview(gen_man)
        
        biz_ad.frame = CGRect(x: 22, y: 203, width: 120, height: 27)
        biz_ad.text = "Hyewon Shin"
        biz_ad.numberOfLines = 1
        biz_ad.textAlignment = .center
        biz_ad.textColor = UIColor.black
        biz_ad.font = UIFont(name: "Georgia", size: 10)
        
        self.view.addSubview(biz_ad)
        
        web_mstr.frame = CGRect(x: 14, y: 243, width: 150, height: 27)
        web_mstr.text = "Imad Rajwani"
        web_mstr.numberOfLines = 1
        web_mstr.textAlignment = .center
        web_mstr.textColor = UIColor.black
        web_mstr.font = UIFont(name: "Georgia", size: 10)
        
        self.view.addSubview(web_mstr)
        
        dist.frame = CGRect(x: 14, y: 283, width: 150, height: 27)
        dist.text = "Kwamae Delva"
        dist.numberOfLines = 1
        dist.textAlignment = .center
        dist.textColor = UIColor.black
        dist.font = UIFont(name: "Georgia", size: 10)
        
        self.view.addSubview(dist)
        
        forum.frame = CGRect(x: 180, y: 110, width: 140, height: 67)
        forum.text = "Managing Editor:\nAyesha Sharma\nAssistant Editor:\nSarah McCarthy"
        forum.numberOfLines = 4
        forum.textAlignment = .center
        forum.textColor = UIColor.black
        forum.font = UIFont(name: "Georgia", size: 10)
        
        self.view.addSubview(forum)
        
        n.frame = CGRect(x: 180, y: 180, width: 140, height: 77)
        n.text = "Managing Editor:\nChristina Perrone\nAssistant Editor:\nMatt Morris"
        n.numberOfLines = 4
        n.textAlignment = .center
        n.textColor = UIColor.black
        n.font = UIFont(name: "Georgia", size: 10)
        
        self.view.addSubview(n)
        
        arts.frame = CGRect(x: 180, y: 265, width: 140, height: 57)
        arts.text = "Managing Editor:\nTory Dobbin\nAssistant Editor:\n Ariel Abonizio"
        arts.numberOfLines = 4
        arts.textAlignment = .center
        arts.textColor = UIColor.black
        arts.font = UIFont(name: "Georgia", size: 10)
        
        self.view.addSubview(arts)
        
        sports.frame = CGRect(x: 180, y: 335, width: 140, height: 57)
        sports.text = "Managing Editor:\nSarah Rothmann\nAssistant Editor:\nMax Petrie"
        sports.numberOfLines = 4
        sports.textAlignment = .center
        sports.textColor = UIColor.black
        sports.font = UIFont(name: "Georgia", size: 10)
        
        self.view.addSubview(sports)
        
        ph.frame = CGRect(x: 180, y: 400, width: 140, height: 90)
        ph.text = "News:\nJames MacDonald\nArts and Leisure:\nJames MacDonald\nSports:\nMaddy Smith"
        ph.numberOfLines = 6
        ph.textAlignment = .center
        ph.textColor = UIColor.black
        ph.font = UIFont(name: "Georgia", size: 10)
        
        self.view.addSubview(ph)
        
        l.frame = CGRect(x: 16, y: 327, width: 140, height: 40)
        l.text = "Kate Bouchard\nJustice Geddes"
        l.numberOfLines = 2
        l.textAlignment = .center
        l.textColor = UIColor.black
        l.font = UIFont(name: "Georgia", size: 10)
        
        self.view.addSubview(l)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
