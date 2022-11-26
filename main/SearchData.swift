//
//  searchData.swift
//  stocklist
//
//  Created by 谢畅 on 2019/3/2.
//  Copyright © 2019年 valenx. All rights reserved.
//

import Foundation

class searchData{
    
    var allWords = [String]()
    var wordCounts = [String: Int]()
    
init() {
    if let path = Bundle.main.path(forResource: "inputtxt", ofType: "txt") {
        if let plays = try? String(contentsOfFile: path) {
            allWords = plays.components(separatedBy: CharacterSet.alphanumerics.inverted)
        }
        
        allWords = allWords.filter({ testString in
            if testString != "" {
                return true
            } else {
                return false
            }
        })
        
        for word in allWords {
            if wordCounts[word] == nil {
                wordCounts[word] = 1
            } else {
                wordCounts[word]! += 1
            }
        }
        
    }
}
}

