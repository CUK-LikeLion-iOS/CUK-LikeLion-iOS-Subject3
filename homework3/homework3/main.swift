import Foundation

struct Person {
    
    var money : Int
    var name : String
    
    mutating func buy (itemPrice : Int) -> Int
    {
        return money - itemPrice
    }
    
}

struct CoffeeShop {
    
    var sales : Int
    var barista : Person?
    var menu : [Coffee : Int]?
    var pickUpTable : [Coffee] = []
    
    mutating func order (coffee : Coffee ,person : Person)  {
        
        guard let menuExist = menu?[coffee] else {
            print("메뉴에 없는 것입니다.")
            return
            
        }
        pickUpTable.insert(coffee, at:pickUpTable.endIndex)
        
    }
    
}

enum Coffee {
    case americano ,latte ,tea ,capuccino
}


let misterLee = Person(money: 1000 ,name :"misterLee")
let missKim = Person(money: 2000,name :"missKim")
let mutsabucks = CoffeeShop(sales: 0, barista: misterLee)

