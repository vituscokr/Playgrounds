//: [Previous](@previous)

import Foundation


struct Stack<Element:Equatable> {
    private var storage :[Element] = []
    
    init() {
        
    }
    init(_ elements: [Element]) {
        self.storage = elements
    }
    var isEmpty :Bool {
        return peek() == nil
    }
    
    func peek() -> Element? {
        return storage.last
    }
    
    mutating func push(_ element: Element) {
        storage.append(element)
    }
    @discardableResult
    mutating func pop() -> Element? {
        return storage.popLast()
    }
}
extension Stack : CustomStringConvertible {
    var description:String {
        return storage
            .map { "\($0)" }
            .joined(separator: " ")
    }
}

extension Stack : Equatable {
 
//    public static func == (lhs: Self, rhs: Self) -> Bool {
//
//    }
}

extension Stack : ExpressibleByArrayLiteral {
    init(arrayLiteral elements:Element...) {
        storage = elements
    }
}


struct A {

func checkParentheses(_ string : String) -> Bool {
    var stack = Stack<Character>()
    
    for charater in string {
        if charater == "(" {
            stack.push(charater)
        }else if charater == ")" {
            if stack.isEmpty {
                return false
            }else {
                stack.pop()
            }
            
        }
    }
    
    return stack.isEmpty
}

}

let string1 = "function()"

let string2 = "fuc(func))"


let a = A()

let ar = a.checkParentheses(string1)
let br = a.checkParentheses(string2)

print(ar)
print(br)


//TEST:
let stack1:Stack = ["a","b","c"]

print(stack1)



var stack = Stack<Int>()
stack.push(1)
stack.push(2)
stack.push(3)
stack.push(4)
stack.pop()

print(stack.description)



//: [Next](@next)
