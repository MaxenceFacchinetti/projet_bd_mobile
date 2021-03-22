//
//  ViewController.swift
//  ProjetBDMobile
//
//  Created by LPIEM on 24/02/2021.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var taches: [Tache] = []
    var categories: [Categorie] = []
    var categorieModif: Categorie!
    var categorieSelected: Categorie!
    var testEdit: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        categories = appDelegate.getAllCategories()
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCategorie", for: indexPath)
        cell.textLabel!.text = categories[indexPath.row].titre
           return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.getAllCategories().count
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        categorieModif = appDelegate.getOneCategorie(titre: categories[indexPath.row].titre!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addCategorie"){
            if let dest = segue.destination as? UINavigationController {
                let controller = dest.topViewController as? AjouterCategorieTableViewController
                controller?.delegate = self
                controller?.typeManip = .ADD
            }
        }
        
        if(segue.identifier == "editCategorie"){
            if let dest = segue.destination as? UINavigationController {
                let controller = dest.topViewController as? AjouterCategorieTableViewController
                controller?.delegate = self
                controller?.typeManip = .EDIT
            }
        }
        
        if(segue.identifier == "listeTaches"){
            if let dest = segue.destination as? UINavigationController {
                let controller = dest.topViewController as? ListeTacheTableViewController
                controller?.delegate = self 
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categorieSelected = categories[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            print(categories[indexPath.row].titre! + " supprimé")
            appDelegate.supprimerCategorie(categorie: categories[indexPath.row])
            categories = appDelegate.getAllCategories()
            tableView.reloadData()
        }
    }
    
}

extension ViewController : AjouterCategorieDelegate {
    
    func didCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func didAddCategorie(titre: String){
        appDelegate.addCategorie(titre: titre)
        categories = appDelegate.getAllCategories()
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
}

extension ViewController : EditCategorieDelegate {
    
    func didEditCategorie(titre: String){
        categorieModif.titre = titre
        categorieModif.dateMaj = Date()
        appDelegate.saveContext()
        categories = appDelegate.getAllCategories()
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
}
