
struct , class = 기능집합

## 클래스와 구조체

![](https://velog.velcdn.com/images%2Fmarintelli%2Fpost%2Fec624f42-306e-401a-974c-e3fc7ca30733%2Fimage.png)

- 클래스 - 참조타입

- 구조체 - 값 복사 타입

#### 값 타입과 참조타입

1. 할당 방식

- 참조타입: 메모리의 주소를 참조하여 값 할당
- 값 타입: 값을 직접 할당

2. 복사 방식

- 참조타입 : 값을 복사할 때 해당 값의 주소를 복사
- 값 타입 : 값을 복사

3. 수정 방식

- 참조타입 : 값 수정시에 참조하는 모든 변수나 상수에 영향을 미침
- 값 타입 : 해당 값을 복사하기 때문에 다른 변수나 상수에 영향을 미치지 않는다.

---

#### 이니셜 라이저 (Initializer)

이니셜 라이저 : 구조체를 생성할 때 프로퍼티를 초기화 하는 역할  
구조체를 생성할 때 사용자가 원하는 방식으로 초기화 할 수 있고 구조체 에서는 프로퍼티에 대한 초기값을 지정해줄 수 있기 때문에 따로 구현하지 않아도 된다.

```swift
struct Point {
    var x: Int
    var y: Int
}

// Point 구조체 인스턴스 생성
let point = Point(x: 0, y: 0)

class Person {
    var name: String
    var age: Int

    // 사용자 정의 이니셜라이저
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

// Person 클래스 인스턴스 생성
let person = Person(name: "John", age: 30)

```

#### 구조체와 클래스 에서 이니셜라이저의 차이

- 클래스는 참조 타입이다. 변수나 상수가 할당될 때 메모리 상에서 인스턴스를 가리키는 포인터를 가르키게 된다.
  즉, 변수나 상수에 할당된 값은 인스턴스를 가르키는 참조라는 뜻.

- 구조체는 값 타입이다. 변수나 상수가 할당되면 해당 변수는 그 실제 값 자체를 가지게 된다.즉, 인스턴스가 즉 값이라는 뜻

따라서 클래스에서는 프로퍼티에 대한 초기값을 지정할 수 없으며, 이니셜 라이저를 사용하여 인스턴스를 초기화 해야한다.

#### mutating ?

값 타입인 열겨헝, 구조체 내부의 값을 수정할 때 사용하는 키워드
메서드 내부에서 구조체나 열거형의 프로퍼티를 수정하려먼 mutating 의 키워드를 붙여야 한다.

```swift
struct Point {
    var x: Int
    var y: Int

    mutating func moveBy(x deltaX: Int, y deltaY: Int) {
        x += deltaX
        y += deltaY
    }
}
```

클래스에서는 참조 타입이기 때문에 인스턴스를 복사하지 않고도 원래의 인스턴스를 수정할 수 있다.
즉, 클래스에서는 mutating 키워드를 사용할 필요가 없는 것.

```swift
class Person {
    var name: String

    init(name: String) {
        self.name = name
    }
    // .self 를 통해서 원래의 인스턴스를 수정할 수 있다.
    func changeName(to newName: String) {
        self.name = newName
    }
}

```

```swift
struct A {
  var a = 10
}

class B {
  var a = 10
}

var strA = A() //값을 복사
var clsB = B() // 값을 참조

var strAA = strA // 새로운 구조체를 '복사' 한 것
var clsBB = clsB // 원본의 값을 참조 한것

strAA.a += 10
clsBB.a += 10

print(strA.a) // 10
print(strAA.a) // 20
print(clsB.a) // 20
print(clsBB.a) // 20

```

깊은복사 : 

얕은복사 : 값만 복사를 하는 것