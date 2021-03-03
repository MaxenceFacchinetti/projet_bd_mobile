//
//  ListeTacheTableView.swift
//  ProjetBDMobile
//
//  Created by LPIEM on 03/03/2021.
//

import UIKit

class ListeTacheTableView: UITableView {

    
    var controller: ListeTacheViewController?
    var editingStyle: UITableViewCell.EditingStyle?
    
    override func 
    
    override func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
        let cell = dequeueReusableCell(withIdentifier: "cellTache", for: indexPath)
        cell.textLabel!.text = controller?.taches[indexPath.row].titre
        cell.detailTextLabel!.text = controller?.taches[indexPath.row].desc
        if ((controller?.taches[indexPath.row].checked) != nil) {
            cell.imageView?.isHidden = false
        }
        else{
            cell.imageView?.isHidden = false
        }
           return cell
        
    }
    
    

    /*override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            appDelegate.supprimerTache(tache: taches[indexPath.row])
            taches = appDelegate.getAllTachesFromCategorie(categorie: delegate!.categorieSelected)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return taches.count
    }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }*/
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
