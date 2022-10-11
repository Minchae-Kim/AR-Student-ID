//
//  DataViewController.swift
//  AR Student ID
//
//  Created by 김수환 on 2022/10/11.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet var SetName: UITextField!
    
    @IBOutlet var SetAge: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SetData(_ sender: Any) {

        let vc = ViewController()
        vc.name_data = SetName.text
        vc.age_data = SetAge.text
        self.present(vc, animated: false)
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
