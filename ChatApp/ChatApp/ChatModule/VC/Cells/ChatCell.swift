//
//  ChatCell.swift
//  ChatApp
//
//  Created by Bigbasket on 19/05/21.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var msgLbl : UILabel!
    @IBOutlet weak var msgContainer : UIView!
    @IBOutlet weak var dateLbl : UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        msgContainer.layer.cornerRadius = 8.0
        msgContainer.layer.masksToBounds = true
        dateLbl.font = UIFont.systemFont(ofSize: 9.0)
    }
    
    func configureWithChatModal(_ model:ChatModel) {
        
        self.msgLbl.text = model.msg
        self.dateLbl.text = model.formatedDate
    }
}
