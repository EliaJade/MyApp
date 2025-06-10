//
//  SignUpViewController.swift
//  MyApp
//
//  Created by Mañanas on 5/6/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    //MARK: Outlets

    @IBOutlet weak var firstnamesTextField: UITextField!
    @IBOutlet weak var surnamesTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var genderImageView: UIImageView!
    
    @IBOutlet weak var dateOfBirthPicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let maxDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        dateOfBirthPicker.maximumDate = maxDate
        // Do any additional setup after loading the view.
    }
    
    func validate() -> Bool {
        if firstnamesTextField.text?.isEmpty ?? true {
            showValidationError(error: "First names cannot be empty")
            return false
        }
        
        if surnamesTextField.text?.isEmpty ?? true {
            showValidationError(error: "Surnames cannot be empty")
            return false
        }
        
        if emailTextField.text?.isEmpty ?? true {
            showValidationError(error: "Email cannot be empty")
            return false
        }
        
        if passwordTextField.text?.isEmpty ?? true {
            showValidationError(error: "Password cannot be empty")
            return false
        }
        
        if passwordTextField.text!.count < 6 {
            showValidationError(error: "Password must have more than 6 characters")
            return false
        }
        
        if repeatPasswordTextField.text?.isEmpty ?? true {
            showValidationError(error: "You must repeat the password to confirm it")
            return false
        }
        
        if passwordTextField.text != repeatPasswordTextField.text {
            showValidationError(error: "Password does not match")
            return false
        }
        return true
    }
    
    func showValidationError (error: String) {
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        if (validate()) {
            let username = emailTextField.text ?? ""
            let password = passwordTextField.text ?? ""
            
            Auth.auth().createUser(withEmail: username, password: password) {  [unowned self] authResult, error in
                if let error = error {
                    // Hubo un error
                    print(error)
                    
                    let alertController = UIAlertController(title: "Create user", message: error.localizedDescription, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                } else {
                    // Todo correcto
                    print("User signs up successfully")
                    
                    createUser()
                    
                    let alertController = UIAlertController(title: "Create user", message: "Signed up succesfully", preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func createUser() {
        let userID = Auth.auth().currentUser!.uid
        let username = usernameTextField.text!
        let firstNames = firstnamesTextField.text!
        let surnames = surnamesTextField.text!
        let birthday = dateOfBirthPicker.date
        let gender = switch genderSegmentedControl.selectedSegmentIndex {
        case 0:
            Gender.male
        case 1:
            Gender.female
        default:
            Gender.other
            }
        
        let user = User (id: userID, username: username, firstNames: firstNames, surnames: surnames, gender: gender, birthday: birthday, provider: .basic)
        
        do {
            let db = Firestore.firestore()
            
            try db.collection("Users").document(userID).setData(from: user)
            let alertController = UIAlertController(title: "Success", message: "Your account has been created successfully", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
        } catch let error {
            print("Error adding document: \(error)")
                
            let alertController = UIAlertController(title: "Create user", message: error.localizedDescription, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
            }
        }
    
    @IBAction func genderSegmentedControl(_ sender: Any) {
        switch genderSegmentedControl.selectedSegmentIndex {
        case 0:
            genderImageView.image = UIImage(named: "genderIcon-female")
        case 1:
            genderImageView.image = UIImage(named: "genderIcon-male")
        default:
            genderImageView.image = UIImage(named: "genderIcon-other")
            break
        }
    }
    

}
