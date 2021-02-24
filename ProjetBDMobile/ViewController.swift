//
//  ViewController.swift
//  ProjetBDMobile
//
//  Created by LPIEM on 24/02/2021.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var delegate = UIApplication.shared.delegate as! AppDelegate
    var taches: [Tache] = []
    var categories: [Categorie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate.deleteAllCategories()
        
        delegate.addCategorie(titre: "Cat1")
        delegate.addCategorie(titre: "Cat2")
        delegate.addCategorie(titre: "Cat3")
    
        categories = delegate.getAllCategories()
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCategorie", for: indexPath)
        cell.textLabel!.text = categories[indexPath.row].titre
           return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate.getAllCategories().count
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
    
    func didAddCategorie(){
        dismiss(animated: true, completion: nil)
    }
    
}

