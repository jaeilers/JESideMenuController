Pod::Spec.new do |spec|

  spec.name         = "JESideMenuController"
  spec.version      = "2.0.0"
  spec.summary      = "A simple side menu that supports different styles (slide-out, slide-in, etc) and can be positioned at the left or the right side."
  spec.homepage     = "https://github.com/jaeilers/JESideMenuController"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author       = "Jasmin Eilers"
  spec.platform     = :ios, "15.0"
  spec.source       = { :git => "https://github.com/jaeilers/JESideMenuController.git", :tag => "#{spec.version}" }

  spec.source_files  = "Sources", "Sources/**/*.{swift}"
  spec.swift_version = "5.10"

end
