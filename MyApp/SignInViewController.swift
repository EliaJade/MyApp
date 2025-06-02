//
//  ViewController.swift
//  MyApp
//
//  Created by Mañanas on 2/6/25.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signUp(_ sender: Any) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
            /*if let error = error {
            // Hubo un error
            print(error)
                
            let alertController = UIAlertController(title: "Create user", message: error.localizedDescription, prefe
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self-present(alertController, animated: true, completion: nil)
            }
            else {
            // Todo correcto
            print("User signs
            up successfully")*/
        }
    }
                
            
    
    @IBAction func signIn(_ sender: Any) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        Auth.auth().signIn(withEmail: username, password: password) { [unowned self] authResult, error in
            if let error = error {
                    // Hubo un error
                    print (error)
                
                    let alertController = UIAlertController(title: "Sign In", message:
                        error.localizedDescription, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present (alertController, animated: true, completion: nil)
                } else {
                    print("User signs in successfully")
                    goToHome()
                    
                }

        }
    }
}

