//
//  LattestMsgTableViewCell.swift
//  CompleteFirebaseChatApp
//
//  Created by Anupriya on 26/07/19.
//  Copyright © 2019 smartitventures. All rights reserved.
//

import UIKit

class LattestMsgTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblmsg : UILabel!
    @IBOutlet weak var imgUser : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
