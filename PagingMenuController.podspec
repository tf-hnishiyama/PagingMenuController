#
# Be sure to run `pod lib lint PagingMenuController.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "PagingMenuController"
  s.version          = "2.2.0"
  s.summary          = "A paging view with customizable menu"
  s.homepage         = "https://github.com/kitasuke/PagingMenuController"
  s.license          = 'MIT'
  s.author           = { "kitasuke" => "yusuke2759@gmail.com" }
  s.source           = { :git => "https://github.com/kitasuke/PagingMenuController.git", :tag => s.version.to_s }

  s.platform     = :ios, '12.0'
  s.requires_arc = true
  s.swift_version = '5.0'

  s.source_files = 'Sources/PagingMenuController/**/*'
end
