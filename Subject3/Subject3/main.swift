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
    
    private var
    budgets: Int = 10000,
    healthiness: Int = 100
    
    init(name: String, age: Int) {
            self.name = name
            self.age = age
    }
    
    private func changeHealthiness(from bottom: Int, to top: Int) {
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
    
    private func changeBudgets(price: Int) {
        self.budgets += price
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
        changeBudgets(price: hours * 20000)
    }
    
    // 물건을 살 수 있는지
    func balance(price: Int) -> Int {
        return self.budgets - price
    }
    
    // 물건을 산다
    func purchase(stuffName: String, price: Int) {
        print("\(self.name)씨가 \(stuffName)을 \(price)원에 구매했습니다.")
        changeBudgets(price: -price)
    }
}


struct CoffeeShop {
    private let
    barista: Person,
    menu: [Coffee: Int] //커피: 가격
    
    private var
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
        let customerBalance: Int
        
        guard let coffeePrice = self.menu[coffee] else {
            print("그런 거 안팝니다.")
            return
        }
        
        customerBalance = customer.balance(price: coffeePrice)
        
        guard customerBalance >= 0 else {
            print("잔액이 \(-customerBalance)원만큼 부족합니다.")
            return
        }
        
        customer.purchase(stuffName: coffeeName, price: coffeePrice)
        self.sales += coffeePrice
        
        print("바리스타 \(self.barista.name)씨가 \(coffeeName)을(를) 만들고 있습니다.")
        
        finishMakingCoffee(coffee: coffee, customer: customer)
        takeoutCoffee(coffee: coffee, by: customer)
    }
    
    // 커피 완성 후 테이블에 내놓기
    private mutating func finishMakingCoffee(coffee: Coffee, customer: Person) {
        guard var coffeeOnTable = self.pickUpTable[coffee] else {
            print("팔지 않는 커피입니다.")
            return
        }
        
        print("\(customer.name)님의 커피가 준비되었습니다. 픽업대에서 가져가주세요.")
        self.pickUpTable[coffee]! += 1
    }
    
    // 커피 가져가기
    private mutating func takeoutCoffee(coffee: Coffee, by customer: Person) {
        let coffeeName = coffee.rawValue
        
        guard let coffeeOnTable = self.pickUpTable[coffee] else {
            print("팔지 않는 커피입니다.")
            return
        }
        
        guard coffeeOnTable > 0 else {
            print("테이블에 \(coffeeName)(이)가 없습니다.")
            return
        }
        
        print("\(customer.name)씨가 \(coffeeName)을(를) 가져갔습니다.")
        self.pickUpTable[coffee]! -= 1
    }
}



// main
let misterLee = Person(name: "misterLee", age: 28)
let missKim = Person(name: "missKim", age: 28)

missKim.work(for: 8)
missKim.eat(food: "햄버거")
missKim.sleep(for: 7)

var mutsabucks = CoffeeShop(barista: misterLee,
                            menu: [.americano: 3000, .latte: 4000, .cappucino: 2000, .frappe: 4500])

mutsabucks.order(coffee: .frappe, by: missKim)
