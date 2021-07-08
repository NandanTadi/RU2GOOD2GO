//
//  LoginViewController.swift
//  RU2GOOD2GO
//
//  Created by Nandan Tadi on 7/7/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var forgotPwdBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func validateFields() -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailField.text)
    }
    
    @IBAction func LoginTapped(_ sender: Any) {
        if(validateFields() != false){
            print("Success Login!")
        }else{
            let alertController = UIAlertController(
                title: "Email entry error!",
                message: "Please re-enter",
                preferredStyle: UIAlertController.Style.alert
            )
            let okayAction = UIAlertAction(title: "OK", style: .default) { (action) in
            }
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)

        }
    }
    
    @IBAction func signupBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "toSignup", sender: nil)
    }
}
