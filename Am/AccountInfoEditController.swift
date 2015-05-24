//
//  AccountInfoEditController.swift
//  Bussiness
//
//  Created by daiqile on 15/4/20.
//  Copyright (c) 2015年 LB. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit
import Alamofire


class AccontInfoEditController: UIViewController{
    
    
    @IBOutlet weak var usernameLab: UILabel!
    @IBOutlet weak var phonetxt: UITextField!
    @IBOutlet weak var nikenametxt: UITextField!
    @IBOutlet weak var emailtxt: UITextField!
    var url=BaseInfo()
    
    let ud=NSUserDefaults.standardUserDefaults()
    var uid="0";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //获取账户信息
        
        if let id = ud.objectForKey("id") as! String? {
            uid=id;
            
        }
        
       
        
        let params = ["userid":uid]
        
        Alamofire.request(.GET, url.GetUrl("getuserinfo.php"),parameters: params).responseJSON() {
            (_, _, data, _) in
            
            let json = JSON(data!)
            
            
            
            if let username = json[0]["name"].string{
                self.usernameLab.text=username
            }
            
            if let Phone = json[0]["tel"].string{
                self.phonetxt.text=Phone
            }
            
            if let nikename = json[0]["nikename"].string{
                  self.nikenametxt.text=nikename
            }
            
            if let email = json[0]["mail"].string{
                self.emailtxt.text=email
            }
            
        }
        
        
    }
    
    
    @IBAction func SubDo(sender: AnyObject) {
        var phoneval=phonetxt.text
        var nikenameval=nikenametxt.text
        var emailval=emailtxt.text
        
        
        let params = ["action":"edit","tel":phoneval,"nikename":nikenameval,"email":emailval,"userid":uid]
        Alamofire.request(.POST, url.GetUrl("getuserinfo.php"),parameters: params).responseJSON() {
            (_, _, data, _) in
            
            //  println(data)
            let json = JSON(data!)
            
            if let status = json["status"].string{
                
                
                if(status=="0"){
                    
                    var alert = UIAlertView()
                    alert.title = "message?"
                    alert.message = "SUCCESS."
                    alert.addButtonWithTitle("OK")
                    alert.show()

                    
                }else if(status=="-1"){
                    
                    
                    var alert = UIAlertView()
                    alert.title = "message?"
                    alert.message = "ERROR."
                    alert.addButtonWithTitle("OK")
                    alert.show()
                    
                }
                
            }
            
        }
           
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}