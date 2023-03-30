### 과제 3

---

💡 [참고 하면 좋을 것 같은 컨벤션](https://hongz-developer.tistory.com/42)

#### 1. 타입

<br/>

##### 구조체(Struct)

> - 스위프트 대부분 타입은 구조체로 이루어져있다.
> - 구조체는 값 타입이다.

<br/>

- 값 타입(Value Type)

```swift
struct Point {
    var x: Int
    var y: Int
}

var point1 = Point(x: 10, y: 20)
var point2 = point1 // point2 is a copy of point1
point1.x = 30
print(point1.x) // Output: 30
print(point2.x) // Output: 10
```

> 위 코드에서 알 수 있듯이 변수에 할당되거나 함수에 매개변수로 전달될 때 값이 복사되어서 원본과 복사본의 변화는 서로에게 영향을 주지 않는다. 내부적으로는 COW(Copy on Write), 값 타입이 복사되어 전달되거나 대입될 때, 실제로는 새로운 인스턴스가 생성되는 것이 아니라 원본 인스턴스를 참조하다가 값이 변경되는 순간에 새로운 인스턴스를 생성하는 방식이다. 즉 point1.x가 30으로 변경되기 전에는 point1과 point2는 동일한 인스턴스를 참조하다가 30으로 값이 변경된 순간에 프로퍼티 값이 변경된 새로운 인스턴스가 복사되어 point1에 재할당 된다는 뜻이다.

<br/>

- 타입 프로퍼티, 타입 메소드, 인스턴스 프로퍼티, 인스턴스 메소드

> 프로퍼티는 다른 언어에서 흔히 말하는 멤버 변수를 말한다.
> 다른 언어에서는 객체(타입)를 생성하면 해당 객체의 인스턴스를 만들어 인스턴스의 멤버 변수나 인스턴스의 메서드를 사용했다.
> 하지만, Swift는 인스턴스 뿐만 아니라 객체(타입) 자체의 프로퍼티나 메서드를 선언하고 사용할 수 있다.
> (이를 잘 설명해줄 수 있는 것이 바로 지난 과제에서 공부했던 Int.random()이다. Int 타입이 random이라는 메서드를 가지고 있는데
> 이는 우리가 흔히 알고 있는 인스턴스 메서드가 아니라 타입 메서드였던 것이다.)

```swift
struct Sample {
    var mutableProperty: Int = 100 // 가변 프로퍼티(값 변경 가능)
    let immutableProperty: Int = 100 // 불변 프로퍼티(값 변경 불가능)
    static var typeProperty: Int = 100 // 타입 프로퍼티(static 키워드 사용 : 타입 자체가 사용하는 프로퍼티)

    // 인스턴스 메서드(인스턴스가 사용하는 메서드)
    func instanceMethod() {
        print("instance method")
    }

    // 타입 메서드(static 키워드 사용 : 타입 자체가 사용하는 메서드)
    static func typeMethod() {
        self.typeProperty += 100 // 타입 메서드안에서의 self는 인스턴스가 아니라 타입을 의미한다.
        print("type method")
    }
}
```

> 타입 프로퍼티는 모든 인스턴스들이 공유하는 데이터라고 생각하면 된다.

>

<br/>

- 기본적으로 구조체의 메서드는 내부 프로퍼티 값을 변경할 수 없다.

> 구조체의 인스턴스를 가리키는 self는 immutable, 즉 상수의 성질을 띄고 있기 떄문에 메서드에 mutating 키워드를 사용하지 않으면 내부 프로퍼티 값을 바꿀 수 없다.

```swift
struct Point {
    var x = 0.0, y = 0.0

    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX // -> self.x += deltaX
        y += deltaY // -> self.y += deltaY
    }
}

var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 2.0, y: 3.0) // 이 시점에 변경된 내부 프로퍼티 값이 적용된 구조체 인스턴스의 복사본이 somePoint에 재할당
print("The point is now at (\(somePoint.x), \(somePoint.y))")
```

<br/>

###### 클래스(Class)

> Swift에서 구조체와 가장 다른 점은 값 타입이 아니라 참조(Reference) 타입이다.
