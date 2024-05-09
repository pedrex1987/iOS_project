//
//  EditViewController.swift
//  project
//
//  Created by Pedro Henrique on 07/05/24.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet weak var uiImageView: UIImageView!
    @IBOutlet weak var tfEditName: UITextField!
    @IBOutlet weak var tfLocal: UITextField!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var uiNavigation: UINavigationItem!
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    var problem: ProblemModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareScreen()
    }
    
    func prepareScreen() {
        if let problem = problem {
            tfEditName.text = problem.name
            tfLocal.text = problem.local
            tvDescription.text = problem.descriptionProblem
            if let imageProblem = problem.photo {
                uiImageView.image = UIImage(data: imageProblem)
                uiImageView.contentMode = UIView.ContentMode.scaleAspectFill
            }
            uiNavigation.title = "Editar"
        }
    }
    
    @IBAction func selectImage(_ sender: UIButton?) {
        let alert = UIAlertController(title: "Selecionar Foto", message: "De onde deseja escolher a foto?", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default, handler: { _ in
                self.selectPicture(sourceType: .camera)
            })
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca", style: .default, handler: { _ in
            self.selectPicture(sourceType: .photoLibrary)
        })
        alert.addAction(libraryAction)
        
        let albumAction = UIAlertAction(title: "Album", style: .default, handler: { _ in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        })
        alert.addAction(albumAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func save(_ sender: UIButton?) {
        if problem == nil {
            problem = ProblemModel(context: context)
        }
        
        problem?.date = Date()
        problem?.name = tfEditName.text
        problem?.local = tfLocal.text
        problem?.descriptionProblem = tvDescription.text
        problem?.photo = uiImageView.image?.jpegData(compressionQuality: 0.9)
        
        try? context.save()
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func selectPicture(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            uiImageView.image = image
            uiImageView.contentMode = UIView.ContentMode.scaleAspectFill
            
        }
        dismiss(animated: true)
    }
}
