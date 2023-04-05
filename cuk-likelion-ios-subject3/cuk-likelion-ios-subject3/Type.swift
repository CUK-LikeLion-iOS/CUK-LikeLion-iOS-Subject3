//
//  Type.swift
//  cuk-likelion-ios-subject3
//
//  Created by Jinyoung Yoo on 2023/03/30.
//

import Foundation

enum Coffee: String {
    case espresso, americano, cafeLatte, cappucino
}

struct Person {
    var money: Int
    
     mutating func buy(stuff: String, price: Int) {
        let balance: Int = self.money - price
        
        if (balance < 0) {
            print("\(stuff) 살 돈이 없는데 네고 가능한가요..?ㅠㅠㅠ")
        }
        else {
            print("\(stuff) 살께요!")
            self.money = balance
        }
    }
}

struct CoffeeShop {
    var revenue: Int
    let menu: [Coffee: Int] = [.espresso: 1000, .americano: 1500, .cafeLatte: 2000]
    var pickUpTable: Bool
    var barista: Person

    
    mutating func takeOrder(coffee: Coffee) {

        guard let price = self.menu[coffee] else {
            print("메뉴판에 없는 커피를 주문하셨네요,,, 다른 메뉴를 골라주세요!")
            return
        }
        
        print("\(price)원 받았습니다! 커피가 다 만들어지면 픽업 테이블에서 받아가세요!")

        if (self.pickUpTable) {
            print("(대충 픽업 테이블 비우는 중.....)")
            self.pickUpTable = false
        }
        
        self.provideCoffee()
        self.revenue += price
    }
    

    mutating func provideCoffee() {
        print("주문하신 커피가 나왔습니다!")
        
        self.pickUpTable = true
    }
}
