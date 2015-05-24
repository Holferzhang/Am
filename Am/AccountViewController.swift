//
//  AccountViewController.swift
//  Bussiness
//
//  Created by daiqile on 15/3/25.
//  Copyright (c) 2015年 LB. All rights reserved.
//

import Foundation

import UIKit

class AccountViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet weak var LoginBtn: UIButton!
    @IBOutlet weak var accountlist: UITableView!
    @IBOutlet weak var signoutBtn: UIButton!
    @IBOutlet weak var HeadImgBtn: UIButton!
    
    var loginstatus: String = String()

    let ud=NSUserDefaults.standardUserDefaults()

    var uid="0";
    
    let ListArray:NSArray=["Collection"]
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.navigationController?.navigationBarHidden=true
        self.navigationController?.navigationBar.translucent = false;
        // Do any additional setup after loading the view, typically from a nib.
       
        if let id = ud.objectForKey("id") as! String? {
            uid=id
        }
            if uid.toInt()>0{
                LoginBtn.hidden=true
                signoutBtn.hidden=false
                HeadImgBtn.hidden=false
            }else{
                signoutBtn.hidden=true
                HeadImgBtn.hidden=true
                
            }
            
     
        //*/
        accountlist.delegate = self
        accountlist.dataSource = self

        
    }
    
    //实现登陆后状态更行
    override func viewWillAppear(animated: Bool) {        

            
            if uid.toInt()>0{
                LoginBtn.hidden=true
                signoutBtn.hidden=false
                HeadImgBtn.hidden=false
            }else{
                signoutBtn.hidden=true
                HeadImgBtn.hidden=true
                
            }
            
        accountlist.delegate = self
        accountlist.dataSource = self
        
    }
    
    
    @IBAction func LoginOutClick(sender: AnyObject) {
        
        let ud=NSUserDefaults.standardUserDefaults()
        ud.removeObjectForKey("id")
        ud.removeObjectForKey("tel")
        
        //  3、同步数据
        ud.synchronize();
        
        var shoplistsb1=UIStoryboard(name: "Main", bundle: nil)
        var vc=shoplistsb1.instantiateViewControllerWithIdentifier("AccountLoginViewController") as! AccountLoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
      
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListArray.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("shopitem", forIndexPath: indexPath) as! UITableViewCell
        // cell.textLabel.text = indexPath.row.description
        cell.textLabel?.text="\(ListArray.objectAtIndex(indexPath.row))"
        return cell
    }
    

    
    
    
}
