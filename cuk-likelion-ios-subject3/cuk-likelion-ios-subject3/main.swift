//
//  main.swift
//  cuk-likelion-ios-subject3
//
//  Created by Jinyoung Yoo on 2023/03/23.
//

import Foundation

var misterLee: Person = Person(money: 10000)
var missKim: Person = Person(money: 3000)

var mutsabucks: CoffeeShop = CoffeeShop(revenue: 0, pickUpTable: false, barista: misterLee)

missKim.buy(stuff: "컴퓨터", price: 2000)
print("잔액: \(missKim.money)원")

print("---------------------------------")

missKim.buy(stuff: "냉장고", price: 3000)

print("---------------------------------")

mutsabucks.takeOrder(coffee: .cappucino)
print("매출액: \(mutsabucks.revenue)원")

print("---------------------------------")

mutsabucks.takeOrder(coffee: .americano)
print("매출액: \(mutsabucks.revenue)원")

print("---------------------------------")

mutsabucks.takeOrder(coffee: .cafeLatte)
print("매출액: \(mutsabucks.revenue)원")


