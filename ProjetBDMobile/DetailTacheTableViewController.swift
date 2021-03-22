//
//  DetailTacheTableViewController.swift
//  ProjetBDMobile
//
//  Created by LPIEM on 03/03/2021.
//

import UIKit

protocol AjouterTacheDelegate : ListeTacheTableViewController{
    func didAddTache(titre: String, desc: String, image: Data)
    func didCancel()
}

protocol EditTacheDelegate: ListeTacheTableViewController{
    func didEditTache(titre: String, desc: String, image: Data)
}

enum TypeManipTache{
    case ADD, EDIT
}

class DetailTacheTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var delegate: ListeTacheTableViewController?
    var typeManip: TypeManipTache = .ADD
    @IBOutlet weak var itemButton: UIBarButtonItem!
    @IBOutlet weak var titleTache: UITextField!
    @IBOutlet weak var descTache: UITextField!
    var imageDefault: UIImage!
    
    @IBOutlet weak var tacheImageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageDefault = tacheImageView.image!
        imagePicker.delegate = self
        
        switch(typeManip){
        case .ADD:
            title = "Ajouter une tâche"
            itemButton.title = "Add"
            break;
        case .EDIT:
            title = "Modifier une tâche"
            itemButton.title = "Edit"
            titleTache.text = delegate?.tacheModif?.titre
            descTache.text = delegate?.tacheModif?.desc
            do{
                tacheImageView.image = try UIImage.init(data: (delegate?.tacheModif?.relationshipImage?.data)!)
            }catch{
                print(error)
            }
            
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
    @IBAction func supprImage(_ sender: Any) {
        tacheImageView.image = imageDefault
    }
    
    @IBAction func itemClick(_ sender: Any) {
        switch(typeManip){
        case .ADD:
            delegate?.didAddTache(titre: titleTache.text!, desc: descTache.text!, image: (tacheImageView.image?.pngData())!)
            break;
        case .EDIT:
            delegate?.didEditTache(titre: titleTache.text!, desc: descTache.text!, image: (tacheImageView.image?.pngData())!)
            break;
        }
    }
    
}
