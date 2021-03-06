//: [Previous](@previous)

import Foundation
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        let label = UILabel()
        label.frame = CGRect(x: 160, y: 200, width: 200, height: 20)
        label.text = "Hello World"
        label.textColor = UIColor.black
        
        view.addSubview(label)
        self.view = view
    }
}

PlaygroundPage.current.liveView = MyViewController()
//: [Next](@next)
