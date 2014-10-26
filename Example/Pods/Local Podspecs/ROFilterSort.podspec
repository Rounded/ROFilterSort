#
# Be sure to run `pod lib lint ROFilterSort.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ROFilterSort"
  s.version          = "1.0.0"
  s.summary          = "ROFilterSort includes a filter bar and popup view to sort / filter various options on the screen."
  s.description      = <<-DESC
                       ROFilterSort is an easy-to-use framework that allows users to filter a given screen via a segment control and filter buttons. The ROFilterBar shows the currently selected filters, and launching the ROFilterSortView displays the different filters that can be applied. 
                       DESC
  s.homepage         = "https://github.com/Rounded/ROFilterSort"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Brian Weinreich" => "bw@roundedco.com" }
  s.source           = { :git => "https://github.com/Rounded/ROFilterSort.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/roundedco

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'ROFilterSort' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end