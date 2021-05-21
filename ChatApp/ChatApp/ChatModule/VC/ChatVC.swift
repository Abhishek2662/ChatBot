//
//  ChatVC.swift
//  ChatApp
//
//  Created by Bigbasket on 19/05/21.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var btmConstraint:NSLayoutConstraint!
    @IBOutlet weak var msgBox:UITextView!
    @IBOutlet weak var chatTableView:UITableView!
    @IBOutlet weak var msgBoxContainer:UIView!
    @IBOutlet weak var sendBtn:UIButton!
    @IBOutlet weak var seperatorView:UIView!
    
    lazy var chatVM = ChatVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ChatBot"
        setNavBarButton()
        // Do any additional setup after loading the view.
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.estimatedRowHeight = 52.0
        setUpColors()
    }
    
    func setUpColors() {
    
        chatTableView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        seperatorView.backgroundColor = UIColor.gray
        msgBoxContainer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        msgBox.layer.cornerRadius = msgBox.frame.size.height/2.0
        msgBox.layer.masksToBounds = true
        
        msgBox.layer.borderWidth = 0.3
        msgBox.layer.borderColor = UIColor.gray.cgColor
        
        msgBox.backgroundColor = UIColor.white
        
        sendBtn.layer.cornerRadius = sendBtn.frame.size.height/2.0
        sendBtn.layer.masksToBounds = true
        
        sendBtn.layer.borderWidth = 0.3
        sendBtn.layer.borderColor = UIColor.gray.cgColor
        sendBtn.backgroundColor = UIColor.white
    }
    
    @objc func leftMenuItemSelected(_ sender:Any) {
        
        navigationController!.dismiss(animated: true) {
            
        };
    }
    
    @IBAction func didTapSendButton(_ sender:UIButton) {
    
        chatVM.addMsgCallback = {[weak self](msgIndex:Int) ->() in
            
            guard let strongSelf = self else {
                
                return
            }
            let indexPath = IndexPath.init(row: msgIndex, section: 0)
            strongSelf.chatTableView.insertRows(at: [indexPath], with: .automatic)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                
                strongSelf.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)//insertRows(at: [indexPath], with: .automatic)
            }
        }
        let chatData = ChatModel.init(withMessage: msgBox.text, messageStatus: .newMsg)
        chatVM.sendMsg(chatData)
    }
    
    func setNavBarButton() {
        
        let leftMenuItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ChatVC.leftMenuItemSelected(_ :)))
        navigationItem.setLeftBarButton(leftMenuItem, animated: false);
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        registerKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unRegisterKeyboardNotification()
    }
    
    func registerKeyboardNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.keyboardWillShow(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unRegisterKeyboardNotification() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification:Notification) {
        
        if let kbSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
        
            btmConstraint.constant = kbSize.height
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        btmConstraint.constant = 0.0
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChatVC : UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true;
    }
}

extension ChatVC : UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chatVM.getTotalMsgCount()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let msgCount = chatVM.getTotalMsgCount()
        return msgCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let chatModel = chatVM.getMsgAtIndex(indexPath.row)
        if true == chatModel.isSent {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SenderCell") as! SenderCell
            cell.configureWithChatModal(chatModel)
            cell.setNeedsDisplay()
            cell.layoutIfNeeded()
            return cell
        }
        else {

            let cell = tableView.dequeueReusableCell(withIdentifier: "RecieverCell") as! RecieverCell
            cell.configureWithChatModal(chatModel)
            cell.setNeedsDisplay()
            cell.layoutIfNeeded()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        
        return 52.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}

