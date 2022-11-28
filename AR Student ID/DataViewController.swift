//
//  DataViewController.swift
//  AR Student ID
//
//  Created by 김수환 on 2022/10/11.
//

import UIKit

class DataViewController: UIViewController {
    
    @IBOutlet var name: UITextField!
    @IBOutlet var age: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var career: UITextView!
    
    @IBOutlet var imageLoadBtn: UIButton!
    
    var image: UIImage!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
    }
    
    @IBAction func loadImage(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        present(vc, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController = segue.destination as? ViewController else {return}
        
        nextViewController.name_data = name.text
        nextViewController.age_data = age.text
        nextViewController.email_data = email.text
        nextViewController.career_data = career.text
        
        if image != nil {
            nextViewController.image_data = image
        }
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


extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension DataViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[UIImagePickerController.InfoKey.originalImage] {
            image = img as? UIImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
