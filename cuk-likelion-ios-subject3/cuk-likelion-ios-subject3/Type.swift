//
//  Type.swift
//  cuk-likelion-ios-subject3
//
//  Created by Jinyoung Yoo on 2023/03/30.
//

import Darwin

enum Coffee: String {
    case espresso, americano, cafeLatte, cappucino
}

struct Person {
    fileprivate var money: Int
    fileprivate var name: String
    
    
    init(money: Int, name: String) {
        self.money = money
        self.name = name
    }
    
     mutating func buyCoffee(coffee: Coffee, at coffeeShop: inout CoffeeShop) {
        print("\(self.name): \(coffee) 얼마에요?")
        
        let price: Int = coffeeShop.coffeePrice(coffee: coffee) // coffeeShop에서 가격 받아옴
        let balance: Int = self.money - price
        
        if (balance < 0) {
            print("\(self.name): 어라...? 잔액이 \(-balance)원 만큼 부족하네요.. 다음에 올께요ㅠㅠ")
        }
        else if (balance >= 0) {
            coffeeShop.order(coffee: coffee) // coffeeShop에다 주문
            self.money = balance
            print("(\(self.name) 잔고: \(self.money) 원)")
        }
    }
}

struct CoffeeShop {
    fileprivate var name: String
    fileprivate var barista: Person

    private var menu: [Coffee: Int] = [.espresso: 1000, .americano: 1500, .cafeLatte: 2000]
    private var revenue: Int = 0
    private var pickUpTable: Bool = false {
        didSet {
            if (self.pickUpTable) {
                print("\(self.barista.name): 커피가 준비되었습니다. 픽업대에서 가져가주세요.")
            }
        }
    }
    
    init(name: String, barista: Person) {
        self.name = name
        self.barista = barista
    }
    
    /*  ----------------- FILTERPRIVATE METHODs ----------------------  */
    
    fileprivate mutating func order(coffee: Coffee) {
        
        guard let price = self.menu[coffee] else {
            print("\(self.name): 저희 가게에는 안 파는 커피에요!")
            return
        }
        
        print("\(self.name): \(coffee) 주문 받았습니다! 조금만 기다려주세요~")

        self.revenue += price
        print("(\(self.name) 매출액: \(self.revenue)원)")

        makingCoffee(coffee: coffee)
        serveCoffee()
    }
    
    // 커피 가격 반환
    fileprivate func coffeePrice(coffee: Coffee) -> Int {
        
        guard let price = self.menu[coffee] else {
            return 0
        }
        
        print("\(self.name): \(price)원 입니다!")
        return price
    }
    
    
    /*  ----------------- PRIVATE METHODs----------------------  */

    private func makingCoffee(coffee: Coffee) {
        print("\(self.barista.name): (\(coffee) 만드는 중", terminator: "")
        for _ in 1...4 {
            sleep(1)
            print(".", terminator: "")
        }
        print(")")
    }
    
    private mutating func serveCoffee() {
        self.pickUpTable = true
    }
}
