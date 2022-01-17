////: [Previous](@previous)
//import Cocoa
import UIKit


//var greeting = "Hello, playground"

extension String {

    
    func getRange(string:String) -> NSRange? {
        guard let range = self.range(of: string) else { return nil }
        return NSRange(range, in:self)
    }
}
extension String {
    var decodingUnicodeCharacters: String { applyingTransform(.init("Hex-Any"), reverse: false) ?? "" }
}


let string = "\Uc54c \Uc218 \Uc5c6 \Ub294 \Uc624 \Ub958 \Uc785 \Ub2c8 \Ub2e4"

print(string.decodingUnicodeCharacters)

/*

let placeholder :String = "mail@address.com"

let input :String = "m@"

let rangeAt = input.getRange(string: "@")
let rangeDot = input.getRange(string: ".")


let placeholderAt = placeholder.getRange(string: "@")
let placeholderDot = placeholder.getRange(string: ".")

var output : String = ""

if rangeAt != nil {
    

    if let start = placeholderDot?.location {
        let index = placeholder.index(placeholder.startIndex, offsetBy: start)

        let append = placeholder[index..<placeholder.endIndex]
        
        
        output = input + append
        print(output)
        
    }
    
    
    
    
    
    
}else if  rangeAt != nil && rangeDot != nil  {

    output = input
    
}else {
    let start =  placeholderAt?.location ?? 0
    
    let index = placeholder.index(placeholder.startIndex, offsetBy: start)

    let append = placeholder[index..<placeholder.endIndex]
    
    
    output = input + append
    
    //print(output)
    
}
*/
//if  {
//
//
//}else if input.contains("@") && input.contains(".") {
//
//
//}else {
//    let index = placeholder.index(placeholder.startIndex, offsetBy: start)
//    let append = placeholder[index..<placeholder.endIndex]
//
//    print(append)
//
////    let range = placeholder.index(after: self.startIndex.advancedBy(index))
////    let append = placeholder[range]
////    print(append)
////    output = input + placeholder[]
////
////    print(output)
//
////    let attributedString = NSMutableAttributedString(string: title)
////    attributedString.setAttributes([NSAttributedString.Key.foregroundColor: UIColor.orange], range: convertedRange)
//}


//: [Next](@next)
