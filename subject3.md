### 과제 3

---

💡 [참고 하면 좋을 것 같은 컨벤션](https://hongz-developer.tistory.com/42)

#### 1. 타입

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

- 구조체는 Memberwise Initializer를 제공해준다.

> - 구조체는 초기화 구문(init)을 사용해서 초기화를 하지 않아도 Memberwise Initializer를 자동적으로 제공해준다.
> - Memberwise Initializer를 사용하면 각 저장 프로퍼티의 이름과 타입을 매개변수로 받아서 인스턴스를 초기화한다. 이때, 매개변수의 이름은 프로퍼티의 이름과 동일하게 사용된다.
> - 클래스는 상속을 지원하기 때문에 상속과 관련된 복잡한 초기화 로직이 필요할 수 있기 때문에 구조체처럼 단순한 초기화 로직에 사용자가 편리하게 인스턴스를 생성할 수 있도록 해주는 Memberwise Initializer가 지원되지 않는다.

<br />

##### 클래스(Class)

> Swift에서 구조체와 가장 다른 점은 값 타입이 아니라 참조(Reference) 타입이다.

<br />

##### 열거형(Enum)

<br />

#### 2. 프로퍼티

Swift의 프로퍼티에는 크게 3가지가 있다.

> - Stored Property (저장 프로퍼티)
> - Computed Property (연산 프로퍼티)
> - Type Property (타입 프로퍼티)

<br />

##### Stored Property (저장 프로퍼티)

- 일반적인 인스턴스 프로퍼티를 의미한다. var, let에 따라 변수 저장 프로퍼티, 상수 저장 프로퍼티로 불린다. 저장프로퍼티를 선언할 때, 저장할 기본값을 정해줄 수도 있다. 클래스와 구조체에서 사용 가능하다.

- Lazy Stored Property(지연 저장 프로퍼티)

  - 처음 사용될 때까지 초기값은 계산되지 않는 프로퍼티

    - 의존적인 값을 필요로 하는 프로퍼티를 사용하고 싶을 때 유용하다

    ```swift
        struct Person {
            var name: String = "진영"
            lazy var fullName: String = "유" + self.name
        }

        var person = Person()
        person.name = "지녕"

        print(person.fullName) // 처음 접근된 시점에서 프로퍼티의 초기값이 정해짐 -> 유지녕
    ```

    - 프로퍼티의 초기값으로 필요할 때까지 수행하면 안되는 복잡하거나 계산 비용이 많이 드는 경우 또는 쓸데없는 메모리 낭비를 방지하는 데 유용하다.

    ```swift
        /* DataManager 클래스의 기능적 부분은 파일로부터 데이터를 가져올 수 있다.
        이 기능은 DataImporter 클래스로부터 제공되고 초기화 하는데 시간이 많이 걸린다고 가정한다.
        DataImporter 인스턴스가 초기화 될 때 DataImporter 인스턴스는 파일을 열고 메모리로 내용을 읽어야 하기 때문일 수 있다.
        DataManager 인스턴스는 파일로 부터 데이터를 가져올 필요 없이 데이터를 관리할 수 있으므로 DataManager 가 생성될 때 새로운 DataImporter 인스턴스를 생성할 필요가 없다.
        대신에 DataImporter 인스턴스를 처음 사용하는 경우에 생성하는 것이 더 합리적이다. */
        class DataImporter {
            var filename = "data.txt"

            /* 파일을 열고 원하는 데이터를 추출해서 가공하는 코드 */

        }

        class DataManager {
            lazy var importer = DataImporter()
            var data = [String]()
        }

        let manager = DataManager()
        manager.data.append("Some data")
        manager.data.append("Some more data")

        print(manager.importer.filename) // importer 프로퍼티에 처음 접근된 시점에 DataImporter의 인스턴스가 생성된다.
    ```

    - 인스턴스 초기화가 되는 시점에 값이 없을 수도 있으므로 당연히 lazy let은 쓸 수 없다.

<br />

##### Computed Property (연산 프로퍼티)

- 클래스, 구조체, 그리고 열거형은 값을 실질적으로 저장하지 않는 연산 프로퍼티를 정의할 수 있다. 대신 다른 프로퍼티와 값을 간접적으로 조회하고 설정하는 getter와 선택적 setter를 제공한다. 선택적 setter라고 한 이유는 연산 프로퍼티를 사용할 때 getter는 무조건 있어야 하지만 setter는 생략될 수 있기 때문이다.

  - 다음은 연산 프로퍼티 사용 예시이다.

  ```swift
    struct Person {
        var koreanAge: Int
        var americanAge: Int {
            get {
                return koreanAge - 1
            }
            set(newValue) {
                /* newValue는 다른 네이밍을 사용해도 된다. */
                koreanAge = newValue + 1
            }
        }
    }
  ```

      <br />

  > americanAge를 연산 프로퍼티로 사용하여 koreanAge와 서로 의존적인 값으로 만들어줬다. 연산 프로퍼티는 값이 고정되어 있지 않기 때문에 반드시 <b>var</b>로 선언해야 한다.

  - 짧은 setter 선언 (setter의 인자 부분을 생략하는 대신 무조건 newValue라는 네이밍을 사용해야 한다.)

  ```swift
  struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
  }
  ```

  - 짧은 getter 선언 (getter의 전체 본문이 단일 표현식이라면 getter는 암시적으로 표현식을 반환한다.)

  ```swift
  struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2),
                  y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
  }
  ```

  - 읽기 전용 연산 프로퍼티 (get 키워드를 생략하고 setter 부분을 사용하지 않음으로써 read-only로 만듬)

  ```swift
  struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
  }
  let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
  print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
  // Prints "the volume of fourByFiveByTwo is 40.0"
  ```

<br/>

##### 💡 의존적인 값을 필요로 하는 프로퍼티라는 점은 lazy 프로퍼티와 비슷한데 언제 lazy 프로퍼티를 쓰고 언제 연산 프로퍼티를 쓰면 좋을까?

> 두 개의 프로퍼티의 가장 큰 차이점은 저장 프로퍼티와 연산 프로퍼티인 점이다. 개인적으로는 의존성을 위한 "연산"에 강조를 하고 싶다면 연산 프로퍼티를 사용하면 좋을 것 같다는 생각이 든다.
> 또한, lazy 프로퍼티는 프로퍼티 초기화 비용이 많이 들고 값이 자주 변경되지 않을 때 사용하면 좋고 계산 또는 변환이 상대적으로 저렴하거나 기본 값이 자주 변경될 가능성이 있는 경우에는 연산 프로퍼티를 사용하면 좋다고 한다.

- <b>프로퍼티 감시자</b>

```swift
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
            // newValue가 기본 네이밍
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
            // 생략될 때는 oldValue로 무조건 사용해야함
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps
```

[get, set, willSet, didSet을 활용하는 법](https://duwjdtn11.tistory.com/551)
