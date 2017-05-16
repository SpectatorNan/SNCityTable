//
//  ViewController.swift
//  cityTable
//
//  Created by spectator Mr.Z on 2017/5/13.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let v = SNCityIndexView(frame: CGRect.zero, dataArray: SNCityDB().fecthCityDataGroup(by: ["A","B","C"]), rowHeight: 0, sectionHeight: 0, headerHeight: 0)
        view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adjustSizeAPP(attribute: 450))
            make.right.equalTo(view.snp.right).offset(0)
            make.width.equalTo(adjustSizeAPP(attribute: 30))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func push(_ sender: Any) {
        
        navigationController?.pushViewController(SNCityTableController(currentCity: "北京"), animated: true)
        
    }

}

