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
    func didAddCategorie()
    func didCancel()
}

class AjouterCategorieTableViewController : UITableViewController{
    
    var delegate: ViewController!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func addCategorie(_ sender: Any) {
        
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        delegate.didCancel()
    }
    
    
}
