//
//  MoreViewController.swift
//  Bussiness
//
//  Created by daiqile on 15/3/26.
//  Copyright (c) 2015年 LB. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
class MoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var morelist: UITableView!

    var url=BaseInfo()
    var json: JSON = JSON.nullJSON
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request(.GET, url.GetUrl("getinfo.php")).responseJSON() {
            (_, _, data, _) in
            
            self.json = JSON(data!)
            self.morelist.reloadData()
        }
        morelist.delegate = self
        morelist.dataSource = self
      
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
        let cell = tableView.dequeueReusableCellWithIdentifier("moreitem", forIndexPath: indexPath) as! UITableViewCell
        
        var row = indexPath.row
        
        switch self.json.type {
        case .Array:
            cell.textLabel?.text = self.json[row]["title"].string
            cell.detailTextLabel?.text = self.json.arrayValue.description
        case .Dictionary:
            let key: AnyObject = (self.json.object as! NSDictionary).allKeys[row]
            let value = self.json[key as! String]
            cell.textLabel?.text = value[row]["title"].string
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
        //}

        if segue.identifier == "moreid"{
            
            if let nextController = object as? MoreInfoViewController {
                
                if let indexPath = self.morelist.indexPathForSelectedRow() {
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

                    nextController.moreid=txval
                    
                }
            }
        }
        
    }
    
    
    


}