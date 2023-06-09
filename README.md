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

# 메모리 성능 이슈 해결 과정
- 메모리 성능 이슈가 있어 NSCache 용량 조절 및 다운샘플링으로 해결했습니다.
## NSCache
- NSCache를 이용해 이미지를 메모리 캐싱했습니다.
- 처음에는 캐시 용량을 설정하지 않은 상태로 간단하게 성능 테스트를 진행해봤습니다. 서버에 있는 모든 상품을 Task Cancel 없이 훑은 결과, 3.15GB의 메모리를 차지합니다.

<img width="1422" alt="1_NSCache 제한 전_다운샘플링 전_RAM" src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/44050ab8-8f05-4cbf-88f3-1b01b09d68c1">

- 몇 년 전 아이폰 11 프로에서 카메라 앱이 램 1GB 정도를 차지해, 사진을 찍으면 기존에 사용 중이던 앱이 종료되거나 리프레시 되는 이슈가 있었습니다. 
- 홍당무 마켓 프로젝트에서 사용하는 OpenMarketAPI의 총 상품 수는 현재 기준 1336개에 불과합니다. 그런데도 이 정도의 성능이니, 당연히 조치가 필요합니다.
- 참고:
  - 아이폰 11 프로의 램이 4GB, 그리고 현재 아이폰 14 프로의 램이 6GB 입니다.
