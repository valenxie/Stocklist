//
//  StocklistViewController.swift
//  stocklist
//
//  Created by 谢畅 on 2019/1/3.
//  Copyright © 2019年 valenx. All rights reserved.
//

import UIKit

class StocklistViewController: UITableViewController, ItemDetailViewControllerDelegate{
    
    
    var stocklist: Stocklist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        title = stocklist.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Table delegates
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return stocklist.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StocklistItem", for: indexPath)
        //returns copies of prototypes
        let item = stocklist.items[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        configurePrice(for: cell, with: item)
        configureAmount(for: cell, with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if let cell = tableView.cellForRow(at: indexPath) {
           let item = stocklist.items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        stocklist.items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "AddItem" {
        let controller = segue.destination
        as! ItemDetailViewController
        controller.delegate = self}
        else if segue.identifier == "EditItem" {
        let controller = segue.destination
            as! ItemDetailViewController
        controller.delegate = self
        if let indexPath = tableView.indexPath( //find corresponding index path
            for: sender as! UITableViewCell){
            controller.itemToEdit =  stocklist.items[indexPath.row]
         }
        
        }}
    
    //MARK:- Private methods
    func configureCheckmark(for cell: UITableViewCell,
                            with item: StocklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.text = "✓"
        } else {
            label.text = ""
        }
    }
    
    func configureText(for cell: UITableViewCell,
                       with item: StocklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.name
    }
    
    func configurePrice(for cell: UITableViewCell,
                       with item: StocklistItem){
        let label2 =  cell.viewWithTag(2000) as! UILabel
        label2.text = item.price
    }
    
    func configureAmount(for cell: UITableViewCell,
                         with item: StocklistItem){
        let label3 = cell.viewWithTag(3000) as! UILabel
        label3.text =  item.amount
    }
    
    // MARK:- ItemDetailViewController Delegates
    func addItemViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated:true)
    }
    
    func addItemViewController(_ controller: ItemDetailViewController, didFinishAdding item: StocklistItem) {
        let newRowIndex =  stocklist.items.count
        stocklist.items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated:true)
    }
    func addItemViewController(_ controller: ItemDetailViewController,
        didFinishEditing item: StocklistItem) {
        if let index =  stocklist.items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
                configurePrice(for: cell, with: item)
                configureAmount(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated:true)
    }
 
}

