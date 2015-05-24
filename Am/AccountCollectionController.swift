//
//  AccountCollectionController.swift
//  Bussiness
//
//  Created by daiqile on 15/5/13.
//  Copyright (c) 2015年 LB. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire


class AccountCollectionController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var collectionlist: UITableView!

    var url=BaseInfo()

    var json: JSON = JSON.nullJSON

    let ud=NSUserDefaults.standardUserDefaults()
    var uid="0"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
         if let id = ud.objectForKey("id") as! String? {
            uid=id;
            
         }
            if uid.toInt()>0{
                
                let params = ["action":"getinfo","userid":uid]
                
                
                Alamofire.request(.GET, url.GetUrl("getstoreup.php"),parameters: params).responseJSON() {
                    (_, _, data, _) in
                    
                    self.json = JSON(data!)
                    self.collectionlist.reloadData()
                
               }
            
        }

        collectionlist.delegate = self
        collectionlist.dataSource = self
        
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("itemcell", forIndexPath: indexPath) as!UITableViewCell
        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        
        var object: AnyObject
        //switch UIDevice.currentDevice().systemVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch) {
        //case .OrderedSame, .OrderedDescending:
        //    object = segue.destinationViewController.topViewController
       // case .OrderedAscending:
            object = segue.destinationViewController
       // }
        
        if let nextController = object as? ShopInfoViewController {
            
            if let indexPath = self.collectionlist.indexPathForSelectedRow() {
                var row = indexPath.row
                var txval:String="0";
                
                switch self.json.type {
                case .Array:
                    txval = self.json[row]["id"].string!
                    
                case .Dictionary where row < self.json.dictionaryValue.count:
                    let key = self.json.dictionaryValue.keys.array[row]
                    if let value = self.json.dictionary?[key] {
                        
                        txval = value[row]["id"].string!
                    }
                default:
                    print("")
                }
                
                if segue.identifier == "shopid"{
                
                nextController.shopid=txval
              
                }
            }
        }
      
    }

    
}

