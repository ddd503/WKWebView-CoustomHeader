//
//  AccessListProvider.swift
//  WKWebView-CoustomHeader
//
//  Created by kawaharadai on 2018/05/12.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

final class AccessListProvider: NSObject {
    var accessList = [AccessPoint]()
}

extension AccessListProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accessList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccessPointCell", for: indexPath)
        cell.textLabel?.text = accessList[indexPath.row].title
        return cell
    }
}

