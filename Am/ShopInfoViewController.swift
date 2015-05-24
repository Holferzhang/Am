//
//  ShopInfoViewController.swift
//  Bussiness
//
//  Created by daiqile on 15/3/27.
//  Copyright (c) 2015年 LB. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class ShopInfoViewController: UIViewController{
    
    
    @IBOutlet weak var commenttxt: UITextField!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tel: UILabel!
    @IBOutlet weak var ImgView: UIImageView!
    
    var shopid: String = String()
    var url=BaseInfo()
    var uid="0"
    let ud=NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBarHidden=false

        if let id = ud.objectForKey("id") as! String? {
                uid=id
        }
        
        //ID获取
        let params = ["action":self.shopid]
        
        
        Alamofire.request(.GET, url.GetUrl("getshop.php"),parameters: params).responseJSON() {
            (request, response, data, error) in
            let json = JSON(data!)
            
            if let nameval = json[0]["name"].string{
                self.name.text=nameval
            }
        
            if let telval = json[0]["tel"].string{
                self.tel.text=telval
            }

      
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func StoreUpDo(sender: AnyObject) {
        
        
        if (uid=="0") {
        
            var alert = UIAlertView()
            alert.title = "message?"
            alert.message = "please login."
            alert.addButtonWithTitle("OK")
            alert.show()

        
        }else{
            
        
        let params = ["action":"add","userid":uid,"shopid":self.shopid]

        Alamofire.request(.POST, url.GetUrl("getstoreup.php"),parameters: params).responseJSON() {
            (request, response, data, error) in
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
                    alert.message = "Already exist."
                    alert.addButtonWithTitle("OK")
                    alert.show()
                    
                }
                
            }
            
            }
    }
        
}
    
   
    @IBAction func SendMsg(sender: AnyObject) {
        var commentval=commenttxt.text
        if(commentval==""){
        
            var alert = UIAlertView()
            alert.title = "message?"
            alert.message = "comment is empty."
            alert.addButtonWithTitle("OK")
            alert.show()
        
        
        }else{
        
            if (uid=="0") {
                
                var alert = UIAlertView()
                alert.title = "message?"
                alert.message = "please login."
                alert.addButtonWithTitle("OK")
                alert.show()
                
                
            }else{
            
           
                let params = ["action":"add","userid":uid,"shopid":self.shopid,"comment":commentval]
                
                Alamofire.request(.POST, url.GetUrl("getcomment.php"),parameters: params).responseJSON() {
                    (request, response, data, error) in
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
            

        }
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "shopid"{
            var obj = segue.destinationViewController as! ShopCommentController
            obj.shopid = self.shopid
        }
        
        if segue.identifier == "shopmapid"{
            var obj = segue.destinationViewController as! ShopLocalViewController
            obj.shopid = self.shopid
        }
    }
}