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


class AccountPassEditController: UIViewController{
    
    @IBOutlet weak var oldpassword: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var repassword: UITextField!
    
    
    let ud=NSUserDefaults.standardUserDefaults()
    var uid="0";
    
    var url=BaseInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
 
        
        if let id = ud.objectForKey("id") as! String? {
            
            uid=id
        }
    }
    

    @IBAction func SubDo(sender: AnyObject) {
        
        var oldpasswordval=oldpassword.text
        var passwordval=password.text
        var repasswordval=repassword.text
        let params = ["action":"editpass","password":passwordval,"repassword":repasswordval,"oldpass":oldpasswordval,"userid":uid]

        Alamofire.request(.POST, url.GetUrl("getuserinfo.php"),parameters: params).responseJSON() {
            (_, _, data, _) in

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
                    
                }else if(status=="-2"){
                    
                    
                    var alert = UIAlertView()
                    alert.title = "message?"
                    alert.message = "repassword error."
                    alert.addButtonWithTitle("OK")
                    alert.show()
                    
                }else if(status=="-3"){
                    
                    
                    var alert = UIAlertView()
                    alert.title = "message?"
                    alert.message = "Old password ERROR."
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