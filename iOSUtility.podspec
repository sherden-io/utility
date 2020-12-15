Pod::Spec.new do |s|
  s.name             = 'iOSUtility'
  s.version          = '0.0.1'
  s.summary          = 'Utility Library'
  s.description      = 'An Utility library with common useful classes and extensions.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.homepage         = 'https://sherden.io'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pietro Gandolfi' => 'info@sherden.io' }
  s.source           = { :git => 'https://github.com/sherden-io/utility.git', :tag => s.version.to_s }

  s.ios.deployment_target = '14.0'
  s.swift_version = '5.0'

  s.source_files = 'iOSUtility/Sources/**/*.{h,m,swift}'
  
  # s.resource_bundles = {
  #   'Utility' => ['Utility/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
