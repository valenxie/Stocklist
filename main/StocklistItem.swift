//
//  StocklistItem.swift
//  stocklist
//
//  Created by 谢畅 on 2019/1/20.
//  Copyright © 2019年 valenx. All rights reserved.
//

import Foundation

class StocklistItem: NSObject, Codable{
    var name = ""
    var price = ""
    var amount = ""
    var checked = false
    
    init(name: String) {
        self.name = name
        super.init()
    }
    func toggleChecked(){
        checked = !checked
    }
    
}
