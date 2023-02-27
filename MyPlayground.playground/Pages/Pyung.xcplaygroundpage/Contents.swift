//: [Previous](@previous)

import Foundation


let ratio:Float = 3.306
displayMenu()



func displayMenu() {

        print("1: m2 => 평")
        print("2: 평 => m2")
        print("3: 종료")
        
        if let input = readLine() {
            
            if let menu = Int(input) {
                
                switch(menu) {
                case 1:
                    m2ToPyoung()
                case 2:
                    pyoungToM2()
                case 3:
                    exit(0)
                default:
                    print("잘못입력하였습니다.")
                    displayMenu()
                }
            }else {
                
            }
        }else {
            print("잘못입력하였습니다.")
            displayMenu()
        }
    
    
}

func m2ToPyoung() {

        print("제곱미터(㎡)를 입력하세요. :")
        if let input = readLine() {
            if let squaremeater = Int(input) {
            
            let result = Float(squaremeater) / ratio
            
            print("\(result)평")
            }else {
                print("잘못입력였습니다.")
                displayMenu()
            }
            
        }
    

}

func pyoungToM2() {

        print("평수를 입력하세요. :")
        if let input = readLine() {
            if let squaremeater = Int(input) {
            
            let result = Float(squaremeater) * ratio
            
            print("\(result)㎡")
            }else {
                print("잘못입력였습니다.")
                displayMenu()
            }
            
        }
  

}
//: [Next](@next)
