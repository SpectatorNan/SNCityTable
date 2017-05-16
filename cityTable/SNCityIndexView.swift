//
//  SNCityIndexView.swift
//  cityTable
//
//  Created by spectator Mr.Z on 2017/5/15.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

class SNCityIndexView: UIView {
    
     typealias tap = (Int) -> ()
    var clickIndex : tap?

    
     /// 初始化indexView
     ///
     /// - Parameters:
     ///   - dataArray: 数据数组
     ///   - rowHeight: 行高
     ///   - sectionHeight: section高
     ///   - headerHeight: tableview头部高度
     init(frame: CGRect ,dataArray:Array<SNCityGroupModel>, rowHeight: CGFloat, sectionHeight: CGFloat, headerHeight:CGFloat) {
        super.init(frame: frame)
        setupView(dataArray)
    }
    
    
    /// 初始化indexView
    ///
    /// - Parameter dataArray: 数据数组
    init(dataArray: Array<SNCityGroupModel>) {
        super.init(frame: .zero)
        setupView(dataArray)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SNCityIndexView {
    
    func setupView(_ arr: Array<SNCityGroupModel>) {
        
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        let sizeValue = adjustSizeAPP(attribute: 25)
        
        var view = UIView()
        for i in 0..<arr.count {
            let btn = UIButton(frame: CGRect(x: 0, y: CGFloat(i)*(sizeValue+adjustSizeAPP(attribute: 4)), width: sizeValue, height: sizeValue))
            addSubview(btn)
            btn.tag = i
            btn.addTarget(self, action: #selector(click), for: .touchUpInside)
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: sizeValue, height: sizeValue))
            btn.addSubview(label)
            label.text = arr[i].title
            label.textColor = string_ColorRGB(hex: "242424")
            label.font = UIFont.boldSystemFont(ofSize: adjustSizeAPP(attribute: 22))
            label.textAlignment = .center
            view = btn
        }
        snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom)
        }
        
        
    }
    
    @objc private func click(sender: UIButton) {
        self.clickIndex?(sender.tag)
        print(sender.tag)
    }
    
}
