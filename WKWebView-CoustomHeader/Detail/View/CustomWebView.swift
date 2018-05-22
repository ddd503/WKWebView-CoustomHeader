//
//  CustomWebView.swift
//  WKWebView-CoustomHeader
//
//  Created by kawaharadai on 2018/05/12.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit
import WebKit

protocol CustomWebViewDelegate: class {
    func didStartProvisionalNavigation(webView: WKWebView,
                                       navigation: WKNavigation!)
    func didFinish(webView: WKWebView,
                   navigation: WKNavigation!)
    func didFailProvisionalNavigation(webView: WKWebView,
                                      navigation: WKNavigation!,
                                      error: Error)
    func didFail(webView: WKWebView,
                 navigation: WKNavigation!,
                 error: Error)
//    func didWebViewScroll(scrollView: UIScrollView)
}

class CustomWebView: WKWebView {
    
    // MARK: - Propaties
    var delegate: CustomWebViewDelegate?
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
        setupWebView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup
    private func setupWebView() {
        self.navigationDelegate = self
        self.uiDelegate = self
        self.allowsBackForwardNavigationGestures = true
        // 元々持っているから付与しなくてもデリゲートメソッドを使える
//        self.scrollView.delegate = self
    }
    
}

// MARK: - WKNavigationDelegate
extension CustomWebView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.delegate?.didStartProvisionalNavigation(webView: webView, navigation: navigation)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.delegate?.didFinish(webView: webView, navigation: navigation)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.delegate?.didFailProvisionalNavigation(webView: webView,
                                                    navigation: navigation,
                                                    error: error)
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.delegate?.didFail(webView: webView, navigation: navigation, error: error)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        // 読み込みを許可
        decisionHandler(.allow)
    }
}

// MARK: - WKUIDelegate
extension CustomWebView: WKUIDelegate {
    
    /// _blank挙動対応
    func webView(_ webView: WKWebView,
                 createWebViewWith configuration: WKWebViewConfiguration,
                 for navigationAction: WKNavigationAction,
                 windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        guard
            let targetFrame = navigationAction.targetFrame,
            targetFrame.isMainFrame else {
                webView.load(navigationAction.request)
                return nil
        }
        return nil
    }
    
    /// プレビュー表示の許可
    @available(iOS 10.0, *)
    func webView(_ webView: WKWebView,
                 shouldPreviewElement elementInfo: WKPreviewElementInfo) -> Bool {
        
        return true
    }
}

// MARK: - UIScrollViewDelegate
// 元々持っているため拡張してはいけない
//extension CustomWebView: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        self.delegate?.didWebViewScroll(scrollView: scrollView)
//    }
//}
