Pod::Spec.new do |s|
  s.name = 'COVI-iOS-SDK'
  s.version = '1.2.2'
  s.author = 'COVI'
  s.summary = 'SDK for embedding a CoviPlayer in your project'
  s.description = <<-DESC
  SDK for embedding a CoviPlayer in your project that meets VAST specifications and features viewability checks
                       DESC
  s.homepage = 'https://www.covi.co.kr/'
  s.license = { :type => 'Exclusive', :file => 'LICENSE' }
  s.ios.deployment_target = '12.0'
  s.source = { :git => 'https://github.com/covigroup/COVI-iOS-SDK.git', :tag => s.version.to_s }
  s.swift_versions = ['5']
  s.readme = 'https://raw.githubusercontent.com/covigroup/COVI-iOS-SDK/#{s.version.to_s}/README.md'
  s.vendored_frameworks = 'covisdk.xcframework'
end
