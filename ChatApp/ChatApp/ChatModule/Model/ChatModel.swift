//
//  ChatModel.swift
//  ChatApp
//
//  Created by Bigbasket on 20/05/21.
//

import Foundation

enum MessageStatus : Int {

    case sent, failed, progress,newMsg
}

class ChatModel {
    
    var msg = "";
    var msgStstus = MessageStatus.failed
    var msgDate = Date.init()
    var isSent = true
    var formatedDate = ""
    
    init(withMessage message:String,messageStatus status:MessageStatus, messageDate date:Date = Date.init(),isSent sent:Bool = true) {
        
        msg = message
        msgStstus = status
        msgDate = date
        isSent = sent
        
        let dateForm = DateFormatter.init()
        dateForm.dateFormat = "HH:mm:ss"
        formatedDate = dateForm.string(from: date)
    }
}

