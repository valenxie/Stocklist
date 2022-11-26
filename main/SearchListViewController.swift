//
//  SearchListViewController.swift
//  stocklist
//
//  Created by 谢畅 on 2019/3/4.
//  Copyright © 2019年 valenx. All rights reserved.
//

import UIKit

class SearchListViewController: UIViewController, UITextViewDelegate{
   
        
        var itemNames = [StocklistItem]()
        var searchItem = searchData()
        @IBOutlet weak var inputtxt: UIView!
       
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            self.view.endEditing(true)
        }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.characters.count + (text.characters.count - range.length) <= 300
    }
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
    }

