//
//  ShopLocalViewController.swift
//  Bussiness
//
//  Created by daiqile on 15/3/27.
//  Copyright (c) 2015年 LB. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit
import SwiftyJSON
import Alamofire

class ShopLocalViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate{
    let locationManger:CLLocationManager=CLLocationManager();

    @IBOutlet var mapView: MKMapView!
    
    var url=BaseInfo()
    //获取到店铺的id
    var shopid: String = String()
    var longitudes:String=String()
    var latitudes:String=String()
    override func viewDidLoad() {
        super.viewDidLoad()
     
        locationManger.delegate=self
        //精度
        locationManger.desiredAccuracy=kCLLocationAccuracyBest
        //重新过滤距离
        locationManger.distanceFilter=10.0
        if(ios8()){
            //授权
            locationManger.requestAlwaysAuthorization()
            locationManger.requestWhenInUseAuthorization()
        }
  
            mapView.delegate=self
            //跟踪并定位出用户位置
            self.mapView.setUserTrackingMode(MKUserTrackingMode.FollowWithHeading, animated: true)
            mapView.mapType=MKMapType.Standard
 
        
        
        //ID获取
        let params = ["action":self.shopid]
        Alamofire.request(.GET, url.GetUrl("getshop.php"),parameters: params).responseJSON() {
            (request, response, data, error) in
            let json = JSON(data!)
            
            if let longitudev = json[0]["local_longitude"].string{
                self.longitudes=longitudev
            }
            if let latitudev = json[0]["local_latitude"].string{
                self.latitudes=latitudev
            }
            
            
            
            
            var coords = CLLocationCoordinate2DMake((self.longitudes as NSString).doubleValue,(self.latitudes as NSString).doubleValue);//纬度，经度
            let viewr=MKCoordinateRegionMakeWithDistance(coords, 20000, 20000)
            
            self.mapView.setRegion(viewr, animated: true)
            
            let annotation=MyAnnotation(coordinate: coords)
            
            if let nameval = json[0]["name"].string{
                annotation.titleval=nameval
            }
            
            
            if let addrval = json[0]["addr"].string{
                annotation.info=addrval
            }
            
            self.mapView.addAnnotation(annotation)


        }
        
        
      
    }
    
 
    
    func ios8() -> Bool{

        var deviceVersion:NSString = UIDevice.currentDevice().systemVersion
        return deviceVersion.substringWithRange(NSMakeRange(0, 1)) == "8"
        
    }

    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //启动服务
        locationManger.startUpdatingLocation()
    }
    
   /*

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
        var location:CLLocation=locations[locations.count-1] as! CLLocation
        if(location.horizontalAccuracy>0){
            
            println(location.coordinate.latitude)
            println(location.coordinate.longitude)
            
            
            let viewr=MKCoordinateRegionMakeWithDistance(location.coordinate, 10000, 10000)
            self.mapView.setRegion(viewr, animated: true)
            let annotation=MyAnnotation(coordinate: location.coordinate)
            annotation.info="111111"
            mapView.addAnnotation(annotation)

        }

    }

    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        //授权状态改变
    }
*/

    
        
    
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!){
        println(error)
        var alert = UIAlertView()
        alert.title = "message?"
       // alert.delegate = self
        alert.message = "Sorry, Map error"
        alert.addButtonWithTitle("OK")
        alert.show()
    }
    
    
     override func viewWillDisappear(animated: Bool) {
        //退出时停止定位
        locationManger.stopUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   }