//
//  SNCityCell.swift
//  cityTable
//
//  Created by spectator Mr.Z on 2017/5/13.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

class SNCityCell: UITableViewCell {
    
    public static let cellID = "SNCityCell"

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
    
    fileprivate var line : UIView = {
       let l = UIView()
        l.backgroundColor = UIColor(hexadecimal: 0xdadada)
        return l
    }()
    
    var model : SNCityDBModel? {
        didSet {
            nameLabel.text = model!.name
        }
    }
    
    var name : String {
        get {
            return nameLabel.text!
        }
    }
}

extension SNCityCell {
    
    func setupView() {
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(line)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adjustSizeAPP(attribute: 34))
            make.centerY.equalToSuperview()
        }
        
        line.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(adjustSizeAPP(attribute: 30))
            make.right.equalToSuperview().offset(adjustSizeAPP(attribute: -30))
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview()
        }
        
    }
}
