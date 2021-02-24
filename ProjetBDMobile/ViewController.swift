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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate.deleteAllCategories()
        
        appDelegate.addCategorie(titre: "Cat1")
        appDelegate.addCategorie(titre: "Cat2")
        appDelegate.addCategorie(titre: "Cat3")
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addCategorie"){
            if let dest = segue.destination as? UINavigationController {
                let controller = dest.topViewController as? AjouterCategorieTableViewController
                controller?.delegate = self
            }
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
