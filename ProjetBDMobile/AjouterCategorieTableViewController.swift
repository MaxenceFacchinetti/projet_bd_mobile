//
//  AjouterCategorieTableViewController.swift
//  ProjetBDMobile
//
//  Created by LPIEM on 24/02/2021.
//

import Foundation
import UIKit
import CoreData

protocol AjouterCategorieDelegate : ViewController{
    func didAddCategorie(titre: String)
    func didCancel()
}

class AjouterCategorieTableViewController : UITableViewController{
    
    @IBOutlet weak var textField: UITextField!
    var delegate: ViewController!
    
    override func viewDidLoad() {
        textField.becomeFirstResponder()
    }
    
    @IBAction func addCategorie(_ sender: Any) {
        delegate.didAddCategorie(titre: textField.text!)
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        delegate.didCancel()
    }
    
    
}
