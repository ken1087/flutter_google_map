# flutter_google_map

구글 맵 설정 방법 기재
- [참고 자료](https://codelabs.developers.google.com/codelabs/google-maps-in-flutter?hl=ko#0)

## IOS 설정 방법
AppDelegate.swift
- import GoogleMaps
- GMSServices.provideAPIKey("key")
상기의 코드 추가

Podfile
- platform :ios, '14.0'
상기의 주석 해제

xcode 설정
- ios 버전을 14로 설정 (Podfile의 platform: ios가 14이기 때문에)