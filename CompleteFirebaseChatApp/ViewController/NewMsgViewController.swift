//
//  NewMsgViewController.swift
//  CompleteFirebaseChatApp
//
//  Created by Anupriya on 25/07/19.
//  Copyright © 2019 smartitventures. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class NewMsgViewController: UIViewController {
    
    @IBOutlet weak var tblUser : UITableView!
    
   // var userIncoming : UsersIncoming?
    var userIncomming : [UsersIncoming] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
        // Do any additional setup after loading the view.
    }
    
    func fetchUsers(){
        Database.database().reference().child("user").observe(.childAdded) { (user) in
            print("USERS===\(user)")
            if let userDic = user.value as? [String : Any]{
                let userIncoming = UsersIncoming(dictionary: userDic as NSDictionary)
                self.userIncomming.append(userIncoming)
                DispatchQueue.main.async {
                    self.tblUser.reloadData()
                }
            }
        }
        
        
    }
    
    
}

extension NewMsgViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.userIncomming.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let someUser = userIncomming[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        cell.lblName.text = someUser.name
        cell.lblEmail.text = someUser.email
        if someUser.image != nil{
            let url = URL(string: someUser.image!)
            cell.imgUser.sd_setImage(with: url!, completed: nil)
        }
        return cell
    }
}

extension NewMsgViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = userIncomming[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        vc.user = user
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
