//
//  ViewController.swift
//  Bussiness
//
//  Created by daiqile on 15/3/20.
//  Copyright (c) 2015年 LB. All rights reserved.
//
import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController,UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    //搜索框
    
    @IBOutlet weak var tab: UITableView!
    
    var searchBarControl: UISearchBar?
    
    var url=BaseInfo()
    
    var classid: String = String()
    
    var shopid: String = String()
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    
    
    var json: JSON = JSON.nullJSON
    override func viewDidLoad() {
        super.viewDidLoad()
        //检查网络连接，首先如果没有连接就立即提示并退出
        if IJReachability.isConnectedToNetwork() {
            searchBarControl = UISearchBar(frame: CGRectMake(0.0, 0.0, 280 , 45))
            searchBarControl?.delegate = self;
            searchBarControl?.barStyle = .Default
            searchBarControl?.placeholder = "search"
            searchBarControl?.showsBookmarkButton = true
            searchBarControl?.showsBookmarkButton = true
            
            let rightBar = UIBarButtonItem(customView: searchBarControl!)
            self.navigationItem.rightBarButtonItem = rightBar;
            
            Alamofire.request(.GET, url.GetUrl("getshop.php")).responseJSON() {
                (_, _, data, _) in
                
                self.json = JSON(data!)
                self.tab.reloadData()
            }
            tab.delegate = self
            tab.dataSource = self
        }else{
            var alert = UIAlertView()
            alert.title = "message?"
            alert.delegate = self
            alert.message = "Sorry, no network.please check"
            alert.addButtonWithTitle("OK")
            alert.show()

        }
        
        
        

    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int){
      //  println("buttonIndex:\(buttonIndex)")
        //关闭整个app,没网络的情况下
        exit(0)
    }
    
    
    //tableview开始
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.Info.count
        
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
        let cell = tableView.dequeueReusableCellWithIdentifier("itemcell", forIndexPath: indexPath) as! UITableViewCell
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
    
    
    
    // 点击  取消  按钮
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        //println("点击取消按钮")
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()

        Alamofire.request(.GET, url.GetUrl("getshop.php")).responseJSON() {
            (_, _, data, _) in
            
            self.json = JSON(data!)
            self.tab.reloadData()
            
        }
        
        
    }
    
    // 点击  搜索  按钮
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        // println("开始搜索")
        var searchTerm=searchBar.text
        
        let params = ["name":searchTerm]
        
        
        Alamofire.request(.GET, url.GetUrl("getshop.php"),parameters: params).responseJSON() {
            (_, _, data, _) in
            
            self.json = JSON(data!)
            self.tab.reloadData()
            
        }
        
        
        searchBar.resignFirstResponder()
        
    }
    
    // 即将输入textfield
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        searchBar.showsScopeBar = true
        return true
    }
    
    func searchBarBookmarkButtonClicked(searchBar: UISearchBar) {
        // println("点击搜索记录按钮，显示搜索历史.如果是iphone，可弹出新页面显示搜索记录。如iPad可使用popover")
        /*
        let time = TimeViewController()
        self.presentViewController(time, animated: true, completion: nil)
        */
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    @IBAction func gotab1(sender: AnyObject) {
        
        self.classid = "1"
        self.performSegueWithIdentifier("myclassid", sender: self)
    }
    
    
    
    @IBAction func gotab2(sender: AnyObject) {
        self.classid = "2"
        self.performSegueWithIdentifier("myclassid", sender: self)
    }
    
    
    @IBAction func gotab3(sender: AnyObject) {
        self.classid = "3"
        self.performSegueWithIdentifier("myclassid", sender: self)
    }
    
    
    @IBAction func gotab4(sender: AnyObject) {
        self.classid = "4"
        self.performSegueWithIdentifier("myclassid", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var object: AnyObject
        //switch UIDevice.currentDevice().systemVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch) {
        //case .OrderedSame, .OrderedDescending:
        //    object = segue.destinationViewController.topViewController
       // case .OrderedAscending:
            object = segue.destinationViewController
        //}
        
        
        
        if segue.identifier == "mshopid"{
        
        if let nextController = object as? ShopInfoViewController {
            
            if let indexPath = self.tab.indexPathForSelectedRow() {
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
        
        
        
        
        if segue.identifier == "myclassid"{
         //   var obj = segue.destinationViewController as! ShopViewController
            
            if let nextController = object as? ShopViewController {
            
            nextController.classid = self.classid
            
            
            }
        }
        
        
  
        
    }
    
}

