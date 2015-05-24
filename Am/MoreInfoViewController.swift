//
//  MoreInfoViewController.swift
//  Bussiness
//
//  Created by daiqile on 15/3/27.
//  Copyright (c) 2015年 LB. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class MoreInfoViewController: UIViewController{
 
    var moreid: String = String()
    var url=BaseInfo()
    var json: JSON = JSON.nullJSON
    
    @IBOutlet weak var contentText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let params = ["action": self.moreid]
        
        Alamofire.request(.GET, url.GetUrl("getinfo.php"),parameters: params).responseJSON() {
            (_, _, data, _) in
            
                self.json = JSON(data!)
                self.navigationController?.navigationItem.title = self.json[0]["title"].string
                self.contentText.text=self.json[0]["content"].string
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
        
}