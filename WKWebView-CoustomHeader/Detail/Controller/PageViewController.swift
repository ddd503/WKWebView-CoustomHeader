//
//  PageViewController.swift
//  WKWebView-CoustomHeader
//
//  Created by kawaharadai on 2018/05/12.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    static var identifer: String {
        return String(describing: self)
    }
    
    private var pageTitle: String?
    private var accessURL: String?
    
    // MARK: - Factory
    class func make(title: String, url: String) -> PageViewController {
        let storyboard = UIStoryboard(name: DetailViewController.identifer, bundle: nil)
        guard let pageViewControllerVC = storyboard.instantiateViewController(withIdentifier: PageViewController.identifer) as? PageViewController else {
            fatalError("VCのインスタンス化に失敗")
        }
        pageViewControllerVC.pageTitle = title
        pageViewControllerVC.accessURL = url
        return pageViewControllerVC
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([getFirst()], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
    }
    
    func getFirst() -> DetailViewController {
        guard let url = accessURL else {
            print("アクセスURLが見つかりません。")
            self.navigationController?.popViewController(animated: true)
            return DetailViewController()
        }
        
        return DetailViewController.make(title: self.pageTitle ?? "タイトルがありません", url: url)
    }
    
}

// MARK: - UIPageViewControllerDataSource
extension PageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        return self.getFirst()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
}
