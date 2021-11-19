//
//  AddItemTableViewController.swift
// stocklist
//
//  Created by 谢畅 on 2019/1/21.
//  Copyright © 2019年 valenx. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func addItemViewControllerDidCancel(
        _ controller: ItemDetailViewController)
    func addItemViewController(
        _ controller: ItemDetailViewController,
        didFinishAdding item: StocklistItem)
    func addItemViewController(
     _ controller: ItemDetailViewController,
        didFinishEditing item: StocklistItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    
    weak var delegate: ItemDetailViewControllerDelegate?
    var itemToEdit: StocklistItem?
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.name
            priceField.text = item.price
            amountField.text = item.amount
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    @IBAction func cancel() {
         delegate?.addItemViewControllerDidCancel(self)
    }
    @IBAction func done() {
        if let itemToEdit = itemToEdit { //shadowing
            itemToEdit.name = textField.text!
            itemToEdit.price = priceField.text!
            itemToEdit.amount = amountField.text!
            delegate?.addItemViewController(self,didFinishEditing: itemToEdit)
        }else {
    let item = StocklistItem(name: textField.text!)
    item.name = textField.text!
    item.price = priceField.text!
    item.amount = amountField.text!
    item.checked = false
    delegate?.addItemViewController(self, didFinishAdding: item)
    }
}
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in:oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty{
            doneButton.isEnabled = false
        }else{
            doneButton.isEnabled = true
        }
        return true
    }
    
    func priceField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = priceField.text!
        let stringRange = Range(range, in:oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty{
            doneButton.isEnabled = false
        }else{
            doneButton.isEnabled = true
        }
        return true
    }
    
    func amountField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                     replacementString string: String) -> Bool {
        let oldText = amountField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty{
            doneButton.isEnabled = false
        }else{
            doneButton.isEnabled = true
        }
        return true
    }

 

}

