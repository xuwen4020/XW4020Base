Pod::Spec.new do |spec|

  spec.name         = "XW4020Base"
  spec.version      = "1.1.3"
  spec.summary      = "Test XWBase"

  spec.homepage     = "https://github.com/xuwen4020/XW4020Base.git"    
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "xuwen4020" => "996592197@qq.com" }

  spec.platform     = :ios
  spec.ios.deployment_target = "9.0"

  spec.source       = { :git => "https://github.com/xuwen4020/XW4020Base.git", :tag => "#{spec.version}" }
  spec.source_files  = "XW4020Base/**/*.{h,m}"
  #spec.resource  = "Product/XWBaseBundle.bundle"
  #spec.ios.vendored_frameworks = 'Product/XWBase.framework'

  spec.frameworks = 'UIKit','Foundation'
  spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "Masonry"

end
