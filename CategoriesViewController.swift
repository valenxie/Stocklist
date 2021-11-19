//
//  CategoriesViewController.swift
//  stocklist
//
//  Created by 谢畅 on 2019/1/23.
//  Copyright © 2019年 valenx. All rights reserved.
//

import UIKit

class CategoriesViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate{
     var dataModel: DataModel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        if segue.identifier == "ShowStocklist" {
            let controller = segue.destination
                as! StocklistViewController
            controller.stocklist = sender as! Stocklist
        } else if segue.identifier == "AddStocklist" {
            let controller = segue.destination
                as! ListDetailViewController
            controller.delegate = self
        }else if segue.identifier == "EditStocklist" {
            let controller = segue.destination
                as! ListDetailViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath( //find corresponding index path
                for: sender as! UITableViewCell){
                controller.stocklistToEdit = dataModel.lists[indexPath.row]
            }
        }}
    
    //MARK:- Table delegates
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        dataModel.indexOfSelectedStocklist = indexPath.row
        let stocklist = dataModel.lists[indexPath.row]
        performSegue(withIdentifier: "ShowStocklist",sender: stocklist)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.lists.count
    }
    
    override func tableView(_ tableView: UITableView,
                        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = makeCell(for: tableView)
        let stocklist = dataModel.lists[indexPath.row]
        if let label = cell.textLabel {
            label.text = stocklist.name
        }
        
        let count = stocklist.countUnchecked()
        if stocklist.items.count ==  0 {
            cell.detailTextLabel!.text = "(No Products)"
        } else if count == 0{
            cell.detailTextLabel!.text = "(All sold)"
        } else {
            cell.detailTextLabel!.text  = "\(stocklist.countUnchecked()) Products remaining"}
        cell.accessoryType = .detailDisclosureButton
        return cell
 }
    
    func makeCell(for tableView: UITableView) -> UITableViewCell {
        let cellIdentifier = "Cell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        } }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = self
        let index = dataModel.indexOfSelectedStocklist
        if index >= 0 && index < dataModel.lists.count {
            let stocklist = dataModel.lists[index]
            performSegue(withIdentifier: "ShowStocklist", sender: stocklist)
        }
         }
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
            dataModel.lists.remove(at: indexPath.row)
            let indexPaths = [indexPath]
            tableView.deleteRows(at: indexPaths, with: .automatic)
        }
   
    
    // MARK:- List Detail View Controller Delegates
    func listDetailViewControllerDidCancel(
        _ controller: ListDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    func listDetailViewController(
        _ controller: ListDetailViewController,
        didFinishAdding stocklist: Stocklist) {
        dataModel.lists.append(stocklist)
        dataModel.sortLists()
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    func listDetailViewController(
        _ controller: ListDetailViewController,
        didFinishEditing stocklist: Stocklist) {
        dataModel.sortLists()
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool) {
        // check if the back button was tapped
        if viewController === self {
           dataModel.indexOfSelectedStocklist = -1
        }
    }
    
    
    
    
}
