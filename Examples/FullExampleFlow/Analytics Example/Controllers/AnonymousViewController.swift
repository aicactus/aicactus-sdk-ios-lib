//
//  AnonymousViewController.swift
//  AicactusSDK Example

import UIKit
import AicactusSDK
import PopupWindow

class AnonymousViewController: StepsViewController {
    
    let anonymousUserID = "70e4ab26-3c4d-42c9-aed1-2c186738a97d"
    
    private var continueButton: UIButton!
    
    enum Const {
            static let popupDuration: TimeInterval = 0.3
            static let transformDuration: TimeInterval = 0.4
            static let topPopupOption = PopupOption(shapeType: .rounded(cornerSize: 8), viewType: .card, direction: .top, margin: 8)
            static let bottomPopupOption = PopupOption(shapeType: .rounded(cornerSize: 8), viewType: .card, direction: .bottom, margin: 8)
        }
    
    private var popupItem: PopupItem?

        private let topPopupItem = PopupItem(view: DemoPopupView.view(), height: DemoPopupView.Const.height, maxWidth: 500,  popupOption: Const.topPopupOption)
        private let bottomPopupItem = PopupItem(view: DemoPopupView.view(), height: DemoPopupView.Const.height, maxWidth: 500, popupOption: Const.bottomPopupOption)

      

    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupItem = bottomPopupItem
        configurePopupItem(popupItem!)

        descriptionString = "Login with details using identify"
        codeString = """
// Start with the analytics singleton
let analytics = AicactusSDK.shared()

// identify screen load (sends anonymous id)
analytics.screen("Home")

// identify with anonymous user
analytics.identify(nil, traits: ["subscription": "inactive"])

// track CTA tap (sends anonymous id)
analytics.track("CTA Tapped", properties: ["plan": "premium"])
"""
        
        // Add the button
        let trackButton = UIButton.SegmentButton("Track", target: self, action: #selector(trackUser(_:)))
        continueButton = UIButton.SegmentButton("Continue", target: self, action: #selector(continueToNext(_:)))
        continueButton.isEnabled = false
    
        propertyViews = [trackButton, UIView.separator(), continueButton, UIView.separator()]
        
        // Fire off the beginning analytics
        startAicactusSDK()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        continueButton.isEnabled = false
    }
    
    private func startAicactusSDK() {
        let analytics = AicactusSDK.shared()
        
        // identify screen load
        analytics.screen("Home")
        
        // identify anonymous user
        analytics.identify(nil, traits: ["subscription": "inactive"])
    }
    
    @objc
    private func trackUser(_ sender: Any) {
        let analytics = AicactusSDK.shared()
        // track CTA tap
        analytics.track("CTA Tapped", properties: ["plan": "premium"])
        
        continueButton.isEnabled = true
    }
    
    @objc private func continueToNext(_ sender: Any) {
        let signup = SignupViewController(nibName: nil, bundle: nil)
        navigationController?.pushViewController(signup, animated: true)
    }
}
