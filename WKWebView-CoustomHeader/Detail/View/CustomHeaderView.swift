//
//  CustomHeaderView.swift
//  WKWebView-CoustomHeader
//
//  Created by kawaharadai on 2018/05/13.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

protocol CustomHeaderViewDelegate: class {
    /// header内の情報が更新された時に呼ぶ
    func setHeaderPosition()
    
    func back()
}

final class CustomHeaderView: UIView {

    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var cursorButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var delegate: CustomHeaderViewDelegate?
    var blueViewHeight: CGFloat?
    var titleText: String? {
        didSet {
            self.titleLabel.text = titleText
        }
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Setup
    private func setup() {
         /// xibの呼び出し
        let view = Bundle.main.loadNibNamed("CustomHeaderView",
                                            owner: self,
                                            options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    /// 折りたたみエリアの表示・非表示
    @IBAction func cursorControll(_ sender: UIButton) {
        guard let cursor = sender.titleLabel?.text else {
            return
        }
        
        if cursor == "↑" {
            self.blueView.isHidden = true
            self.cursorButton.setTitle("↓", for: .normal)
            self.delegate?.setHeaderPosition()
        } else {
            if #available(iOS 10.0, *) {
                 self.blueView.isHidden = false
            } else {
                // iOS9以前の場合
                // TODO: stackViewのバグでとるつめが効かない
            }
           
            self.cursorButton.setTitle("↑", for: .normal)
            self.delegate?.setHeaderPosition()
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.delegate?.back()
    }
}
