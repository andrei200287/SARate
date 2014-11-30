Pod::Spec.new do |s|
  s.name         = "SARate"
  s.version      = "1.0.1"
  s.summary      = "SARate - SARate is a library to get positive app reviews on the AppStore."
  s.homepage     = "https://github.com/andrei200287/SARate"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Andrei Solovjev" => "andrei@solovjev.com" }
  s.platform     = :ios, "5.0"
  s.requires_arc = TRUE
  s.source       = { :git => "https://github.com/andrei200287/SARate.git", :tag => s.version.to_s }
  s.source_files = "SARate/*.{h,m}"
  s.exclude_files = "ViewController.h"
  s.resources = "SARate/*.png"
  s.dependency "iRate", "~> 1.7.5"
  s.frameworks = "UIKit", "MessageUI", "QuartzCore"
end
