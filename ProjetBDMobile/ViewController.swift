//
//  ViewController.swift
//  ProjetBDMobile
//
//  Created by LPIEM on 24/02/2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var delegate = UIApplication.shared.delegate as! AppDelegate
    var taches: [Tache] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate.deleteAllTaches()
        
        delegate.addCategorie(titre: "Cat1")
        delegate.addCategorie(titre: "Cat2")
        
        delegate.addTache(titre: "tache1",categorie: delegate.getOneCategorie(titre: "Cat1"))
        delegate.addTache(titre: "tache2",categorie: delegate.getOneCategorie(titre: "Cat1"))
        delegate.addTache(titre: "tache3",categorie: delegate.getOneCategorie(titre: "Cat2"))
        taches = delegate.getAllTaches()
        
        for tache in taches{
            print("Tache : " + tache.titre!)
            print("Categorie : " + (tache.categorie?.titre!)!)
        }
        // Do any additional setup after loading the view.
    }


}

