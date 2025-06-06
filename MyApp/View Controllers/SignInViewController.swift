//
//  ViewController.swift
//  MyApp
//
//  Created by Mañanas on 2/6/25.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class SignInViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func signIn(_ sender: Any) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        Auth.auth().signIn(withEmail: username, password: password) { [unowned self] authResult, error in
            if let error = error {
                // Hubo un error
                print (error)
                
                let alertController = UIAlertController(title: "Sign In", message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                self.present (alertController, animated: true, completion: nil)
            } else {
                print("User signs in successfully")
                goToHome()
                
            }
            
        }
    }
    
    @IBAction func signInGoogle(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                
                if let error = error {
                    // Hubo un error
                    print (error)
                    
                    let alertController = UIAlertController(title: "Sign In", message: error.localizedDescription, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present (alertController, animated: true, completion: nil)
                } else {
                    print("User signs in successfully")
                    goToHome()
                    
                    // At this point, our user is signed in
                }
                
                // ...
            }
        }
    }
        func goToHome() {
            self.performSegue(withIdentifier: "goToHome", sender: nil)
        }
    }
    

