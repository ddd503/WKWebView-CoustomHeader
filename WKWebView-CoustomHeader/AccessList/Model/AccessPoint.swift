//
//  AccessPoint.swift
//  WKWebView-CoustomHeader
//
//  Created by kawaharadai on 2018/05/12.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

struct AccessPoint {
    var title: String
    var url: String
    
    init(title: String, url: String) {
        self.title = title
        self.url = url
    }
}

final class AccessPointList {
    private let titleList = ["WebView-Costom",
                             "CollectionView_Pinch",
                             "ImageVIew-Pinch",
                             "TransitionAnimation-fadein",
                             "Mapping-Json-Objective-C",
                             "TaskManegerApp_Swift",
                             "TwitterClientSample",
                             "TableView_Sample"]
    private let urlList = ["https://github.com/ddd503/WebView-Costom",
                           "https://github.com/ddd503/CollectionView_Pinch",
                           "https://github.com/ddd503/ImageVIew-Pinch",
                           "https://github.com/ddd503/TransitionAnimation-fadein",
                           "https://github.com/ddd503/Mapping-Json-Objective-C",
                           "https://github.com/ddd503/TaskManegerApp_Swift",
                           "https://github.com/ddd503/TwitterClientSample",
                           "https://github.com/ddd503/TableView_Sample"]
    
    func create() -> [AccessPoint] {
        var list = [AccessPoint]()
        for i in 0 ..< titleList.count {
            let accessPoint = AccessPoint.init(title: self.titleList[i], url: self.urlList[i])
            list.append(accessPoint)
        }
        
        return list
    }
}
