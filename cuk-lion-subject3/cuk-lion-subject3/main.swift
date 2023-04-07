//
//  main.swift
//  cuk-lion-subject3
//
//  Created by 김희은 on 2023/03/29.
//
import Foundation

enum Coffee{
    case americano, cafeLatte , iceTea, vanillaLatte , brunchSet
}

struct Person {
    var name: String
    var money: Int
    
    mutating func buySomething(amount: Int) -> Bool {
        let balance = self.money - amount

        if balance >= 0 {
            self.money -= amount
            print("\(name)고객님의 주문이 완료되었습니다.")
            print("고객님의 남은 잔고는 \(money)입니다.")
            return true
        }
        // 잔액부족
        else {
            print("\(name)고객님, 잔액이 \(balance)원만큼 부족합니다.")
            print("돈을 더 벌어오세요!\n")
            return false
        }
    }
}

struct CoffeeShop{
    var customer: Person = Person(name: "비회원", money: 0) // ___고객의 이름을 알 수 없음. 해당 고객의 이름을 "-"로 설정해둔 것이 미흡.
    var sales: Int = 0
    var menu: [Coffee: Int] = [.americano: 3500, .cafeLatte: 4000, .vanillaLatte: 4500, .brunchSet: 10500]
    var pickUpTable = [true, false, false]
    
    var barista: Person
    
    public mutating func order(coffee: Coffee) {
        print("===== 안녕하세요. 메뉴를 고르시면 말씀해주세요. =====\n")
        
        if(self.welcomeCustomers(coffee: coffee)) {
            self.makeCoffee()
            self.serveCoffee()
        }
        print("=========== 감사합니다. 안녕히가세요. ===========\n")
    }
    
    
    // 고객 주문 받기
    private mutating func welcomeCustomers(coffee: Coffee) -> Bool {
        print("\(self.barista.name)입니다. \(coffee)주문받았습니다.")
        
        // 주문 불가능한 메뉴일 경우 예외처리
        guard let payment = self.menu[coffee] else {
            print("죄송합니다. 해당 메뉴는 저희 매장에 존재하지 않습니다.")
            return false
        }
        
        if self.customer.buySomething(amount: payment) {
            print("가격은 \(payment)원입니다.")
            self.sales += payment

            return true
        }
        return false
    }
    
    private func makeCoffee(){
        print("음료 제조 중입니다")
    }
    
    private mutating func cleanPickUpTable() {
        print("픽업대를 정리하는 중입니다. 잠시만 기다려주세요.")
        for i in 0...2 {
            self.pickUpTable[i] = false
        }
    }
    
    private mutating func serveCoffee() {

        for i in 0...2 {
            if self.pickUpTable[i] == false{
                print("\(i)번 테이블에서 제공해드리겠습니다.")
                self.pickUpTable[i] = true
                break
            }
            else if (i == 2) && (self.pickUpTable[2] == true){
                // 픽업대 청소 후 다시 제공
                self.cleanPickUpTable()
                print("0번 테이블에서 제공해드리겠습니다.")
                self.pickUpTable[0] = true
            }
        }

        print("\n\(self.customer.name)님의 커피가 준비되었습니다. 픽업대에서 가져가주세요.")
    }
}

var misterLee: Person = Person(name: "misterLee", money: 10000)
var missKim: Person = Person(name: "missKim", money: 5000)
var mustabucks: CoffeeShop = CoffeeShop(sales: 100000, barista: misterLee)

mustabucks.customer = missKim
mustabucks.order(coffee: .brunchSet)
mustabucks.order(coffee: .americano)
