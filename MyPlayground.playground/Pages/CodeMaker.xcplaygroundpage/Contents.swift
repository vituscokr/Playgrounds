//: [Previous](@previous)

import Foundation
import UIKit

var input = """
 graydark4
 graydark3
 darkgray2
 graydark1
 gray0
 graylight2
 graylight1
 graylight
 mainpink_dark
 mainpink
 mainpink_light
 pinklight1
 active
 purpledark
 purple
 purple_light
 green
 green_light2
 green_light
 yellowdark
 yellow
 yellowlight
"""


input.split(separator: "\n").map {
    
    let c = $0.trimmingCharacters(in: .whitespacesAndNewlines)
    let output = """
    SampleColor(name: "\(c)", color: .\(c)),
"""
    print(output)
}

//: [Next](@next)
