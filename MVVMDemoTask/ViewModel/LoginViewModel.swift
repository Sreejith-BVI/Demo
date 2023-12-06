//
//  LoginViewModel.swift
//  MVVMDemoTask
//
//  Created by Akash Jain on 01/11/23.
//

//smit.shah@brainvire.com
//Smit@0602
import Foundation
//MARK: - protocol ValueObtained
protocol ValueObtained: AnyObject{
    func showData(title : String,btnTitle : String)
    func showError(title : String,btnTitle : String)
}
//MARK: - ValidationTF
class ValidationTF{
    
    //MARK: - Variables
    var username = ""
    var password = ""
    weak var delegate : ValueObtained?
    
    //validateEmail
    func validateEmail(value : String) -> String{
        if self.usernameValidation(value: value){
            return ""
        }
        else{
            return "Invalid Email"
        }
    }
    
    //validatePassword
    func validatePassword(value : String) -> String{
        if self.passwordValidation(value: value){
            return ""
        }
        else{
            return "Invalid Password"
        }
    }

    // Username Validation
    func usernameValidation(value: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format : "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: value)
    }
    
    //Password Validation
    func passwordValidation(value: String) -> Bool {
        if value.count >= 8{
            return true
        }
        else{
            return false
        }
    }
    
    //Button Validation
    func allValidation(){
        if username != "" && password != ""{
            APIManager.shared.loginApi(username: username, password: password, completion: {[weak self] data,_ in
                DispatchQueue.main.async {
                    if let dataObtained = data?.success{
                        if dataObtained{
                            self?.delegate?.showData(title: "Login Successful", btnTitle: "Okay")
                        }
                        else{
                            self?.delegate?.showError(title: "Invalid Credentials", btnTitle: "Okay")
                        }
                    }
                }
            })
        }
        else{
            self.delegate?.showError(title: "Enter All Fields", btnTitle: "Okay")
        }
    }
}

