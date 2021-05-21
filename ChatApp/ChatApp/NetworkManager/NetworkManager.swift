//
//  NetworkManager.swift
//  ChatApp
//
//  Created by Bigbasket on 20/05/21.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {

    static let httpRequestTimeoutInterval: Double = 30
    static let shared = NetworkManager()
    
    typealias CompletionHandler =  (_ response:AnyObject?, _ success:Bool, _ error:Error?) -> ()
    
    override private init() {

    }
    
    func sendMsgWithData(_ parameter:[String:String], onCompletion completion: @escaping CompletionHandler) {
        
        let urlStr = String(format: Constants.URLConstant.msgSendURL, parameter["apiKey"]!,parameter["message"]!,parameter["chatBotID"]!,parameter["externalID"]!)
        let request = Alamofire.request(urlStr, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
        request.responseData { (responseData) in
                        
            if let response = responseData.response, response.statusCode == 200 {
                
                if let data = responseData.data {
                    
                    let json = NetworkManager.dataToJSON(data: data)
                    completion(json,true,nil)
                }
                else {
                    
                    completion(nil,false,responseData.error)
                }
            }
            else {
                
                completion(nil,false,responseData.error)
            }
        }
    }
    
    class func dataToJSON(data: Data) -> AnyObject? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
}
