//
//  ListeTacheTableViewController.swift
//  ProjetBDMobile
//
//  Created by LPIEM on 03/03/2021.
//

import UIKit

class ListeTacheTableViewController: UITableViewController, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    var delegate: ViewController?
    var taches: [Tache] = []
    var tacheModif: Tache?
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var resultSearchController: UISearchController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = delegate!.categorieSelected.titre
        
        taches = appDelegate.getAllTachesFromCategorie(categorie: delegate!.categorieSelected)
        
        resultSearchController = ({
                let controller = UISearchController(searchResultsController: nil)
                controller.searchResultsUpdater = self
                controller.dimsBackgroundDuringPresentation = false
                controller.searchBar.sizeToFit()

                tableView.tableHeaderView = controller.searchBar

                return controller
            })()
        
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        tacheModif = appDelegate.getOneTache(titre: taches[indexPath.row].titre!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addTache"){
            if let dest = segue.destination as? UINavigationController {
                let controller = dest.topViewController as? DetailTacheTableViewController
                controller?.delegate = self
                controller?.typeManip = .ADD
            }
        }
        
        if(segue.identifier == "editTache"){
            if let dest = segue.destination as? UINavigationController {
                let controller = dest.topViewController as? DetailTacheTableViewController
                controller?.delegate = self
                controller?.typeManip = .EDIT
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            appDelegate.supprimerTache(tache: taches[indexPath.row])
            taches = appDelegate.getAllTachesFromCategorie(categorie: (delegate?.categorieSelected)!)
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTache", for: indexPath)
        cell.textLabel!.text = taches[indexPath.row].titre
        cell.detailTextLabel!.text = taches[indexPath.row].desc
        
        if taches[indexPath.row].checked {
            cell.imageView?.isHidden = false
            cell.backgroundColor = UIColor(named: "CheckedTache")
        }
        else{
            cell.imageView?.isHidden = true
            cell.backgroundColor = UIColor(named: "Default")
        }
        
    
        
           return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        appDelegate.checkTache(tache: taches[indexPath.row])
        taches = appDelegate.getAllTachesFromCategorie(categorie: (delegate?.categorieSelected)!)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taches.count
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

extension ListeTacheTableViewController : AjouterTacheDelegate {
    func didAddCTache(titre: String, desc: String, image: Image) {
        
    }
    
    
    func didCancel() {
        dismiss(animated: true, completion: nil)
    }
}

extension ListeTacheTableViewController : EditTacheDelegate {
    func didEditTache(titre: String, desc: String, image: Image) {
        
    }
    
    

}
