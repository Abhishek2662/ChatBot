//
//  ChatVM.swift
//  ChatApp
//
//  Created by Bigbasket on 20/05/21.
//

import UIKit

class ChatVM {
    
    var msgArray : [ChatModel] = Array()
    var addMsgCallback : ((_ msgIndex:Int) ->())? = nil
    
    func sendMsg(_ msgData:ChatModel) {
        
        if(msgData.msgStstus == .newMsg) {
        
            msgArray.append(msgData)
            addMsgCallback!(msgArray.count - 1)
        }
        msgData.msgStstus = .progress
        
        let encodedMsg = msgData.msg.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        let paramDict = [
            "apiKey" : Constants.AppKeys.chatAPIKey,
            "chatBotID" : Constants.AppKeys.chatBotId,
            "externalID" : "Abhishek11",
            "message" : encodedMsg!
        ]
        NetworkManager.shared.sendMsgWithData(paramDict) { [weak self] (json, success, error) in
            
            guard let strongSelf = self else {return}
            
            if let uwJson = json as? [AnyHashable:Any],true == success {
                
                let responseMsgData = uwJson["message"] as! [AnyHashable:Any]
                let responseMsg = responseMsgData["message"] as! String
               
                let status = uwJson["success"] as! Int
                if status == 1 {
                    
                    let sentMsgData =  ChatModel.init(withMessage: responseMsg, messageStatus: .sent, isSent: false)
                    strongSelf.msgArray.append(sentMsgData)
                    strongSelf.addMsgCallback!(strongSelf.msgArray.count - 1)
                }
                else {
                    
                    msgData.msgStstus = .failed
                }
            }
        }
    }
    
    func getTotalMsgCount() -> Int {
        
        return msgArray.count
    }
    
    func getMsgAtIndex(_ index:Int) -> ChatModel {
        
        return msgArray[index]
    }
}
