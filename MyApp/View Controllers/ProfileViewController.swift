//
//  ProfileViewController.swift
//  MyApp
//
//  Created by Mañanas on 9/6/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var firstnamesTextField: UITextField!
    @IBOutlet weak var surnamesTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var genderImageView: UIImageView!
    
    @IBOutlet weak var dateOfBirthPicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        return true
    }
    
    func showValidationError (error: String) {
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateUser () {
        let userID = Auth.auth().currentUser!.uid
        let name = firstnamesTextField.text!
        let surname = surnamesTextField.text!
        let birthDate = dateOfBirthPicker.date
        let gender = switch genderSegmentedControl.selectedSegmentIndex {
        case 0:
            Gender.male
        case 1:
            Gender.female
        default:
            Gender.other
            }
        
        
        do {
            let db = Firestore.firestore()
            //try db.collection("Users").document(userID).setData(from: user)
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
