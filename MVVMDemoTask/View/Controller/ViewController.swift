//
//  ViewController.swift
//  MVVMDemoTask
//
//  Created by Akash Jain on 01/11/23.
//

import UIKit
import SkyFloatingLabelTextField

class ViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var usernameTF : SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTF : SkyFloatingLabelTextField!
    @IBOutlet weak var loginBtn : UIButton!
    
    //MARK: - Variables
    var validation = ValidationTF()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
}
//MARK: - Setup UI Function
extension ViewController{
    func setupUI(){
        validation.delegate = self
        loginBtn.layer.cornerRadius = 10
        loginBtn.layer.borderWidth = 5
        loginBtn.layer.borderColor = UIColor.link.cgColor
    }
}
//MARK: - Actions
extension ViewController{
    
    @IBAction func usernameEntered(_ sender : SkyFloatingLabelTextField){
        if let textValue = sender.text{
            sender.errorMessage = validation.validateEmail(value: textValue)
            validation.username = textValue
        }
    }
    
    @IBAction func passwordEntered(_ sender : SkyFloatingLabelTextField){
        if let textValue = sender.text{
            sender.errorMessage = validation.validatePassword(value: textValue)
            validation.password = textValue
        }
    }
    
    @IBAction func buttonClicked(_ sender : UIButton){
        validation.allValidation()
    }
}
//MARK: - Data Obtained Functions
extension ViewController : ValueObtained{
    func showData(title: String, btnTitle: String) {
        usernameTF.text = ""
        passwordTF.text = ""
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btnTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showError(title: String, btnTitle: String) {
        usernameTF.text = ""
        passwordTF.text = ""
        let alert = UIAlertController(title: title, message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btnTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
