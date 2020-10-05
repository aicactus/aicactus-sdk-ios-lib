Pod::Spec.new do |s|
  s.name             = "AicactusSDK"
  s.version          = "1.0.3"
  s.summary          = "The hassle-free way to add analytics to your iOS app with Aicactus"

  s.description      = <<-DESC
                       Analytics for iOS provides a single API that lets you
                       integrate with over 100s of tools.
                       DESC

  s.homepage         = "https://github.com/aicactus/aicactus-sdk-ios-lib"
  s.license          =  { :type => 'Apache-2.0', :file => 'LICENSE' }
  s.author           = { "aicactus" => "phuong@tvpsoft.com" }
  s.platform         = :ios
  s.source           = { :http => 'https://github.com/aicactus/aicactus-sdk-ios-lib/raw/master/AicactusSDK/1.0.3/AicactusSDK.zip'}
  s.social_media_url = 'https://twitter.com/aicactus'

  s.ios.deployment_target = '8.0'

  s.ios.frameworks = 'CoreTelephony'
  s.frameworks = 'Security', 'StoreKit', 'SystemConfiguration', 'UIKit'
  
  s.ios.vendored_frameworks = 'AicactusSDK.framework'
end
