//
//  LoginViewController.swift
//  Analytics Example

import UIKit

class LoginViewController: StepsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Login Example"
        descriptionString = "Login with details using identify"
        codeString = """
// Start by identifying the user
if let analytics = AicactusSDK.shared()
AicactusSDK.shared().identify("1234",
                            traits: ["email": "jack@aicactus.ai",
                                     "phone": "555-444-3333"])
"""
    }
}
