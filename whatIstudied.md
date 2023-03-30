# LikeLion Subject 3

## Class vs Struct

### 공통점
* 프로퍼티 / 메소드 사용
* 서브 스크립트 사용
* 초기화 (init)
* 확장 (extension)과 프로토콜 (protocol) 사용

### 클래스의 차별점
* 상속
* 타입 캐스팅
* 초기화 해제 (deinit)
* 참조타입

        결국 구조체와 클래스의 차이점은 값과 참조에서 오는 것으로 보아도 무방하다.

### [구조체와 클래스 선택 가이드](https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes)
* 기본적으로 구조체를 사용한다.
* Objective-C와의 상호 운용성이 필요하면 클래스를 사용한다.
* 정체성을 제어해야 할 때 클래스를 사용하고 그렇지 않으면 구조체를 사용한다.

<br/>

### Copy-on-write

```swift
var arr = [1, 2, 3, 4]
var arr2 = arr  // 구조체로 정의된 배열은 값타입이므로 arr과 arr2는 기본적으로 다르다.

print(arr == arr2)  // true

arr.append(5)
print(arr == arr2)  // false
```

    기존 구조체 변수를 새로운 변수로 할당할 때, 즉시 복사를 하지 않고 기존 인스턴스를 사용하다 변경사항이 생기면 그제서 복사본을 만든다.
    구조체는 기본적으로 값타입이지만 복사는 레퍼런스 카운팅과 같은 오버헤드를 발생시키기 때문에 선택된 최적화 방법이다.

<br/>

---
## Enum
### 특징
* 구조체와 마찬가지로 값타입
