
import Foundation
struct Person {
    
    var money : Int
    var name : String
    var isPurchasable : Bool = true
    
    mutating func buy (itemPrice : Int)
    {
        if money >= itemPrice
        {
            money -= itemPrice
            print("""
                    *입출금 내역*
                    출금 : \(itemPrice)
                    \(name)님의 잔액은 \(money)원 입니다.
                    *--------------------------*
                    """)
            isPurchasable = true
        }
        
        else {
            print("잔액이 \(itemPrice - money)원 부족합니다.\n *--------------------------*")
            isPurchasable = false
        }
    }
    
}

struct CoffeeShop {
    
    var sales : Int
    var barista : Person?
    var menu : [Coffee : Int]?
    var pickUpTable : [Coffee] = []
    
    mutating func order (coffee : Coffee ,customer : inout Person)  {
        
        guard barista != nil else {
            print("바리스타가 없습니다. \n *--------------------------*")
            return
        }
        
        guard let itemPrice = menu?[coffee] else {
            print("메뉴에 없는 것입니다.\n *--------------------------*")
            return
        }
        
        customer.buy(itemPrice: itemPrice)
        
        guard customer.isPurchasable else {
            return
        }
        
        self.sales += itemPrice
        self.pickUpTable.insert(coffee, at:pickUpTable.endIndex)
        
        // 메뉴를 제공
        provideItem(coffee: coffee, customer: &customer)
        
    }
    
    mutating func provideItem (coffee: Coffee, customer : inout Person)
    {
        let customerName = customer.name
        let orderedMenu = pickUpTable[pickUpTable.endIndex-1]
        
        if pickUpTable.count > 3
        {
            print("픽업 테이블이 꽉 차있습니다ㅠ 잠시만 대기해주세요!")
            cleanPickUpTable()
        }
        print("""
            \(customerName)님의
            \(orderedMenu) 준비되었습니다.
            픽업대에서 가져가주세요
            *--------------------------*
            """)
    }
    
    mutating func cleanPickUpTable ()
    {
        self.pickUpTable.removeAll()
        
        print("청소 끝 !")
    }
    
}

enum Coffee {
    
    case americano ,latte ,tea ,capuccino
}


var misterLee = Person(money: 10000 ,name :"misterLee")
var missKim = Person(money: 11000,name :"missKim")
var mutsabucks = CoffeeShop(sales: 0, barista: misterLee)
var starbucks = CoffeeShop(sales: 0)

mutsabucks.menu = [.americano:2000,.latte:3000,.tea:4000,.capuccino:3500]
starbucks.menu = [.americano:2000]

mutsabucks.order(coffee: .americano, customer: &missKim)
mutsabucks.order(coffee: .latte, customer: &missKim)
mutsabucks.order(coffee: .tea, customer: &missKim)
mutsabucks.order(coffee: .americano, customer: &missKim)
mutsabucks.order(coffee: .americano, customer: &missKim)
