//
//  DetailTacheTableViewController.swift
//  ProjetBDMobile
//
//  Created by LPIEM on 03/03/2021.
//

import UIKit

protocol AjouterTacheDelegate : ListeTacheTableViewController{
    func didAddCTache(titre: String, desc: String, image: Image)
    func didCancel()
}

protocol EditTacheDelegate: ListeTacheTableViewController{
    func didEditTache(titre: String, desc: String, image: Image)
}

enum TypeManipTache{
    case ADD, EDIT
}

class DetailTacheTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var delegate: ListeTacheTableViewController?
    var typeManip: TypeManipTache = .ADD
    
    
    @IBOutlet weak var tacheImageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        switch(typeManip){
        case .ADD:
            title = "Ajouter une tâche"
            break;
        case .EDIT:
            title = "Modifier une tâche"
            break;
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            tacheImageView.contentMode = .scaleAspectFit
            tacheImageView.image = pickedImage
        }

        dismiss(animated: true, completion: nil)
    }

    @IBAction func choisirImage(_ sender: Any) {
 
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
            
        self.present(imagePicker, animated: true, completion: nil)
        
        /*imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker,animated: true,completion: nil)*/
    }
        
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.didCancel()
    }


}
