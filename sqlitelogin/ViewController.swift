//
//  ViewController.swift
//  sqlitelogin
//
//  Created by Pravesh SmartTechnica on 15/04/25.
//

import UIKit
import SQLite

class ViewController: UIViewController {

    @IBOutlet var addpasswords: UITextField!
    @IBOutlet var addname: UITextField!
    @IBOutlet var img: UIImageView!
  
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    
    @IBAction func login(_ sender: UIButton) {
        guard let username = addname.text, !username.isEmpty,
                  let password = addpasswords.text, !password.isEmpty else {
                showAlert(message: "Please enter both username and password.")
                return
            }
            
            let success = DatabaseManager.shared.loginUser(username: username, password: password)
            
            if success {
                showAlert(message: "Login successful!")
                // Navigate to next screen if needed
            } else {
                showAlert(message: "Invalid username or password.")
            }
        }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Clear the text fields when OK is pressed
            self.addname.text = ""
            self.addpasswords.text = ""
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }

     
    @IBAction func newuser(_ sender: UIButton) {
        
        guard let name = addname.text, !name.isEmpty,
                 let pass = addpasswords.text, !pass.isEmpty else {
                      showAlert(message: "Name or Password is empty")
               print("Name or Password is empty")
               return
           }

           let success = DatabaseManager.shared.registerUser(username: name, password: pass)
           
           if success { showAlert(message: "New User Registered Successfully")
               print("Registered Successfully")
               // Optionally show an alert or go to another screen
           } else { showAlert(message: "User Already Exists")
               print("Registration Failed (maybe user already exists)")
           }
       }
        
        
    }
  
