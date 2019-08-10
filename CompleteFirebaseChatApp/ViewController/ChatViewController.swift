//
//  ChatViewController.swift
//  CompleteFirebaseChatApp
//
//  Created by Anupriya on 26/07/19.
//  Copyright © 2019 smartitventures. All rights reserved.
//

import UIKit
import Firebase


class ChatViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var tblChat : UITableView!
    @IBOutlet weak var txtMsg : UITextField!
    
    var user : UsersIncoming?
     let databaseRoot = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = user{
            self.navigationItem.title = user.name
        }
        // Do any additional setup after loading the view.
    }
  
    @IBAction func actionSendMsg(_ sender : UIButton){
       sendTextMsg()
        
        
    }
    
    func sendTextMsg(){
        let msg = txtMsg.text?.trimmingCharacters(in: .whitespaces)
        if msg == ""{
            return
        }
        
           let currentUserId = Auth.auth().currentUser!.uid
            let databaseChats = Database.database().reference().child("messages")
            let ref = databaseChats.childByAutoId()
            let msgSend = ["fromId" : currentUserId , "message" : msg , "toId" : user?.id!]
            //ref.setValue(msgSend)
            ref.updateChildValues(msgSend as [AnyHashable : Any]) { (error, dataRef) in
                if error != nil{
                    print("ERROR==", error?.localizedDescription)
                    return
                }
                let userMsgRef = Database.database().reference().child("messages_user").child(currentUserId)
                let messageId = ref.key
                userMsgRef.updateChildValues([messageId : 1])
            }
            txtMsg.text = ""
       
        
    }

}

extension ChatViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SendTextMsgTableViewCell") as! SendTextMsgTableViewCell
        return cell
    }
    
    
    
    
}

extension ChatViewController : UITableViewDelegate{
    
}
