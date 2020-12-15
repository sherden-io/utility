#
# Be sure to run `pod lib lint Utility.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Utility'
  s.version          = '0.2'
  s.summary          = 'Utility Library'
  s.description      = 'An Utility library with common useful classes and extensions.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.homepage         = 'https://sherden.io'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'piegandolfi@gmail.com' => 'info@sherden.io' }
  s.source           = { :git => 'https://github.com/pietrogandolfi/utility.git', :tag => s.version.to_s }

  s.ios.deployment_target = '14.0'
  s.swift_version = '5.0'

  s.source_files = 'Utility/Sources/**/*.{h,m,swift}'
  
  # s.resource_bundles = {
  #   'Utility' => ['Utility/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
