//
//  SNCityCurrentCityCell.swift
//  cityTable
//
//  Created by spectator Mr.Z on 2017/5/13.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

class SNCityCurrentCityCell: UITableViewCell {
    
    public static let cellID = "SNCityCurrentCityCell"

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate var nameLabel : UILabel = {
       let label = UILabel()
        label.textColor = UIColor(hexadecimal: 0x242424)
        label.font = UIFont.systemFont(ofSize: adjustSizeAPP(attribute: 30))
        return label
    }()
    
    fileprivate var descLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexadecimal: 0x969696)
        label.text = "当前定位城市"
        label.font = UIFont.systemFont(ofSize: adjustSizeAPP(attribute: 30))
        return label
    }()
    
    var model : String {
        set {
            nameLabel.text = newValue
        }
        
        get {
            return nameLabel.text!
        }
    }
}

extension SNCityCurrentCityCell {
    
    
    
    func setupView() {
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(descLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(adjustSizeAPP(attribute: 34))
        }
        
        
        descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(adjustSizeAPP(attribute: 28))
            make.centerY.equalToSuperview()
        }
    }
}
