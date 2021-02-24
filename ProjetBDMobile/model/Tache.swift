//
//  Tache.swift
//  ProjetBDMobile
//
//  Created by LPIEM on 24/02/2021.
//

import Foundation
import CoreData

class Tache : NSManagedObject {
    
    var title: String!
    var dateCrea: Date!
    var categorie: String!
    var checked: Bool!
    
    init(){
        
    }
    
}
