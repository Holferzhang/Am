//
//  BaseInfo.swift
//  Bussiness
//
//  Created by daiqile on 15/3/28.
//  Copyright (c) 2015年 LB. All rights reserved.
//

import Foundation
import UIKit
class BaseInfo {
    

func GetUrl(pageinfo:String)-> String {
    //path 读取当前程序定义好的provinces.plist配置的网址信息
    var url:String!="false"
    if let path = NSBundle.mainBundle().pathForResource("config", ofType: "plist") {
        if let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, String> {
            url=dict["baseurl"]
        }
    }
      return url+pageinfo
  }
    
    
    
}
