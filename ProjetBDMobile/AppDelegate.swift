//
//  AppDelegate.swift
//  ProjetBDMobile
//
//  Created by LPIEM on 24/02/2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ProjetBDMobile")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func supprimerCategorie(categorie: Categorie){
        let context = persistentContainer.viewContext
        context.delete(categorie)
        saveContext()
    }
    
    func supprimerTache(tache: Tache){
        let context = persistentContainer.viewContext
        context.delete(tache)
        saveContext()
    }
    
    func checkTache(tache: Tache){
        if tache.checked {
            tache.checked = false
        }
        else{
            tache.checked = true
        }
    }
    
    func addTache(titre: String, categorie: Categorie, desc: String){
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Tache", in: managedContext)
        let tache = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        tache.setValue(titre,forKey:"titre")
        tache.setValue(Date(),forKey: "dateCrea")
        tache.setValue(Date(), forKey: "dateMaj")
        tache.setValue(categorie, forKey: "relationshipCategorie")
        tache.setValue(false, forKey: "checked")
        tache.setValue(desc, forKey: "desc")
        print("ADD TACHE")
        saveContext()
    }
    
    func addTache(titre: String, categorie: Categorie, desc: String, data: Data){
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Tache", in: managedContext)
        let tache = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        addImage(data: data)
        let image = getOneImage(data: data)
        
        tache.setValue(titre,forKey:"titre")
        tache.setValue(Date(),forKey: "dateCrea")
        tache.setValue(Date(), forKey: "dateMaj")
        tache.setValue(categorie, forKey: "relationshipCategorie")
        tache.setValue(false, forKey: "checked")
        tache.setValue(desc, forKey: "desc")
        tache.setValue(image, forKey: "relationshipImage")
        print("ADD TACHE")
        saveContext()
    }
    
    
    
    func getOneImage(data: Data) -> Image{
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Image> = Image.fetchRequest()
        
        let predicate  = NSPredicate(format: "data == %@", data as CVarArg)
        fetchRequest.predicate = predicate
        
        do{
            let result: [Image] = try managedContext.fetch(fetchRequest)
            return result[0]
        } catch {
            print("GET ONE IMAGE " + error.localizedDescription)
        }
        return Image()
    }
    
    func addImage(data: Data){
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Image", in: managedContext)
        let image = NSManagedObject(entity: entity!, insertInto: managedContext)
        image.setValue(data, forKey: "data")
        image.setValue(Date(),forKey: "dateCrea")
        image.setValue(Date(),forKey: "dateMaj")
        print("ADD IMAGE")
        saveContext()
    }
    
    func addCategorie(titre: String){
        let managedContext = persistentContainer.viewContext/*
        let entity = NSEntityDescription.entity(forEntityName: "Categorie", in: managedContext)
        let categorie = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        categorie.setValue(titre,forKey:"titre")
        categorie.setValue(Date(),forKey: "dateCrea")
        categorie.setValue(Date(), forKey: "dateMaj")*/
        print("ADD CATEGORIE")
        
        let categorie2 = Categorie(context: managedContext)
        categorie2.titre = titre
        categorie2.dateMaj = Date()
        categorie2.dateCrea = Date()
        
        saveContext()
    }
    
    func getAllTachesFromCategorie(categorie: Categorie) -> [Tache] {
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Tache> = Tache.fetchRequest()
        
        let predicate = NSPredicate(format: "relationshipCategorie == %@",categorie)
        fetchRequest.predicate = predicate
        
        do{
            let result: [Tache] = try managedContext.fetch(fetchRequest)
            return result
        } catch {
            print("GET ALL TACHE FROM CATEGORIE " + error.localizedDescription)
        }
        
        return []
    }

    func getAllTaches() -> [Tache]{
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Tache> = Tache.fetchRequest()
        
        do{
            let result: [Tache] = try managedContext.fetch(fetchRequest)
            return result
        } catch {
            print("GET ALL TACHES " + error.localizedDescription)
        }
        return []
    }
    
    func getTachesRecherche(search: String, categorie: Categorie) -> [Tache] {
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Tache> = Tache.fetchRequest()
        
        let predicate  = NSPredicate(format: "(titre CONTAINS[c] %@ OR desc CONTAINS[c] %@) AND relationshipCategorie == %@", search, search, categorie)
        fetchRequest.predicate = predicate
        
        do{
            let result: [Tache] = try managedContext.fetch(fetchRequest)
            return result
        } catch {
            print("GET TACHE RECHERCHE" + error.localizedDescription)
        }
        return []    }
    
    func getCategoriesRecherche(search: String) -> [Categorie] {
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Categorie> = Categorie.fetchRequest()
        
        let predicate  = NSPredicate(format: "titre CONTAINS[c] %@", search)
        fetchRequest.predicate = predicate
        
        do{
            let result: [Categorie] = try managedContext.fetch(fetchRequest)
            return result
        } catch {
            print("GET CATEGORIE RECHERCHE" + error.localizedDescription)
        }
        return []    }
    
    func getAllCategories() -> [Categorie]{
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Categorie> = Categorie.fetchRequest()
        
        do{
            let result: [Categorie] = try managedContext.fetch(fetchRequest)
            return result
        } catch {
            print("GET ALL TACHES " + error.localizedDescription)
        }
        return []
    }
    
    func getOneCategorie(titre: String) -> Categorie{
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Categorie> = Categorie.fetchRequest()
        
        let predicate  = NSPredicate(format: "titre == %@", titre)
        fetchRequest.predicate = predicate
        
        do{
            let result: [Categorie] = try managedContext.fetch(fetchRequest)
            return result[0]
        } catch {
            print("GET ONE CATEGORIE " + error.localizedDescription)
        }
        return Categorie()
        
    }
    
    func getOneTache(titre: String) -> Tache{
        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Tache> = Tache.fetchRequest()
        
        let predicate  = NSPredicate(format: "titre == %@", titre)
        fetchRequest.predicate = predicate
        
        do{
            let result: [Tache] = try managedContext.fetch(fetchRequest)
            return result[0]
        } catch {
            print("GET ONE TACHE " + error.localizedDescription)
        }
        return Tache()
    }
    
    func deleteAllTaches(){
        print("DELETE ALL TACHES")
        let managedContext = persistentContainer.viewContext
        let taches = getAllTaches()
        for tache in taches {
            managedContext.delete(tache)
        }
    }
    
    func deleteAllCategories(){
        print("DELETE ALL CATEGORIES")
        let managedContext = persistentContainer.viewContext
        let categories = getAllCategories()
        for categorie in categories {
            managedContext.delete(categorie)
        }
    }

}

