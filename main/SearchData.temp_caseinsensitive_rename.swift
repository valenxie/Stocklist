//
//  searchData.swift
//  checklist
//
//  Created by 谢畅 on 2019/3/2.
//  Copyright © 2019年 valenx. All rights reserved.
//

import Foundation

class searchData{
    
    var allWords = [String]()

init() {
    if let path = Bundle.main.path(forResource: "plays", ofType: "txt") {
        if let plays = try? String(contentsOfFile: path) {
            allWords = plays.components(separatedBy: CharacterSet.alphanumerics.inverted)
        }
    }
}
}

