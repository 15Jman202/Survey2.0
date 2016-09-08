//
//  SurveyViewController.swift
//  Survey2.0
//
//  Created by Justin Carver on 9/8/16.
//  Copyright © 2016 Justin Carver. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController {

    @IBOutlet weak var NameTextLabel: UITextField!
    @IBOutlet weak var ResponseLable: UITextField!
    
    @IBAction func SubmitButtonTapped(sender: AnyObject) {
        guard let name = NameTextLabel.text, text = ResponseLable.text where !name.isEmpty && !text.isEmpty else { return }
        ResponseController.putResponse(name, text: text) { (success) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.NameTextLabel.text = ""
                self.ResponseLable.text = ""
                self.NameTextLabel.resignFirstResponder()
                self.ResponseLable.resignFirstResponder()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
