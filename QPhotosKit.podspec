#
#  Be sure to run `pod spec lint QPhotosKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

s.name         = "QPhotosKit"
s.version      = "0.2"
s.summary      = "you can use phots by QPhotosKit"
s.description      = <<-DESC
TODO: Add long description of the pod here.
DESC
s.homepage     = "https://github.com/Quinn0809/QPhotosKit"
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author             = { "quinn0809" => "quinn_f@126.com" }
s.source       = { :git => "https://github.com/Quinn0809/QPhotosKit.git", :tag => s.version.to_s }

s.ios.deployment_target = '10.0'
s.swift_version         = '4.0'
s.requires_arc          = true
s.static_framework      = true
s.source_files          = ["QPhotosKit",'QPhotosKit/**/*.{swift,h}']
s.pod_target_xcconfig = {
'OTHER_SWIFT_FLAGS'           => '-DGLES',
}

end
