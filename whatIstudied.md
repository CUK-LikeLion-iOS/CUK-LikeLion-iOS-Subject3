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

    <br/>

#### 구조체의 생성

![구조체의 생성](https://corykim0829.github.io/assets/images/understanding-swift-performance/1-1value-semantics.png)

#### 클래스의 생성

![클래스의 생성](https://corykim0829.github.io/assets/images/understanding-swift-performance/1-2value-semantics.png)


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

### 클래스 내부의 구조체 vs 구조체 내부의 클래스

        만약 구조체와 클래스가 혼용 사용되었을 때 값이 변경되면 어떨까?

<br/>

* 1번 예제

```swift
struct SomeStruct {
    var name: String
}

class SomeClass {
    var structWithin;
}

var myStruct = SomeStruct(name: "Hello")
var myClass = SomeClass(strcutInClass: myStruct)
var myClassCopy = myClass

myClass.structWithin.name = "Goodbye"

print(myClassCopy.structWithin.name)

// ??
```

* 2번 예제

```swift
struct SomeStruct {
    var classWithin: SomeClass
}

class SomeClass {
    var name: String
}

var myClass = SomeClass(name: "Hello")
var myStruct = SomeStruct(classWithin: myClass)
var myStructCopy = myStruct

myStruct.classWithin.name = "Goodbye"

print(myStructCopy.classWithin.name)

// ??
```
<br/>

---
## Enum
### 특징
* 구조체와 마찬가지로 값타입이다.
* 기본 구문
```swift
enum Furniture {
    case sofa, bed, desk, chair, shelf
}

buyFurniture(furniture: .sofa)
```

<br/>

* enum 케이스 반복

CaseIterable 프로토콜을 상속 받아 사용할 수 있다.

```swift
enum Furniture: CaseIterable {
    case sofa, bed, desk, chair, shelf
}

for i in Furniture.allCases {   // Furniture.allCases는 Array<Furniture>을 반환한다.
    print(i)
}
// sofa
// bed
// desk
// ...
```

* 원시값

        원시값은 C/C++의 열거형에서 원시값과 유사하다.
    ```swift
    enum Furniture: Int {
    case sofa = 1, bed, desk, chair, shelf
    }
    // sofa = 1, bed = 2, desk = 3, ...
    ```

* 재귀 enum

        재귀 열거형은 열거형의 다른 인스턴스를 재귀적으로 가지고 있다. 

```swift
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))

// Prints "18"
```