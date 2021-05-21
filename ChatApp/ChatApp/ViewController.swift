//
//  ViewController.swift
//  ChatApp
//
//  Created by Bigbasket on 19/05/21.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func didTapChat(_ sender: Any) {
    
        let storyBoard = UIStoryboard.init(name: "Chat", bundle: nil)
        let chatNavVC = storyBoard.instantiateViewController(identifier: Constants.UIRelated.chatNavBarVCSBID) as! UINavigationController;
        chatNavVC.modalPresentationStyle = .fullScreen
        self.present(chatNavVC, animated: true) {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

