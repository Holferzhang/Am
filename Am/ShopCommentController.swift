//
//  ShopLocalViewController.swift
//  Bussiness
//
//  Created by daiqile on 15/3/27.
//  Copyright (c) 2015年 LB. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class ShopCommentController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var shopid: String = String()
    var url=BaseInfo()
    
    var json: JSON = JSON.nullJSON
    @IBOutlet weak var commentlist: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //ID获取
        let params = ["action":"getinfo","shopid":self.shopid]

       
        Alamofire.request(.GET, url.GetUrl("getcomment.php"),parameters: params).responseJSON() {
            (request, response, data, error) in
            
            self.json = JSON(data!)

            self.commentlist.reloadData()
        }
        commentlist.delegate = self
        commentlist.dataSource = self

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.json.type {
        case Type.Array, Type.Dictionary:
            return self.json.count
        default:
            return 1
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentlist", forIndexPath: indexPath) as! UITableViewCell
        
        var row = indexPath.row
        
        switch self.json.type {
        case .Array:
            cell.textLabel?.text = self.json[row]["name"].string
            cell.detailTextLabel?.text = self.json.arrayValue.description
        case .Dictionary:
            let key: AnyObject = (self.json.object as! NSDictionary).allKeys[row]
            let value = self.json[key as! String]
            cell.textLabel?.text = value[row]["name"].string
            cell.detailTextLabel?.text = value.description
        default:
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = self.json.description
        }
    
        
        return cell
    }
   

    
    

    
    
}