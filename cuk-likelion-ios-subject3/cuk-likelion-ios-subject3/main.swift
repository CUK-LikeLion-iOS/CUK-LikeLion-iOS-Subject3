//
//  main.swift
//  cuk-likelion-ios-subject3
//
//  Created by Jinyoung Yoo on 2023/03/23.
//

import Foundation

var misterLee: Person = Person(money: 10000, name: "misterLee")
var missKim: Person = Person(money: 3000, name: "missKim")

var mutsabucks: CoffeeShop = CoffeeShop(name: "mustabucks", barista: misterLee)

missKim.buyCoffee(coffee: .espresso, at: &mutsabucks)

print("--------------------------------------------------")

missKim.buyCoffee(coffee: .americano, at: &mutsabucks)

print("--------------------------------------------------")

missKim.buyCoffee(coffee: .cappucino, at: &mutsabucks)

print("--------------------------------------------------")
