# COVI-iOS-SDK 
[![Version](https://img.shields.io/cocoapods/v/COVI-iOS-SDK.svg?style=flat)](https://cocoapods.org/pods/COVI-iOS-SDK)
[![SwiftPM](https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat)](https://swift.org/package-manager/)
[![Swift Version](https://img.shields.io/badge/Swift-5.0+-magenta.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-12+-blue.svg)](https://developer.apple.com/ios/)

## SDK 적용 가이드
[링크](https://github.com/covigroup/covi-ios-sdk-guide/wiki)

## 예제 프로젝트
+ COVI-iOS-SDK 리포지토리를 로컬로 복제합니다.

+ `COVI-iOS-SDK/Example`에서 `pod install`을 실행합니다.

+ `COVI-iOS-SDK.xcworkspace` 프로젝트를 실행합니다.

## 에러 핸들링
- `dlyd missing symbol called`에러가 발생한다면, Podfile에서 COVI-iOS-SDK 관련 타겟들의 config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION']을 'YES'로 설정해주세요.

```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
  end
end
``
