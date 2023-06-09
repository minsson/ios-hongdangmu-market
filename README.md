
# 🥕 홍당무 마켓
> 당근마켓 스타일의 중고거래 앱 토이 프로젝트입니다.

<br>

# ✨ 핵심 키워드
- SwiftUI (iOS 15.0) + MVVM
- 프로토콜 지향 네트워크 레이어
- NSCache + 이미지 다운샘플링
- Swift Concurrency (async-await)
- Unit Test
- Pagination


<br>

# SwiftUI + MVVM
![Pasted image 20230607224445](https://github.com/minsson/ios-hongdangmu-market/assets/96630194/7935498d-8a44-4290-9f5e-33824f5b0287)
- SwiftUI에 일반적으로 가장 적합한 아키텍처가 무엇인지는 아직도 논의가 진행되고 있습니다.
  - 특히 SwiftUI 초기 당연스레 도입됐던 MVVM 구조에 대한 의문이 많이 제기되고 있습니다.
- 다만 저의 경우 SwiftUI + MVVM을 직접 경험하고 장단점을 생각해보고 싶어 MVVM 구조를 채택했습니다.
- 또한 현업에서는 여전히 MVVM 구조가 많이 쓰인다는 점도 고려했습니다.

<br>


# 📡 네트워크 레이어 구조 (클래스 다이어그램)

![Pasted image 20230607221131](https://github.com/minsson/ios-hongdangmu-market/assets/96630194/1804e04e-36d8-419e-890c-958d63f27dcb)

# 📱 시연 영상

|상품 목록 화면 | 상품 상세 조회 화면|
|:-:|:-:|
|<img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/d5199c25-b803-4cd5-8d55-f593153dce2b" width="300">|<img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/928a2814-f140-4547-b48f-52b49939adf8" width="300">|
|- 버벅임 없는 무한 스크롤<br>- 이미지 캐싱 적용<br> - 스크롤 상단에서 Swipe로 Refresh|- Sticky Header 구현<br>- TabView를 활용해 이미지 Carousel 구현<br>- Custom Navigation Bar 구현|


|상품 등록 작성 화면| 자동으로 등록한 상품의 조회 화면으로 이동 |
|:-:|:-:|
|<img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/5555a703-116d-4d30-9793-29d6915a1c37" width="300">|<img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/4fcedecf-065b-46ae-874d-d04ca0ac15d4" width="300">|
|- 상품 사진 선택<br>- 선택한 사진 삭제 <br>- 사진은 최대 5개까지 선택 가능<br> - 숫자 입력시 세 자리 단위로 쉼표 자동 입력<br>- 키보드 내리기|- 완료 버튼 탭하면 상품 목록으로 이동<br>-방금 등록한 상품의 조회 화면으로 자동 이동<br>- 뒤로 이동하면 상품 목록에 해당 상품 포함|

