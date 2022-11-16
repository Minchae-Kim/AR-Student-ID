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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController = segue.destination as? ViewController else {return}
        
        nextViewController.name_data = name.text
        nextViewController.age_data = age.text
        nextViewController.email_data = email.text
        nextViewController.career_data = career.text
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
