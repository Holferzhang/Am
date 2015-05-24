//
//  MyAnnotation.swift
//  Am
//
//  Created by daiqile on 15/5/23.
//  Copyright (c) 2015年 LB. All rights reserved.
//

import MapKit

class MyAnnotation: NSObject,MKAnnotation {

// /   var titleval:String!
    var info:String!
    var titleval:String!
    var coordinate:CLLocationCoordinate2D
    init(coordinate:CLLocationCoordinate2D){
    
    self.coordinate=coordinate
    }
    var title:String{
    
   
          return titleval

    }
    var subtitle:String{
    
        return info
    }
}
