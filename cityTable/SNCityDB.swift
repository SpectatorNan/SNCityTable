//
//  SNCityDB.swift
//  cityTable
//
//  Created by spectator Mr.Z on 2017/5/13.
//  Copyright © 2017年 spectator Mr.Z. All rights reserved.
//

import Foundation
import UIKit
import SQLite

class SNCityDB {
    
    fileprivate var dbtask : Connection? {
        get  {
            return db
        }
    }
    private lazy var db : Connection? = {
        guard let path = Bundle.main.path(forResource: "china_cities.db", ofType: "") else {
            return nil
        }
      
        let obj = try? Connection(path)
        
        
        return obj
    }()
    
    init() {
        
        db?.busyTimeout = 5
        db?.busyHandler({ (retry) -> Bool in
            if retry > 3 {
                return false
            }
            return true
        })
    }

}

struct SNCityGroupModel {
    let title : String
    let cities : Array<SNCityDBModel>
}

struct SNCityDBModel {
    let heat : CGFloat
    let header: Character
    let name : String
    let pinyin: String
}


extension SNCityDB {
    
    func fetchCityDatas() -> [SNCityDBModel] {
        
        let table = Table("city")
        let chinaName = Expression<String>("name")
        let pinyinName = Expression<String>("pinyin")
        
        let query = table.select(chinaName, pinyinName)
        
        var models = [SNCityDBModel]()
        for city in (try! dbtask?.prepare(query))! {
//            print("city: \(city[chinaName]), pinyinName: \(city[pinyinName])")
            let name = city[chinaName]
            let py = city[pinyinName]
            let heat: CGFloat = 0.0
            let header = py.uppercased().characters.first!
            
            let model = SNCityDBModel(heat: heat, header: header, name: name, pinyin: py)
            print(model)
            models.append(model)
        }
        
        return models
    }
    
    func fecthCityDataGroup(by: Array<String>) -> Array<SNCityGroupModel> {
        
        var arrM = Array<SNCityGroupModel>()
        for headerKey in by {
            
            //var dic = SNCityGroupModel()
            
            //dic["title"] = headerKey
            
            let table = Table("city")
            let chinaName = Expression<String>("name")
            let pinyinName = Expression<String>("pinyin")
            let query = table.select(chinaName, pinyinName).filter(pinyinName.like(headerKey.uppercased()+"%"))
            var models = [SNCityDBModel]()
            for city in (try! dbtask?.prepare(query))! {
                //            print("city: \(city[chinaName]), pinyinName: \(city[pinyinName])")
                let name = city[chinaName]
                let py = city[pinyinName]
                let heat: CGFloat = 0.0
                let header = py.uppercased().characters.first!
                
                let model = SNCityDBModel(heat: heat, header: header, name: name, pinyin: py)
                print(model)
                models.append(model)
            }
            if models.count > 0 {
                var dic = SNCityGroupModel(title: headerKey, cities: models.sorted(by: {$0.pinyin>$1.pinyin}))
                //dic["cities"] = models.sorted(by: {$0.pinyin>$1.pinyin})
                print(dic)
                arrM.append(dic)
            }
        }
        return arrM
    }
}
