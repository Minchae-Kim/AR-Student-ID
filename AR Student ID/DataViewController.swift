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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController = segue.destination as? ViewController else {return}
        
        nextViewController.name_data = name.text
        nextViewController.age_data = age.text
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
