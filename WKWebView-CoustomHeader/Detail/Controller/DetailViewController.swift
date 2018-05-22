//
//  DetailViewController.swift
//  WKWebView-CoustomHeader
//
//  Created by kawaharadai on 2018/05/12.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    // MARK: - Propaties
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    private var webView: CustomWebView?
    private var headerView: CustomHeaderView?
    private var pageTitle = "タイトルがありません"
    private var accessURL = ""
    
    static var identifer: String {
        return String(describing: self)
    }
    
    // MARK: - Factory
    class func make(title: String, url: String) -> DetailViewController {
        let storyboard = UIStoryboard(name: DetailViewController.identifer, bundle: nil)
        guard let detailViewControllerVC = storyboard.instantiateViewController(withIdentifier: DetailViewController.identifer) as? DetailViewController else {
            fatalError("VCのインスタンス化に失敗")
        }
        // タイトルとURLの受け渡し
        detailViewControllerVC.pageTitle = title
        detailViewControllerVC.accessURL = url
        return detailViewControllerVC
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // WebViewのautolayoutの設定
        self.setupConstain(webView: self.webView)
        
        // headerViewのサイズ設定（header内情報が確定したタイミングで）
        self.setHeaderPosition()
    }
    
    // MARK: - Setup
    private func setup() {
        self.setupWebView()
        self.setupHeaderView()
    }
    
    private func setupWebView() {
        self.webView = CustomWebView(frame: .zero, configuration: setupConfiguration())
        self.webView?.delegate = self
        self.webView?.scrollView.delegate = self
        self.baseView.addSubview(self.webView ?? WKWebView())
        
        guard !self.accessURL.isEmpty else {
            print("アクセスURLが見つかりません。")
            self.navigationController?.popToRootViewController(animated: true)
            return
        }
        
        self.load(urlString: self.accessURL)
    }
    
    private func setupHeaderView() {
        self.headerView = CustomHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0))
        self.headerView?.delegate = self
        self.headerView?.titleText = self.pageTitle
        self.webView?.scrollView.addSubview(self.headerView ?? CustomHeaderView())
    }
    
    /// configに設定を加える場合はここで行う
    private func setupConfiguration() -> WKWebViewConfiguration {
        return WKWebViewConfiguration()
    }
    
    /// autolayoutを設定（4辺共に0）
    private func setupConstain(webView: WKWebView?) {
        webView?.translatesAutoresizingMaskIntoConstraints = false
        self.baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]|",
                                                                    options: NSLayoutFormatOptions(),
                                                                    metrics: nil,
                                                                    views: ["v0": webView ?? WKWebView()]))
        self.baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0]|",
                                                                    options: NSLayoutFormatOptions(),
                                                                    metrics: nil,
                                                                    views: ["v0": webView ?? WKWebView()]))
    }
    
    /// webページをロード
    private func load(urlString: String) {
        guard let url = URL(string: urlString) else {
            print("URLが不正")
            return
        }
        let request = URLRequest(url: url)
        self.webView?.load(request)
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // webコンテンツのはみ出しを防止
        scrollView.contentSize.width = self.view.frame.size.width
    }
}

extension DetailViewController: CustomWebViewDelegate {
    
//    func didWebViewScroll(scrollView: UIScrollView) {
//        // webコンテンツのはみ出しを防止
//        scrollView.contentSize.width = self.view.frame.size.width
//    }
    
    func didStartProvisionalNavigation(webView: WKWebView, navigation: WKNavigation!) {
        print("読み込み開始")
        self.indicator.startAnimating()
    }
    
    func didFinish(webView: WKWebView, navigation: WKNavigation!) {
        print("読み込み完了")
        self.indicator.stopAnimating()
    }
    
    func didFailProvisionalNavigation(webView: WKWebView, navigation: WKNavigation!, error: Error) {
        print("読み込み中エラー")
        self.indicator.stopAnimating()
    }
    
    func didFail(webView: WKWebView, navigation: WKNavigation!, error: Error) {
        print("通信中のエラー")
        self.indicator.stopAnimating()
    }
}

extension DetailViewController: CustomHeaderViewDelegate {
    
    func setHeaderPosition() {
        self.headerView?.setNeedsLayout()
        let size = self.headerView?.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        let headerHeight = size?.height ?? 0
        self.headerView?.frame = CGRect(x: 0,
                                        y: -headerHeight,
                                        width: self.view.frame.size.width,
                                        height: headerHeight)
        self.webView?.scrollView.contentInset = UIEdgeInsetsMake(headerHeight, 0, 0, 0)
        self.webView?.scrollView.setContentOffset(CGPoint(x: 0, y: -headerHeight), animated: false)
    }
    
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
}
