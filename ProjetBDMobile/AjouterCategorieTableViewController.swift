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

protocol EditCategorieDelegate: ViewController{
    func didEditCategorie(titre: String)
}

enum TypeManipCategorie{
    case ADD, EDIT
}

class AjouterCategorieTableViewController : UITableViewController{
    
    @IBOutlet weak var textField: UITextField!
    var delegate: ViewController!
    var tacheModif: Tache!
    @IBOutlet weak var barButtonRight: UIBarButtonItem!
    var typeManip: TypeManipCategorie = .ADD
    
    override func viewDidLoad() {
        textField.becomeFirstResponder()
        
        switch typeManip {
        case .ADD:
            barButtonRight.title = "Add"
            break
        
        case .EDIT:
            barButtonRight.title = "Edit"
            textField.text = delegate.categorieModif.titre
            break
        }
        
    }
    
    @IBAction func manipCategorie(_ sender: Any) {
        switch typeManip{
        case .ADD:
            delegate.didAddCategorie(titre: textField.text!)
            break
        case .EDIT:
            delegate.didEditCategorie(titre: textField.text!)
            break
        }
        
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        delegate.didCancel()
    }
    
    
}
