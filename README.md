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

# 🏗️ 구조

## SwiftUI + MVVM

<br>
<img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/7935498d-8a44-4290-9f5e-33824f5b0287" width="80%">
<br>
<br>

- SwiftUI에 일반적으로 가장 적합한 아키텍처가 무엇인지는 아직도 논의가 진행되고 있습니다.
  - 특히 SwiftUI 초기 당연스레 도입됐던 MVVM 구조에 대한 의문이 많이 제기되고 있습니다.
- 다만 저의 경우 SwiftUI + MVVM을 직접 경험하고 장단점을 생각해보고 싶어 MVVM 구조를 채택했습니다.
- 또한 현업에서는 여전히 MVVM 구조가 많이 쓰인다는 점도 고려했습니다.

<br>

## 📡 네트워크 레이어 구조 (클래스 다이어그램)

<br>

![Pasted image 20230607221131](https://github.com/minsson/ios-hongdangmu-market/assets/96630194/1804e04e-36d8-419e-890c-958d63f27dcb)

### API Endpoint 정의
- 여러 API endpoint를 enum과 struct를 통해 정의하였습니다. 유연성과 확장성을 높이고 의존성은 낮추기 위함입니다. 각 API endpoint 관련 요청에 필요한 파라미터 및 경로는 구조체 내에 있습니다. 이는 URLRequest를 생성하고 실행하는 데 사용됩니다.

### 프로토콜 지향 네트워크 레이어
  - 프로토콜 지향 프로그래밍을 사용해 API 요청의 각 종류(GET, POST, PATCH, DELETE)를 나타내는 프로토콜을 정의했습니다. 이를 통해 API 요청 유형에 따라 공통된 작업을 캡슐화하고 코드의 재사용성을 높였습니다.
        
### API 서비스 계층
  - API 요청을 처리하는 OpenMarketAPIService라는 이름의 서비스 계층을 정의하였습니다. 이 객체에서는 API의 extension을 통해 Netsted Struct로 정의된 각 구조체를 일종의 UseCase처럼 활용해, 클라이언트 코드에서 필요한 타입으로 반환해줍니다.

<br>

# 🧑‍🏫 시연 영상

## 📱 상품 목록 화면

| 무한 스크롤 | 이미지 캐싱 | 당겨서 Refresh |
| :------: | :--------: | :-------: |
| <img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/7fc1b2d3-f54c-440e-896f-3b45030c0d5e" height="100%"> | <img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/91cf995d-0214-4e6e-a9c4-f9c5da206249" height="100%"> | <img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/2af713d2-84ea-4b61-88d7-1cbab9af05ea" height="100%"> |

## 📱 상품 상세 조회 화면

| 상품 이미지 Carousel | Sticky Header | 상품공유 Activity Sheet |
| :--------------: | :------------: | :-------------------: |
| <img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/66fb5b97-cc00-451f-9a5e-e41001a3dcb2" height="100%"> | <img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/47e9bb80-dc2a-42f8-8200-4974a8ab3391" height="100%"> | <img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/269c13db-94f6-4f37-b2d4-fb60fceed49d" height="100%"> |

## 📱 상품 등록 화면
| 이미지 선택(최대 5장) 및 삭제 | 불러온 이미지 삭제 | 등록한 상품으로 자동 이동 |
| :---------------------: | :-----------: | :-----------------: |
| <img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/44dafce8-c2ae-40f9-8bb4-56d0436e49c1" height="100%"> | <img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/b88963aa-3307-459c-9317-d5d49f8d99b4" height="100%"> | <img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/33d9785e-8087-4bda-bd9d-a48a6d3e3b65" height="100%"> |

## 📱 상품 수정 화면 / 상품 삭제 화면
| 자신이 올린 상품만 수정 및 삭제 가능 | 자신의 상품 수정 | 자신의 상품 삭제 및 상품 목록으로 자동 이동 |
| :---------------------: | :-----------: | :-----------------: |
| <img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/c2c20312-1884-4517-99bc-8fb78f4e287f" height="100%"> | <img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/ea7dc173-e86c-4696-8b0b-7e6b89a87201" height="100%"> | <img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/42df6c89-b69a-4cdf-8800-c00df7c4a3a8" height="100%"> |

## 📱 상품 검색 화면
| 특정 키워드로 검색 | 검색어 자동완성<br>(API 미제공 -> Mock 데이터 네트워킹) | 최근 검색어<br>(탭하여 검색 결과 보기 / 기록 개별 및 전체 삭제)  |
| :---------------------: | :-----------: | :-----------------: |
| <img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/f5ea312c-240e-47db-9714-6737ed9cc4b6" height="100%"> | <img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/ea7dc173-e86c-4696-8b0b-7e6b89a87201" height="100%"> | <img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/3dd2ab6b-92bd-4856-90b9-9377e088f2cb" height="100%"> |

## 📱 나의 홍당무 (MyPage) -> 나의 판매내역
| 나의 판매내역 화면 진입 | 판매중, 거래완료 탭 간 전환 | 글쓰기 화면 진입 |
| :---------------------: | :-----------: | :-----------------: |
| <img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/b7273fba-7325-4932-9494-cf07f8575d0b" height="100%"> | <img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/460eb02f-9442-4d36-bcd0-28bf2267c509" height="100%"> | <img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/0c659b0e-06ed-4648-af67-be80792219ea" height="100%"> |


# 메모리 성능 이슈 해결 과정
## 선 결론
- 메모리 성능 이슈가 있어 NSCache 용량 조절 및 다운샘플링으로 해결했습니다.
- 특히 이미지 다운 샘플링을 통해 성능을 비약적으로 상승시킬 수 있었습니다.

|                                     |   다운샘플링 전   |   UIImage로 다운샘플링   |   CGImage로 다운 샘플링   |
|:-----------------------------------:|:---------------:|:--------------------:|:---------------------:|
|   총 메모리캐시 사용량 (이미지 1336장)   | 3,225MB(3.15GB) | 1,526MB (1.49GB) |    129MB (0.12GB)     |
|     이미지 한 장당 평균 메모리 사용량     |     2.41MB     |      1.14MB      |         0.1MB         |
| 100MB의 메모리 캐시에 넣을 수 있는 이미지 수 |      41장       |        87장       |        1,034장        |
|         다운샘플링 전 대비 개선율         |        -        |       112%       |         2,422%        |

## 문제 해결 과정
## NSCache
- NSCache를 이용해 이미지를 메모리 캐싱했습니다.
- 처음에는 캐시 용량을 설정하지 않은 상태로 간단하게 성능 테스트를 진행해봤습니다. 서버에 있는 모든 상품을 Task Cancel 없이 훑은 결과, 3.15GB의 메모리를 차지합니다.

<img width="100%" alt="1_NSCache 제한 전_다운샘플링 전_RAM" src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/44050ab8-8f05-4cbf-88f3-1b01b09d68c1">

- 몇 년 전 아이폰 11 프로에서 카메라 앱이 램 1GB 정도를 차지해, 사진을 찍으면 기존에 사용 중이던 앱이 종료되거나 리프레시 되는 이슈가 있었습니다. 
- 홍당무 마켓 프로젝트에서 사용하는 OpenMarketAPI의 총 상품 수는 현재 기준 1336개에 불과합니다. 그런데도 이 정도의 성능이니, 당연히 조치가 필요합니다.
- 참고:
  - 아이폰 11 프로의 램이 4GB, 그리고 현재 아이폰 14 프로의 램이 6GB 입니다.
### 적정량의 totalCostLimit과 countLimit 찾기
- NSCache의 용량 조절이 필요한 것은 자명했습니다. 그런데 NSCache의 용량을 너무 줄이면 캐시를 사용하는 이유가 없어집니다. 적절한 용량이 어느 정도인지 궁금했습니다.
#### 시도 1: 다른 앱의 메모리 사용량을 Instruments로 살펴보기 - 실패
- 자주 사용하는 앱의 메모리 사용량을 벤치마킹 하고 싶어 Instruments로 여러 앱을 시도해봤지만, 아래와 같은 에러가 발생했습니다.
  - 대부분의 경우 자신이 개발 중인 앱으로 검사하기 때문에, 구글링 해봐도 정확한 에러 원인은 찾지 못했습니다. 하지만 Permission 이야기가 나온 것으로 보아 아마 해당 앱의 개발자들만 검사할 수 있는 것으로 보였습니다.
  - 당근마켓
    <img width="100%" alt="당근마켓 Instruments로 메모리 사용량 검사 시도" src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/4f57930f-8b1b-4143-ad0c-e681db7efc67">
  - Instagram
   ![Pasted image 20230608210741](https://github.com/minsson/ios-hongdangmu-market/assets/96630194/d8c78139-318a-4adf-a225-d5b473e8f58b)

#### 시도 2: 아이폰의 메모리 사용량을 봐주는 앱을 통해 간접적으로 추측하기
- 직접 측정이 어려워보여 아래처럼 아이폰에 성능모니터 앱을 설치해 메모리 사용량을 측정해봤습니다.
- 아래는 당근마켓 앱을 기준으로 실험해본 결과입니다.

| 상품 목록에 진입했을 때 | 1분 동안 빠르게 스크롤 다운했을 때 |
| :-: | :-: |
| <img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/650f1719-bfc0-4efc-b433-a9c55de27a5e" width="250"> | <img src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/4164b029-4a74-4eba-97d6-7ced15744d21" width="250"> |

- Active Memory가 883 MB에서 985MB로 변했습니다. 
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

### totalCostLimit과 countLimit을 적용한 후 메모리 사용량 살펴보기

- 제한을 적용한 후 다시 살펴봤습니다. 
- 캐시가 가득찬 후에는 아래와 같이 평균적으로 150MB - 230MB 사이를 오갔으며, 최대 248.7MB를 기록했습니다.

<img width="100%" alt="2_NSCache 제한 후_다운샘플링 전_RAM" src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/a07f495e-1fc9-447d-8948-d473bc6a1e7a">

- totalCostLimit을 100MB로 설정했음에도 불구하고 그 이상의 메모리를 사용하고 있습니다.
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

<img width="100%" alt="3_NSCache 제한 후_UIImage로 다운샘플링 후_RAM" src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/03e1a6d8-8fce-4379-985f-62d292a2e8b6">

- 다운샘플링 전과 용량을 비교해야 하므로 NSCache의 countLimit과 totalCostLimit은 제거하고 다시 측정했습니다.
- 다운샘플링 전 3.15GB였던 메모리 사용량이 1.49GB가 되어, 약 52.7% 개선되었습니다.

<img width="100%" alt="3_1_NSCache 제한 풀고_UIImage로 다운샘플링_RAM" src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/6bb15ce0-528a-4bbd-ab0a-e42d59d5b5b2">

- 이미지 하나는 1.14MB의 메모리를 차지하는 것으로 추정할 수 있습니다.
- 즉, 100MB 용량의 캐시에 약 87개의 이미지가 들어간다고 볼 수 있습니다. 41개에서 87개가 되었습니다.

### ImageIO

- 위 코드를 더 개선할 방법을 찾던 중 [iOS Memory Deep Dive - WWDC18 - Videos - Apple Developer](https://developer.apple.com/videos/play/wwdc2018/416/)을 보게 되었습니다.
- 아래 이미지들은 해당 세션의 발표자료를 캡처한 것입니다. 중간의 Images 파트에서 제가 사용했던 방법이 비효율적임을 알게 되었습니다.
<img width="70%" alt="Pasted image 20230609013944" src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/6ca47cc5-2a9c-4074-b39e-28fcf407035c">

- 아래는 제가 기존에 선택했던 방법입니다. 비효율적이라는 것을 알게 되었습니다.
<img width="70%" alt="Pasted image 20230609014031" src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/c7f82a2d-2aef-474b-841e-a6b67c23c448">

- 아래는 ImageIO를 활용해 더 효율적으로 다운샘플링 하는 방법입니다.
<img width="70%" alt="Pasted image 20230609014103" src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/d7fc2524-ca64-418e-91f5-f718086d587b">

- 기존 UIImage로 다운샘플링했던 코드를 아래의 코드로 대체했습니다.
```swift
struct ImageDownsamplingManager {
  func downsample(imageData: Data, for size: CGSize, scale: CGFloat) -> CGImage? {
    let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
    guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, imageSourceOptions) else {
      return nil
    }
    
    let maxDimensionInPixels = max(size.width, size.height) * scale
    let downsampleOptions = downsampleOptions(with: maxDimensionInPixels)

    guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
      return nil
    }

    return downsampledImage
  }
}

private extension {
  func downsampleOptions(with maxDimensionInPixels: CGFloat) -> CFDictionary {
    let downsampleOptions = [
      kCGImageSourceCreateThumbnailFromImageAlways: true,
      kCGImageSourceShouldCacheImmediately: true,
      kCGImageSourceCreateThumbnailWithTransform: true,
      kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
    ] as [CFString : Any] as CFDictionary
    
    return downsampleOptions
  }
}
```
- 다운샘플링 전과 용량을 비교해야 하므로 NSCache의 countLimit과 totalCostLimit은 제거하고 다시 측정했습니다.
- 정말 놀랍게도 아래와 같은 결과가 나왔습니다. 

<img width="70%" alt="4_1_NSCache 제한 풀고_CGImage로 다운 샘플링_RAM" src="https://github.com/minsson/ios-hongdangmu-market/assets/96630194/47352d06-2866-49f1-9957-ccbeff247509">

- 이미지 한 장당 평균 약 99KB의 메모리를 사용합니다. 100MB에 1034장이 들어갑니다.
  - 129 * 1024 / 1336 = 98.87
- 다운샘플링 전 대비 개선율이 2,422%이며, UIImage로 다운샘플링 후 대비 개선율이 1,088% 입니다.
- 2-3배 정도는 좋아질 수 있을 거라고 생각했지만, 이렇게까지 큰 차이가 나니 당황스러울 정도였습니다.
- 좀 더 깊게 공부하지 않았다면 UIImage로 다운샘플링한 상태로 프로젝트를 마무리했을지도 모릅니다.
- 이 트러블 슈팅을 통해 늘 깊게 공부하는 습관을 유지하고, WWDC 등 여러 학습자료를 통해 역량을 강화해야 한다는 생각을 다시 한번 하게 됐습니다. 


