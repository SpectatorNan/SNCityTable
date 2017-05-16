//
//  SNCityHeader.swift
//  cityTable
//
//  Created by spectator Mr.Z on 2017/5/15.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

class SNCityHeader: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexadecimal: 0x969696)
        label.font = UIFont.systemFont(ofSize: adjustSizeAPP(attribute: 30))
        return label
    }()

    var title : String {
        set {
            nameLabel.text = newValue
        }
        
        get {
            return nameLabel.text ?? ""
        }
    }
}

extension SNCityHeader {
    
    func setupView() {
        
        backgroundColor = UIColor(hexadecimal: 0xf5f5f5)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adjustSizeAPP(attribute: 34))
            make.centerY.equalToSuperview()
        }
        
    }
}
