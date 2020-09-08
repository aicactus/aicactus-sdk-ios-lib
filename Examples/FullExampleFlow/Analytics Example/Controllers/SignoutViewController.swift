//
//  SignoutViewController.swift
//  Analytics Example

import UIKit
import AicactusSDK

class SignoutViewController: StepsViewController {
    
    private var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionString = "Login with details using identify"
        codeString = """
// Start with the analytics singleton
let analytics = Analytics.shared()

// Screen
analytics.screen("Signout")

// Signout user
analytics.track("Signed Out", properties: ["username": "pgibbons"])
"""
        
        // Add the button
        let signoutButton = UIButton.SegmentButton("Signout", target: self, action: #selector(signout(_:)))
        continueButton = UIButton.SegmentButton("Continue", target: self, action: #selector(continueToNext(_:)))
        continueButton.isEnabled = false
    
        propertyViews = [signoutButton, UIView.separator(), continueButton, UIView.separator()]
        
        // Fire off the beginning analytics
        startAnalytics()
    }
    
    private
    func startAnalytics() {
        let analytics = AicactusSDK.shared()
        
        // identify screen load
        analytics.screen("Signout")
    }
    
    @objc
    func signout(_ sender: Any) {
        let analytics = AicactusSDK.shared()
        // track CTA tap
        analytics.track("Signed Out", properties: ["username": "pgibbons"])
        continueButton.isEnabled = true
    }
    
    @objc
    func continueToNext(_ sender: Any) {
        let signinVC = SigninViewController(nibName: nil, bundle: nil)
        navigationController?.pushViewController(signinVC, animated: true)
    }
}
