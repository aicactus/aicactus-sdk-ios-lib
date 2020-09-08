//
//  SigninViewController.swift
//  Analytics Example


import UIKit
import AicactusSDK

class SigninViewController: StepsViewController {
    
    private var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionString = "Login with details using identify"
        codeString = """
// Start with the analytics singleton
let analytics = AicactusSDK.shared()

// Screen
analytics.screen("Dashboard")

// Signed in
analytics.track("Signed In", properties: ["username": "pgibbons"])
"""
        
        // Add the button
        let signinButton = UIButton.SegmentButton("Sign In", target: self, action: #selector(signin(_:)))
        continueButton = UIButton.SegmentButton("Continue", target: self, action: #selector(continueToNext(_:)))
        continueButton.isEnabled = false
    
        propertyViews = [signinButton, UIView.separator(), continueButton, UIView.separator()]
        
        // Fire off the beginning analytics
        startAnalytics()
    }
    
    private
    func startAnalytics() {
        let analytics = AicactusSDK.shared()
        
        // identify screen load
        analytics.screen("Dashboard")
    }
    
    @objc
    func signin(_ sender: Any) {
        let analytics = AicactusSDK.shared()
        // track CTA tap
        analytics.track("Signed In", properties: ["username": "pgibbons"])
        continueButton.isEnabled = true
    }
    
    @objc
    func continueToNext(_ sender: Any) {
        let trailEndVC = TrialEndViewController(nibName: nil, bundle: nil)
        navigationController?.pushViewController(trailEndVC, animated: true)
    }
}
