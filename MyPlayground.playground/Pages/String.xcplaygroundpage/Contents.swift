////: [Previous](@previous)
//import Cocoa
import UIKit


//convertDictionary


func convertToDictionary(text:String) -> [String:Any]? {
    
    guard let data = text.data(using: .utf8) else {
        return nil
    }
    
    do {
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
    }catch {
        print(error.localizedDescription)
    }
    return nil
}


let testString = """
{
"userId":"test",
"password":"test",
"userlevel": 1,
"isAdmin": false
}
"""

if let converted = convertToDictionary(text: testString) as? [String:Any] {
    print(converted)

    print(converted["isAdmin"])
}








//import Cocoa

//var greeting = "Hello, playground"

//extension String {
//
//
//    func getRange(string:String) -> NSRange? {
//        guard let range = self.range(of: string) else { return nil }
//        return NSRange(range, in:self)
//    }
//}
//extension String {
//    var decodingUnicodeCharacters: String { applyingTransform(.init("Hex-Any"), reverse: false) ?? "" }
//}
//
//
//let string = "\Uc54c \Uc218 \Uc5c6 \Ub294 \Uc624 \Ub958 \Uc785 \Ub2c8 \Ub2e4"
//
//print(string.decodingUnicodeCharacters)
//
//



//let string = "\\\uc774\\\ubbf8 \\\uacb0\\\uc81c\\\uc644\\\ub8cc\\\ub41c \\\uc8fc\\\ubb38\\\uc785\\\ub2c8\\\ub2e4.";
let string = "\\uc54c \\uc218 \\uc5c6\\ub294 \\uc624\\ub958\\uc785\\ub2c8\\ub2e4"
let wI = NSMutableString( string: string)
CFStringTransform( wI, nil, "Any-Hex/Java" as NSString, true )

print(wI)




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
