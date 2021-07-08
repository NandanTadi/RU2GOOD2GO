//
//  SignupViewController.swift
//  RU2GOOD2GO
//
//  Created by Nandan Tadi on 7/7/21.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func validateEntries() -> Bool{
        let fullNameRegEx = "^[a-zA-Z-]+ ?.* [a-zA-Z-]+$"
        let fullNamePred = NSPredicate(format:"SELF MATCHES %@", fullNameRegEx)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailField.text) && fullNamePred.evaluate(with: fullNameField.text)
    }
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        if(validateEntries() == true){
            print("Success Sign Up!")
        }else{
            let alertController = UIAlertController(
                title: "Full name or email entry error!",
                message: "Please re-enter",
                preferredStyle: UIAlertController.Style.alert
            )
            let okayAction = UIAlertAction(title: "OK", style: .default) { (action) in
            }
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "toLogin", sender: nil)
    }
}
