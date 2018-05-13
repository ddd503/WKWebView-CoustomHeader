//
//  AccessListViewController.swift
//  WKWebView-CoustomHeader
//
//  Created by kawaharadai on 2018/05/12.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

final class AccessListViewController: UIViewController {

    @IBOutlet weak var accessPointList: UITableView!
    private let provider = AccessListProvider()
    private let datasource = AccessPointList()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // セルの選択解除
        if let indexPathForSelectedRow = accessPointList.indexPathForSelectedRow {
            accessPointList.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
    
    // MARK: - Setup
    private func setup() {
        self.accessPointList.dataSource = self.provider
        self.accessPointList.delegate = self
        self.provider.accessList = datasource.create()
        self.accessPointList.reloadData()
    }
}

extension AccessListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pageVC = PageViewController.make(title: provider.accessList[indexPath.row].title,
                                             url: provider.accessList[indexPath.row].url)
        self.navigationController?.pushViewController(pageVC, animated: true)
    }
}
