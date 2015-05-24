//
//  AccountRegisterViewController.swift
//  Bussiness
//
//  Created by daiqile on 15/3/27.
//  Copyright (c) 2015年 LB. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class AccountRegisterViewController: UIViewController{
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var repassword: UITextField!

    @IBOutlet weak var phone: UITextField!

    var url=BaseInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    
    @IBAction func RegClick(sender: AnyObject) {
        
        var usernameval=username.text
        var passwordval=password.text
        var repasswordval=repassword.text
        var telval=phone.text
        
        let params = ["action":"reg","name":usernameval,"password":passwordval,"repassword":repasswordval,"tel":telval]
        Alamofire.request(.POST, url.GetUrl("user.php"),parameters: params).responseJSON() {
            (_, _, data, _) in
            let json = JSON(data!)
            
            if let status = json["status"].string{

            
                if(status=="-3"){
                    
                    var alert = UIAlertView()
                    alert.title = "message?"
                    alert.message = "Repassword wrong."
                    alert.addButtonWithTitle("OK")
                    alert.show()
                    
                    
                }else if(status=="-1"){
                
                
                    var alert = UIAlertView()
                    alert.title = "message?"
                    alert.message = "UserName or Password Empty."
                    alert.addButtonWithTitle("OK")
                    alert.show()
                
                }else if(status=="-2"){
                    
                    
                    var alert = UIAlertView()
                    alert.title = "message?"
                    alert.message = "The user name already exists."
                    alert.addButtonWithTitle("OK")
                    alert.show()
                    
                }else if(status=="-4"){
                    
                    
                    var alert = UIAlertView()
                    alert.title = "message?"
                    alert.message = "Unknown to registration failure."
                    alert.addButtonWithTitle("OK")
                    alert.show()
                    
                }else{
                
                    var alert = UIAlertView()
                    alert.title = "message?"
                    alert.message = "ok."
                    alert.addButtonWithTitle("OK")
                    alert.show()

                    
                    //注册成功
                    
                
                }

            
            }

        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}