### 적정량의 totalCostLimit과  countLimit 찾기
- NSCache의 용량 조절이 필요한 것은 자명했습니다. 그런데 NSCache의 용량을 너무 줄이면 캐시를 사용하는 이유가 없어집니다. 적절한 용량이 어느 정도인지 궁금했습니다.
#### 시도 1: 다른 앱의 메모리 점유율을 Instruments로 살펴보기 - 실패
- 자주 사용하는 앱의 메모리 점유율을 벤치마킹 하고 싶어 Instruments로 여러 앱을 시도해봤지만, 아래와 같은 에러가 발생했습니다.
  - 대부분의 경우 자신이 개발 중인 앱으로 검사하기 때문에, 구글링 해봐도 정확한 에러 원인은 찾지 못했습니다. 하지만 Permission 이야기가 나온 것으로 보아 아마 해당 앱의 개발자들만 검사할 수 있는 것으로 보였습니다.
  - 당근마켓
    <img width="974" alt="당근마켓 Instruments로 메모리 점유율 검사 시도" src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/4f57930f-8b1b-4143-ad0c-e681db7efc67">
  - Instagram
   ![Pasted image 20230608210741](https://github.com/minsson/ios-hongdangmu-market/assets/96630194/d8c78139-318a-4adf-a225-d5b473e8f58b)

#### 시도 2: 아이폰의 메모리 사용량을 봐주는 앱을 통해 간접적으로 추측하기
- 직접 측정이 어려워보여 아래처럼 아이폰에 성능모니터 앱을 설치해 메모리 점유율을 측정해봤습니다.
- 왼쪽이 당근마켓을 연 상태이고, 오른쪽이 상
품 목록에서 1분 동안 빠르게 스크롤 다운한 결과입니다.

![471AE22E-4287-4FF6-9837-B4D0E25D0162_1_102_o](https://github.com/minsson/ios-hongdangmu-market/assets/96630194/650f1719-bfc0-4efc-b433-a9c55de27a5e)
![EE0FD2D5-1FC2-4E62-B7E8-E1A504A3BF0E_1_102_o](https://github.com/minsson/ios-hongdangmu-market/assets/96630194/4164b029-4a74-4eba-97d6-7ced15744d21)
- Active Memory가 883 MB에서 985MB로 변했습니다. 
- 하지만 유의미한 차이라고 보기 어려웠습니다. 메모리 사용량은 다양한 조건에 의해 변할 수 있는데, 이런 방식으로 검증하는 것이 신뢰할 수 있는 방법이라고 보기 어려웠습니다.
- 또, 당근마켓이 온디스크 캐싱을 할 수도 있기 때문에 더더욱 신뢰하기 어려웠습니다.
#### 결론
- 현재로서는 제대로 된 기준이 없기에, 위에서 추측한 것처럼 우선은 100MB 정도의 캐시를 사용한다고 추측하고 진행해보기로 했습니다.
-  그런데 100MB라면 얼마나 많은 이미지를 담을 수 있을까요? OpenMarketAPI에서 보내주는 썸네일의 용량을 먼저 살펴볼 필요가 있었습니다.
- 아래와 같이 가져온 이미지의 수를 기록하는 싱글톤 객체를 임시로 구현했습니다.
```swift
final class SizeRecorder {
  static let shared = SizeRecorder()
  var totalImageCount = 0
}
```
- 아래와 같이 이미지를 가져오는 로직에서 사용하고, 결과를 print했습니다.
```swift
SizeRecorder.shared.totalImageCount += 1

print("지금까지 가져온 이미지 Data의 수: \(SizeRecorder.shared.totalImageCount)")
```
- OpenMarketAPI에 있는 모든 상품 수를 불러온 결과입니다.
```plain
지금까지 가져온 이미지의 수: 1336
```
- 1336개의 이미지가 3.15GB를 차지하므로, 평균적으로 이미지 한 개의 용량이 2.41MB라고 볼 수 있습니다.
- 100MB에는 41개의 이미지가 들어갈 수 있습니다.
- 따라서 NSCache의 `countLimit`에는 넉넉히 50을, `totalCostLimit`에는 100MB의 값을 할당했습니다.
- 
```swift
final class ImageCacheManager: ObservableObject {
  
  static let shared = ImageCacheManager()
  private let cache: NSCache<NSString, UIImage> = {
    let cache = NSCache<NSString, UIImage>()
    cache.countLimit = 50
    cache.totalCostLimit = 1024 * 1024 * 100 // 100MB
    return cache
  }()
  
  private init() { }
  
}
```

### totalCostLimit과  countLimit을 적용한 후 메모리 점유율 살펴보기
- 제한을 적용한 후 다시 살펴봤습니다. 
- 캐시가 가득찬 후에는 아래와 같이 평균적으로 150MB - 230MB 사이를 오갔으며, 최대 248.7MB를 기록했습니다.
<img width="1422" alt="2_NSCache 제한 후_다운샘플링 전_RAM" src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/a07f495e-1fc9-447d-8948-d473bc6a1e7a">
- totalCostLimit을 100MB로 설정했음에도 불구하고 그 이상의 메모리를 점유하고 있습니다.
- totalCostLimit과 countLimit 모두 엄격한 제한이 아니기 때문입니다.
  - 근거는 공식문서에서 찾아볼 수 있습니다.
    - [countLimit | Apple Developer Documentation](https://developer.apple.com/documentation/foundation/nscache/1416355-countlimit)
    - [totalCostLimit | Apple Developer Documentation](https://developer.apple.com/documentation/foundation/nscache/1407672-totalcostlimit)
- 재미있게도 두 문서 모두 Discussion의 하단에 같은 글을 넣어놨습니다.
> 이것은 엄격한 제한이 아닙니다. 캐시가 제한을 초과하면 캐시의 구현 세부 사항에 따라 캐시의 개체가 즉시 또는 나중에 제거되거나 전혀 제거되지 않을 수 있습니다.
## 다운샘플링
- 캐싱 용량을 제한하여 성능을 개선하면서도, 최대한 많은 이미지를 캐싱하여 UX를 개선해야 하는 딜레마가 있습니다.
- totalCostLimit을 100MB로 제한하면서도 최대한 많은 이미지를 캐싱하기 위해 다운샘플링을 진행했습니다.
### UIImage, UIGraphicsImageRenderer를 사용하는 방법
- 이미 프로젝트 내에서 서버에 이미지를 업로드하기 전 이미지 용량을 줄이기 위해 사용하던 방법입니다.
- 스택 오버플로우, 블로그 등에 많이 보이던 코드를 조금 손봐서 사용했습니다.
- 아래는 ImageDownsamplingManager 파일에 구현한 코드입니다.

```swift
fileprivate extension UIImage {
  
  func resized(withNewWidth newWidth: CGFloat) -> UIImage {
    let scale = newWidth / self.size.width
    let newHeight = self.size.height * scale
    
    let size = CGSize(width: newWidth, height: newHeight)
    let render = UIGraphicsImageRenderer(size: size)
    let renderImage = render.image { context in
      self.draw(in: CGRect(origin: .zero, size: size))
    }
    
    return renderImage
  }
  
}
```

- 기존의 `countLimit`은 50, `totalCostLimit`은 100MB인 상태를 유지하고 측정한 결과입니다. 

<img width="1422" alt="3_NSCache 제한 후_UIImage로 다운샘플링 후_RAM" src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/03e1a6d8-8fce-4379-985f-62d292a2e8b6">


- 다운샘플링 전과 용량을 비교해야 하므로 NSCache의 countLimit과 totalCostLimit은 제거하고 다시 측정했습니다.
- 다운샘플링 전 3.15GB였던 메모리 점유용량이 1.49GB가 되어, 약 52.7% 개선되었습니다.

<img width="1422" alt="3_1_NSCache 제한 풀고_UIImage로 다운샘플링_RAM" src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/6bb15ce0-528a-4bbd-ab0a-e42d59d5b5b2">
- 이미지 하나는 1.14MB의 메모리를 차지하는 것으로 추정할 수 있습니다.
- 즉, 100MB 용량의 캐시에 약 87개의 이미지가 들어간다고 볼 수 있습니다. 41개에서 87개가 되었습니다.

### ImageIO
- 위 코드를 더 개선할 방법을 찾던 중 [iOS Memory Deep Dive - WWDC18 - Videos - Apple Developer](https://developer.apple.com/videos/play/wwdc2018/416/)을 보게 되었습니다.
- 아래 이미지들은 해당 세션의 발표자료를 캡처한 것입니다. 중간의 Images 파트에서 제가 사용했던 방법이 비효율적임을 알게 되었습니다.
<img width="1483" alt="Pasted image 20230609013944" src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/6ca47cc5-2a9c-4074-b39e-28fcf407035c">

- 아래는 제가 기존에 선택했던 방법입니다. 비효율적이라는 것을 알게 되었습니다.
<img width="1386" alt="Pasted image 20230609014031" src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/c7f82a2d-2aef-474b-841e-a6b67c23c448">

- 아래는 ImageIO를 활용해 더 효율적으로 다운샘플링 하는 방법입니다.
<img width="1387" alt="Pasted image 20230609014103" src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/d7fc2524-ca64-418e-91f5-f718086d587b">




