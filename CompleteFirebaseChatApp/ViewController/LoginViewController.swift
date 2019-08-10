//
//  LoginViewController.swift
//  CompleteFirebaseChatApp
//
//  Created by Anupriya on 25/07/19.
//  Copyright © 2019 smartitventures. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPswrd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionSignIn(_ sender: Any) {
        signInFir()
    }
    
    
    @IBAction func actionSignUp(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpController") as! SignUpController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: HandleSignIn With FireBase
    
    func signInFir(){
        guard let email = txtEmail.text , let pswrd = txtPswrd.text else{
            return
        }
        Auth.auth().signIn(withEmail: email, password: pswrd) { (user, error) in
            if error != nil{
                print("ERROR+++++\(error)")
                return
            }
           self.navigationController?.popViewController(animated: true)
          print("User Loged in and Uid is \(user?.user.uid)")
        }
        
    }
    
}
