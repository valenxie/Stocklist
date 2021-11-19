//
//  DataModel.swift
//  stocklist
//
//  Created by 谢畅 on 2019/1/25.
//  Copyright © 2019年 valenx. All rights reserved.
//

import Foundation

class DataModel {
    var lists = [Stocklist]()
    
    init() {
        loadStocklists()
        setDefaults()
        firstRun()
    }
    var indexOfSelectedStocklist: Int {
        get {
            return UserDefaults.standard.integer(
                forKey: "StocklistIndex")
        } set {
            UserDefaults.standard.set(newValue,
                                      forKey: "StocklistIndex")
        } }
    
    func setDefaults() {
        let dictionary = [ "StocklistIndex": -1, "FirstRun": true] as [String : Any]
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    func firstRun(){
        let userDefaults = UserDefaults.standard
        let firstRun = userDefaults.bool(forKey: "FirstRun")
        if firstRun{
            let stocklist = Stocklist(name:"Category")
            lists.append(stocklist)
            indexOfSelectedStocklist = -1
            userDefaults.set(false, forKey: "FirstRun")
            
        }
    }
    //MARK:- DATA STORGE
    func docDirect() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory,
                                             in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return docDirect().appendingPathComponent("com.valenx.checklist.plist")
    }
    
    func saveStocklists() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(lists)
            try data.write(to: dataFilePath(),
                           options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding array")
        }
    }
    
    func loadStocklists() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                lists = try decoder.decode([Stocklist].self, from: data)
                sortLists()
            } catch {
                print("Error decoding array")
            }
        }
    }
    
    func sortLists(){
        lists.sort(by: { stocklist1, stocklist2 in
            return stocklist1.name.localizedStandardCompare(
                stocklist2.name) == .orderedAscending })
    }

            
}
