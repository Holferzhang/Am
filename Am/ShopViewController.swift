//
//  ShopViewController.swift
//  Bussiness
//
//  Created by daiqile on 15/3/26.
//  Copyright (c) 2015年 LB. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
class ShopViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate{
     
    @IBOutlet weak var shoplist: UITableView!
    var searchBarControl: UISearchBar?
    var json: JSON = JSON.nullJSON
    var url=BaseInfo()
    var classid: String = String()
    var shopid: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchBarControl = UISearchBar(frame: CGRectMake(0.0, 0.0, 280 , 45))
        searchBarControl?.delegate = self;
        searchBarControl?.barStyle = .Default
        searchBarControl?.placeholder = "search"
        searchBarControl?.showsBookmarkButton = true
        searchBarControl?.showsBookmarkButton = true
  
        let rightBar = UIBarButtonItem(customView: searchBarControl!)
        self.navigationItem.rightBarButtonItem = rightBar;
        let params = ["classid": self.classid]
        
        Alamofire.request(.GET, url.GetUrl("getshop.php"),parameters: params).responseJSON() {
            (_, _, data, _) in
            
            self.json = JSON(data!)
            self.shoplist.reloadData()
        }
        
        shoplist.delegate = self
        shoplist.dataSource = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 点击  取消  按钮
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        //println("点击取消按钮")
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        
        let params = ["classid": self.classid]
        
        Alamofire.request(.GET, url.GetUrl("getshop.php"),parameters: params).responseJSON() {
            (_, _, data, _) in
            
            self.json = JSON(data!)
            self.shoplist.reloadData()
            
        }
        
        
    }
    

    // 点击  搜索  按钮
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        // println("开始搜索")
        var searchTerm=searchBar.text
        
        let params = ["name":searchTerm,"classid": self.classid]
       // println(params)
        
        Alamofire.request(.GET, url.GetUrl("getshop.php"),parameters: params).responseJSON() {
            (_, _, data, _) in
            println(data)
            
            self.json = JSON(data!)
            self.shoplist.reloadData()
            
        }
        
        
        searchBar.resignFirstResponder()

        
        
    }
    
    // 即将输入textfield
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        // println("开始录入")
        
        searchBar.showsCancelButton = true
        searchBar.showsScopeBar = true
        return true
    }
    
    func searchBarBookmarkButtonClicked(searchBar: UISearchBar) {
        // println("点击搜索记录按钮，显示搜索历史.如果是iphone，可弹出新页面显示搜索记录。如iPad可使用popover")

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
        let cell = tableView.dequeueReusableCellWithIdentifier("shopitem", forIndexPath: indexPath) as! UITableViewCell
        
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
        //}
        
        
        
        if segue.identifier == "shopid"{
            
            if let nextController = object as? ShopInfoViewController {
                
                if let indexPath = self.shoplist.indexPathForSelectedRow() {
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
                    
                    
                    
                    nextController.shopid=txval
                    
                }
            }
        }
        
        
        
        
  
    }
    
    
}