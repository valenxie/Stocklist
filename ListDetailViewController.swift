//
//  ListDetailViewController.swift
//  stocklist
//
//  Created by 谢畅 on 2019/1/24.
//  Copyright © 2019年 valenx. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate: class {
    func listDetailViewControllerDidCancel(
        _ controller: ListDetailViewController)
    func listDetailViewController(
        _ controller: ListDetailViewController,
        didFinishAdding stocklist: Stocklist)
    func listDetailViewController(
        _ controller: ListDetailViewController,
        didFinishEditing stocklist: Stocklist)
}

    class ListDetailViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    weak var delegate: ListDetailViewControllerDelegate?
    var stocklistToEdit: Stocklist?

    override func viewDidLoad() {
     super.viewDidLoad()
     navigationItem.largeTitleDisplayMode = .never
     if let stocklist = stocklistToEdit {
        title = "Edit Stoklist"
        textField.text = stocklist.name
        doneButton.isEnabled = true
    } }
    
        override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
        // MARK:- TableView Delegates
        override func tableView(_ tableView: UITableView,
                                willSelectRowAt indexPath: IndexPath) -> IndexPath? {
            return nil
        }
        
        // MARK:- UITextField Delegates
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let oldText = textField.text!
            let stringRange = Range(range, in:oldText)!
            let newText = oldText.replacingCharacters(in: stringRange,
                                                        with: string)
            if newText.isEmpty{
                doneButton.isEnabled = false
            }else{
                doneButton.isEnabled = true
            }
            return true
        }
        
        // MARK:- Actions
        @IBAction func cancel() {
            delegate?.listDetailViewControllerDidCancel(self)
        }
        @IBAction func done() {
            if let stocklist = stocklistToEdit {
                stocklist.name = textField.text!
                delegate?.listDetailViewController(self, didFinishEditing: stocklist)
            } else {
                let stocklist = Stocklist(name: textField.text!)
                delegate?.listDetailViewController(self, didFinishAdding: stocklist)
            } }
        
}


