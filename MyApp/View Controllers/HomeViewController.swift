//
//  HomeViewController.swift
//  MyApp
//
//  Created by Mañanas on 3/6/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let userID = Auth.auth().currentUser!.uid
        let db = Firestore.firestore()
        
        let docRef = db.collection("Users").document(userID)
        
        Task {
            do {
                let user = try await docRef.getDocument(as: User.self)
                print("User: \(user)")
            } catch {
                print ("Error getting document: \(error)")
            }
        }
    }
    
    @IBAction func signOut(_ sender: Any) {
        do {
          try Auth.auth().signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        self.dismiss(animated: true, completion: nil)
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
