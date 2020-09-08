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
if let analytics = Analytics.shared()
Analytics.shared().identify("1234",
                            traits: ["email": "jack@segment.com",
                                     "phone": "555-444-3333"])
"""
    }
}
