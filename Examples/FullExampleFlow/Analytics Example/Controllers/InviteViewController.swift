//
//  InviteViewController.swift
//  Analytics Example

import UIKit
import AicactusSDK

class InviteViewController: StepsViewController {
    
    private var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionString = "Login with details using identify"
        codeString = """
// Start with the analytics singleton
let analytics = AicactusSDK.shared()

// Screen
analytics.screen("Invite")

// Invite user
analytics.track("Invite Sent", properties: ["first": "Jane", "last": "Doe", "email": "jane@abc.com"])
"""
        
        // Add the button
        let inviteButton = UIButton.SegmentButton("Invite Yser", target: self, action: #selector(createUser(_:)))
        continueButton = UIButton.SegmentButton("Continue", target: self, action: #selector(continueToNext(_:)))
        continueButton.isEnabled = false
    
        propertyViews = [inviteButton, UIView.separator(), continueButton, UIView.separator()]
        
        // Fire off the beginning analytics
        startAnalytics()
    }
    
    private
    func startAnalytics() {
        let analytics = AicactusSDK.shared()
        
        // identify screen load
        analytics.screen("Invite")
    }
    
    @objc
    func createUser(_ sender: Any) {
        let analytics = AicactusSDK.shared()
        // track CTA tap
        analytics.track("Invite Sent", properties: ["first": "Jane", "last": "Doe", "email": "jane@abc.com"])
        continueButton.isEnabled = true
    }
    
    @objc
    func continueToNext(_ sender: Any) {
        let signoutVC = SignoutViewController(nibName: nil, bundle: nil)
        navigationController?.pushViewController(signoutVC, animated: true)
    }
}
