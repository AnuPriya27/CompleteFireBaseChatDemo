//
//  LoginController.swift
//  CompleteFirebaseChatApp
//
//  Created by Anupriya on 25/07/19.
//  Copyright © 2019 smartitventures. All rights reserved.
//

import UIKit
import Firebase


class SignUpController: UIViewController {

    //MARK: Outlet
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    //MARK: Class Variables
    
    
    
    
    //MARK: Class Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: IBActions

    @IBAction func actionRegister(_ sender: UIButton) {
       firebaseAuth()
    }
    
    //MARK: FirebaseAuthentication Method
    
    func firebaseAuth(){
        guard let name = txtName.text , let email = txtEmail.text , let pswrd = txtPassword.text else{
            print("Please Enter User Crendentials!")
            return
        }
        Auth.auth().createUser(withEmail: email, password: pswrd) { (user  , error) in
            if error != nil{
                print("Getting Error while Authenticating Users!", error?.localizedDescription)
            }
            guard let uId = user?.user.uid else{
                return
            }
            
            let storageRef = Storage.storage().reference().child("\(String(describing: (user?.user.email)!)).png")
            if let uploadData =  self.imgUser.image?.jpegData(compressionQuality: 0.5) {
                storageRef.putData(uploadData, metadata: nil) { (mData, error) in
                    if error != nil{
                        print("Error===\(error)")
                        return
                    }else{
                        storageRef.downloadURL(completion: { (url, error) in
                            if error != nil{
                                print("Failed to download")
                                return
                            }else{
                                let urlStr = url?.absoluteString
                                self.createUser(uId: uId, values: ["name" : name as AnyObject , "email" : email as AnyObject , "profileImage" : urlStr as AnyObject , "id" : uId as AnyObject])
                                print("URLSTR==" , urlStr)
                            }
                        })
                    }
                }
            }
            
        }
    }
    
    
    @IBAction func actionUploadPic(_ sender: UIButton) {
        
        AttachmentHandler.shared.showAttachmentActionSheet(vc: self)
        AttachmentHandler.shared.imagePickedBlock = { (image) in
            self.imgUser.image = image
        }
        
    }
    
    
    func uploadProfilePic(img : UIImage){
       
    }
    
    
    func createUser(uId : String , values : [String : AnyObject]){
        
        let ref = Database.database().reference()
        let userRef = ref.child("user").child(uId)
        userRef.updateChildValues(values, withCompletionBlock: { (err, dataRef) in
            if err != nil{
                print("Error==err\(err)")
            }
            self.navigationController?.popToRootViewController(animated: true)
            print("User Saved Successfully in FIRDatabase!")
        })
        
    }
    
    
    
}
