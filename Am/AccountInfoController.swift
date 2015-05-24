//
//  AccontInfoController.swift
//  Bussiness
//
//  Created by daiqile on 15/4/20.
//  Copyright (c) 2015年 LB. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit
import Alamofire

class AccountInfoController: UIViewController{
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var nikename: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    var url=BaseInfo()
    
    let ud=NSUserDefaults.standardUserDefaults()

    var uid="0"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //获取账户信息

        
        if let id = ud.objectForKey("id") as! String? {
            
            uid=id
        }
            
        let params = ["userid":uid]
            
         Alamofire.request(.GET, url.GetUrl("getuserinfo.php"),parameters: params).responseJSON() {
                (_, _, data, _) in
            
             let json = JSON(data!)
        
            
            if let userName = json[0]["name"].string{
                self.username.text=userName
            }

            if let Phone = json[0]["tel"].string{
                self.phone.text=Phone
            }

            if let nikename = json[0]["nikename"].string{
                self.nikename.text=nikename
            }
            
            if let email = json[0]["mail"].string{
                self.email.text=email
            }
            
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}