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
    
    @IBOutlet var searchBar: UISearchBar!
    var delegate: ViewController?
    var taches: [Tache] = []
    var tacheModif: Tache?
    var appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self 
        self.title = delegate!.categorieSelected.titre
        
        rafraichirTaches()

        
    }
    
    func rafraichirTaches(){
        taches = appDelegate.getAllTachesFromCategorie(categorie: delegate!.categorieSelected)
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
        if(searchBar.text == ""){
            taches = appDelegate.getAllTachesFromCategorie(categorie: (delegate?.categorieSelected)!)
        }else{
            taches = appDelegate.getTachesRecherche(search: searchBar.text!, categorie: (delegate?.categorieSelected)!)
        }
        
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
    func didAddTache(titre: String, desc: String, image: Data) {
        appDelegate.addTache(titre: titre, categorie: (delegate?.categorieSelected)!, desc: desc,data: image)
        appDelegate.saveContext()
        didCancel()
        rafraichirTaches()
        tableView.reloadData()
    }
    
    
    func didCancel() {
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
}

extension ListeTacheTableViewController : EditTacheDelegate {
    func didEditTache(titre: String, desc: String, image: Data) {
        appDelegate.addImage(data: image)
        let image = appDelegate.getOneImage(data: image)
        tacheModif?.relationshipImage = image
        tacheModif?.dateMaj = Date()
        tacheModif?.desc = desc
        tacheModif?.titre = titre
        appDelegate.saveContext()
        didCancel()
        rafraichirTaches()
        tableView.reloadData()
    }
    

}

extension ListeTacheTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText != ""){
            taches = appDelegate.getTachesRecherche(search: searchText, categorie: (delegate?.categorieSelected)!)
            tableView.reloadData()
        }else{
            taches = appDelegate.getAllTachesFromCategorie(categorie: (delegate?.categorieSelected)!)
            tableView.reloadData()
        }
        
    }
}
