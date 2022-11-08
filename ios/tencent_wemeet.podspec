#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint tencent_wemeet.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'tencent_wemeet'
  s.version          = '3.12.4'
  s.summary          = 'A new Flutter project.'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*.{h,m,swift}'
  s.public_header_files = 'Classes/**/*.{h}'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'
  s.vendored_frameworks = 'Frameworks/TencentMeetingSDK/{*}.framework'
  #//'Frameworks/TencentMeetingBroadcastExtension.framework',
  s.ios.vendored_frameworks = 'CoreAudioTypes.framework', "Foundation.framework"

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386 x86_64' }
  s.swift_version = '5.0'
end
