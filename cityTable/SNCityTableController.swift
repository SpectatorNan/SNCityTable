//
//  SNCityTableController.swift
//  cityTable
//
//  Created by spectator Mr.Z on 2017/5/13.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import UIKit

class SNCityTableController: UIViewController {
    
    typealias tap = (String) -> ()
    var clickItem : tap?
    
    fileprivate lazy var table : UITableView = {
       let table = UITableView()
        table.separatorStyle = .none
        table.register(SNCityCell.self, forCellReuseIdentifier: SNCityCell.cellID)
//        table.register(SNCityCurrentCityCell.self, forCellReuseIdentifier: SNCityCurrentCityCell.cellID)
        table.sectionIndexColor = string_ColorRGB(hex: "242424")
        table.sectionIndexBackgroundColor = .clear
        table.dataSource = self
        table.delegate = self
        
        
        
        return table
    }()
    
    fileprivate lazy var currentCityView : UIView = {
        let cityV = UIView(frame: CGRect(x: 0, y: 0, width: ScreenW, height: adjustSizeAPP(attribute: 90+26)))
       let view = SNCityCurrentView(frame: CGRect(x: 0, y: adjustSizeAPP(attribute: 26), width: ScreenW, height: adjustSizeAPP(attribute: 90)))
        cityV.addSubview(view)
        cityV.backgroundColor = string_ColorRGB(hex: "f5f5f5")
        view.backgroundColor = .white
        view.model = self.currentCity
        return cityV
    }()
    
    
    /// 数据对象
    var datas = [SNCityGroupModel]()
    let abcArr = [
    "A","B","C","D","E",
    "F","G","H","I","J",
    "K","L","M","N","O",
    "P","Q","R","S","T",
    "U","V","W","X","Y",
    "Z"
    ]
    
     init(currentCity: String) {
        super.init(nibName: nil, bundle: nil)
        self.currentCity = currentCity
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
//        datas = SNCityDB().fetchCityDatas()
        datas = SNCityDB().fecthCityDataGroup(by: abcArr)
        table.tableHeaderView = currentCityView
        let indexView = SNCityIndexView(frame: .zero, dataArray: self.datas, rowHeight: 0, sectionHeight: 0, headerHeight: 0)
        view.addSubview(indexView)
        
        indexView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(adjustSizeAPP(attribute: 450)-24)
            make.right.equalTo(view.snp.right).offset(0)
            make.width.equalTo(adjustSizeAPP(attribute: 30))
        }
        
        indexView.clickIndex = { [unowned self] section in
            self.table.scrollToRow(at: IndexPath.init(row: 0, section: section), at: .top, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var currentCity: String = "深圳"

}

extension SNCityTableController {
    
    
    /// 启动视图
    func setupView() {
        title = "选择地址"

        let back = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        back.setImage(UIImage(named: "location_close"), for: .normal)
        back.addTarget(self, action: #selector(popVC), for: .touchUpInside)
//        back.imageEdgeInsets = UIEdgeInsetsMake(0, adjustSizeAPP(attribute: 40), 0, 0)
        let backItem = UIBarButtonItem(customView: back)
        
        let spacing = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacing.width = adjustSizeAPP(attribute: 40)-20
        navigationItem.leftBarButtonItems = [spacing,backItem]
        
        view.addSubview(table)
        table.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    
    func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension SNCityTableController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return 1
//        default:
            return datas[section].cities.count
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        switch indexPath.section {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: SNCityCurrentCityCell.cellID, for: indexPath) as! SNCityCurrentCityCell
//            cell.model =  "深圳"
//            return cell
//        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: SNCityCell.cellID, for: indexPath) as! SNCityCell
            cell.model = datas[indexPath.section].cities[indexPath.row]
            return cell
            
//        }
    }
}

extension SNCityTableController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SNCityHeader(frame: CGRect(x: 0, y: 0, width: ScreenW, height: adjustSizeAPP(attribute: 50)))
//        if section != 0 {
        header.title = datas[section].title
        return header
//        }
//        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return adjustSizeAPP(attribute: 50)
    }
    
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        
//        var arr = [String]()
//        for data in datas1 {
//            arr.append(data.title)
//        }
//        return arr
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
       let cell =  tableView.cellForRow(at: indexPath) as! SNCityCell
        self.clickItem?(cell.name)
    }
    
}
