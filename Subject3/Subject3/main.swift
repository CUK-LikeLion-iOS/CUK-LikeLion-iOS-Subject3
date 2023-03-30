import Foundation

enum Coffee: String {
    case americano = "아메리카노"
    case latte = "라떼"
    case cappucino = "카푸치노"
    case frappe = "프라페"
    case macchiato = "마끼아토"
}

class Person {
    let
    name: String,
    age: Int
    
    var
    budgets: Int = 10000,
    healthiness: Int = 100
    
    init(name: String, age: Int) {
            self.name = name
            self.age = age
    }
    
    func changeHealthiness(from bottom: Int, to top: Int) {
        let changedHealthiness = Int.random(in: bottom...top)
        
        print("HP가 \(self.healthiness)에서")
        
        self.healthiness += changedHealthiness
        if (self.healthiness < 0) {
            self.healthiness = 0
        }
        else if (self.healthiness > 100) {
            self.healthiness = 100
        }
        
        print("\(self.healthiness)로 변경되었습니다.")
    }
    
    func changeBudgets(pay: Int) {
        self.budgets += pay
    }
    
    func eat(food: String) {
        print("\(name)씨가 \(food)(을)를 먹었습니다!")
        changeHealthiness(from: -20, to: 20)
    }
    
    func sleep(for hours: Int) {
        print("\(name)씨가 \(hours)시간 동안 잠을 잤습니다!")
        changeHealthiness(from: hours * 2, to: hours * 3)
    }
    
    func work(for hours: Int) {
        print("\(name)씨가 \(hours)시간 동안 일을 합니다.")
        changeHealthiness(from: hours * -2, to: -hours)
        changeBudgets(pay: hours * 20000)
    }
    
    // 물건을 살 수 있는지
    func hasEnoughMoney(price: Int) -> Bool {
        guard (self.budgets >= price) else {
            return false
        }
        return true
    }
    
    // 물건을 산다
    func purchase(stuffName: String, price: Int) {
        print("\(self.name)씨가 \(stuffName)을 \(price)원에 구매했습니다.")
        self.budgets -= price
    }
    
}


struct CoffeeShop {
    let
    barista: Person,
    menu: [Coffee: Int] //커피: 가격
    
    var
    sales: Int = 0,
    pickUpTable = [Coffee: Int]() //테이블 위 커피: 개수
    
    init(barista: Person, menu: [Coffee: Int]) {
        self.barista = barista
        self.menu = menu
        
        for coffeeType in menu.keys {
            self.pickUpTable[coffeeType] = 0
        }
    }
    
    mutating func order(coffee: Coffee, by customer: Person) {
        let coffeeName = coffee.rawValue
        
        guard let coffeePrice = self.menu[coffee] else {
            print("그런 거 안팝니다.")
            return
        }
        
        guard customer.hasEnoughMoney(price: coffeePrice) else {
            print("외상 안됩니다.")
            return
        }
        
        customer.purchase(stuffName: coffeeName, price: coffeePrice)
        self.sales += coffeePrice
        
        print("바리스타 \(self.barista.name)씨가 \(coffeeName)을(를) 만들고 있습니다.")
        
        finishMakingCoffee(coffee: coffee)
        takeoutCoffee(coffee: coffee, by: customer)
    }
    
    // 커피 완성 후 테이블에 내놓기
    mutating func finishMakingCoffee(coffee: Coffee) {
        let coffeeName = coffee.rawValue
        
        print("\(coffeeName) 제작을 완료했습니다.")
        self.pickUpTable[coffee]! += 1
    }
    
    // 커피 가져가기
    mutating func takeoutCoffee(coffee: Coffee, by customer: Person) {
        let coffeeName = coffee.rawValue
        
        guard pickUpTable[coffee]! > 0 else {
            print("테이블에 \(coffeeName)(이)가 없습니다.")
            return
        }
        
        print("\(customer.name)씨가 \(coffeeName)을(를) 가져갔습니다.")
        self.pickUpTable[coffee]! -= 1
    }
}



// main
let misterLee = Person(name: "이철수", age: 28)
let missKim = Person(name: "김영희", age: 28)

var mutsabucks = CoffeeShop(barista: misterLee,
                            menu: [.americano: 3000, .latte: 4000, .cappucino: 2000, .frappe: 4500])

mutsabucks.order(coffee: .americano, by: missKim)
