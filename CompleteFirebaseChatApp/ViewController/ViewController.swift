//
//  ViewController.swift
//  CompleteFirebaseChatApp
//
//  Created by Anupriya on 25/07/19.
//  Copyright © 2019 smartitventures. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class ViewController: UIViewController {
    
    var messages : [MessageIncoming] = []
    var messageDic : [String : MessageIncoming] = [:]
    
    //
    @IBOutlet weak var tblMsg : UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        handleLogOut()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func actionSignOut(_ sender: Any) {
        do{
            try Auth.auth().signOut()
        }catch{
            print("Catch Error Here")
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
        }
    
    
    func handleLogOut()  {
        if Auth.auth().currentUser?.uid == nil{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let uId = Auth.auth().currentUser?.uid
            Database.database().reference().child("user").child(uId!).observe(.value) { (snapShot) in
                if let userDict = snapShot.value as? [String : Any]{
                    //self.navigationI
                    self.navigationItem.title = userDict["name"] as? String
                }
                print("SNAPSHOTDATA===\(snapShot)")
            }
            self.obserbeMsg()
             self.observeUserMsg()
        }
    }
    
    func obserbeMsg(){
        Database.database().reference().child("messages").observe(.childAdded) { (snapShot) in
            if let msgDic = snapShot.value as? [String : Any]{
                let msg = MessageIncoming(dictionary: msgDic as NSDictionary)
                if let toId = msg.toId{
                  self.messageDic[toId] = msg
                  self.messages = Array(self.messageDic.values)
                }
                DispatchQueue.main.async {
                    self.tblMsg.reloadData()
                }
            }
        }
    }
    
    
    func observeUserMsg(){
        guard let uId = Auth.auth().currentUser?.uid else{
            return
        }
        let ref = Database.database().reference().child("userMessages").child(uId)
        ref.observe(.childAdded) { snapData  in
            print("hdkhkdsfhkdfh= \(snapData)")
        }
    
    }
    
    
    @IBAction func actionNewMsg(_ sender: UIBarButtonItem) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewMsgViewController") as! NewMsgViewController
     self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self.messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "LattestMsgTableViewCell") as! LattestMsgTableViewCell
        if let toId = message.toId{
            Database.database().reference().child("user").child(toId).observe(.value) { snapShot in
                if let someUserDict = snapShot.value as? [String : AnyObject]{
                    cell.lblName.text = someUserDict["name"] as? String
                    if let image = someUserDict["profileImage"] as? String{
                        let url = URL(string: image)
                        cell.imgUser.sd_setImage(with: url!, completed: nil)
                    }
                }
            }
            
        }
        cell.lblmsg.text = message.message
        return cell
    }
    
    
    
}

extension ViewController : UITableViewDelegate{
    
    
}
