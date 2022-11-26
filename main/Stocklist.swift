//
//  Stocklist.swift
//  stocklist
//
//  Created by 谢畅 on 2019/1/24.
//  Copyright © 2019年 valenx. All rights reserved.
//

import UIKit

class Stocklist: NSObject, Codable{
    var name = ""
    var items = [StocklistItem]()
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    func countUnchecked() -> Int {
        var count = 0
        for item in items where !item.checked {
            count += 1 }
        return count
    }
}

//This creates a new empty array that can hold ChecklistItem objects and assigns it to the items property.
