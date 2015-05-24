//
//  AccountLoginViewController.swift
//  Bussiness
//
//  Created by daiqile on 15/4/28.
//  Copyright (c) 2015年 LB. All rights reserved.
//

import Foundation

import UIKit
import SwiftyJSON
import Alamofire

class AccountLoginViewController: UIViewController{
    

    @IBOutlet weak var usernmae: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var url=BaseInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.navigationController?.navigationBarHidden=true

    }
    
  
    
    @IBAction func LoginClick(sender: AnyObject) {
        var usernameval=usernmae.text
        var passwordval=password.text
        
        
        let params = ["action":"login","name":usernameval,"password":passwordval]
        
        
        Alamofire.request(.GET, url.GetUrl("user.php"),parameters: params).responseJSON() {
            (request, response,  data, error) in

            let json = JSON(data!)
            

            if let status = json["status"].string{
                if(status=="-1"){
      
                    var alert = UIAlertView()
                    alert.title = "message?"
                    alert.message = "Wrong UserName."
                    alert.addButtonWithTitle("OK")
                    alert.show()

                    
                }else if(status=="-2"){
                
                    var alert = UIAlertView()
                    alert.title = "message?"
                    alert.message = "Wrong PassWord."
                    alert.addButtonWithTitle("OK")
                    alert.show()

                
                }else if(status=="0"){
                    
                    let ud = NSUserDefaults.standardUserDefaults();
                    
                    if let id = json["0"]["id"].string{

                        ud.setObject(id, forKey: "id");
                    }
                    
                    if let tel = json["0"]["tel"].string{
                        //  2、存储数据
                        ud.setObject(tel, forKey: "tel");
                    }
                    
      
        var shoplistsb1=UIStoryboard(name: "Main", bundle: nil)
        var vc=shoplistsb1.instantiateViewControllerWithIdentifier("AccountViewController") as! AccountViewController
        self.navigationController?.popToRootViewControllerAnimated(true)
                 
                    //  3、同步数据
                    ud.synchronize();
                
                }
            }

        }
        
        

        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

