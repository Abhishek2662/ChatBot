//
//  SenderCell.swift
//  ChatApp
//
//  Created by Bigbasket on 19/05/21.
//

import UIKit

class SenderCell: ChatCell {

    override func awakeFromNib() {
        
        super.awakeFromNib()
        msgContainer.backgroundColor = UIColor.init(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.3)
    }
}
