//
//  ProfileViewController.swift
//  MyApp
//
//  Created by Mañanas on 9/6/25.
//

import UIKit

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
