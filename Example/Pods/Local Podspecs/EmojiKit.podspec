#
# Be sure to run `pod lib lint EmojiKit.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "EmojiKit"
  s.version          = "0.1.0"
  s.summary          = "Use custom emoji artwork in any UITextView."
  s.description      = <<-DESC
                       EmojiKit allows you to use custom emoji artwork in your app with any UITextView.  Simply pass in an array of image names, and you're good to go.  It's extensions allow you to export the attributed string into a string usable with a web service, or share an image of teh text and emoji.
                       DESC
  s.homepage         = "https://github.com/<GITHUB_USERNAME>/EmojiKit"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Rudd Fawcett" => "rudd.fawcett@gmail.com" }
  s.source           = { :git => "https://github.com/EmojiKit/EmojiKit.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ruddfawcett'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'EmojiKit' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
