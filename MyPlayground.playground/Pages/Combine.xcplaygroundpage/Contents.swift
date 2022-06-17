//: [Previous](@previous)

import Foundation
import Combine

example(of: "Publisher") {
    let myNotification = Notification.Name("MyNotification")
    let publisher = NotificationCenter.default.publisher(for: myNotification)
    let center = NotificationCenter.default

    let observer = center.addObserver(forName: myNotification, object: nil, queue: nil) { notification in
        
        print("Notification received")
    }
    center.post(name: myNotification, object: nil)
    
    
    center.removeObserver(observer)
}

example(of: "Subscriber") {
    let myNotification = Notification.Name("MyNotification")
    let center = NotificationCenter.default
    let publisher = center.publisher(for: myNotification )
    
    let subscription = publisher.sink{ _ in
        print(" notification received from  a publisher ")
        
    }
    center.post(name: myNotification , object: nil )
    
    center.post(name: myNotification , object: nil )
    
    subscription.cancel()
}



//https://medium.com/harrythegreat/swift-combine-입문하기-가이드-1-525ccb94af57
//https://www.raywenderlich.com/books/combine-asynchronous-programming-with-swift/v2.0/chapters/2-publishers-subscribers

//https://qiita.com/shiz/items/5efac86479db77a52ccc
//https://heckj.github.io/swiftui-notes/


//https://medium.com/harrythegreat/swift-combine-입문하기3-네트워크요청-f36d6a32af14


//Just 는 인자로 받는 값의 타입을 Output 로 실패타입은 Never 로 리턴
//Just(5).sink {
//    print($0)
//}

//let provider = (1...10).publisher
//
//provider.sink { _ in
//    print("테이터 전달이 끝났습니다.")
//} receiveValue: { data in
//    print(data)
//}

class CustomSubscriber :  Subscriber {
    // 3
    typealias Input = Int
    typealias Failure = Never

    // 4
    func receive(subscription: Subscription) {
        print("구독을 시작합니다.")
        subscription.request(.unlimited)
        //subscription.request(.max(3))
    }
    
    // 5
    func receive(_ input: Int) -> Subscribers.Demand {
      print("Received value", input)
      return .none
    }
    
    // 6
    func receive(completion: Subscribers.Completion<Never>) {
      print("Received completion", completion)
    }

}

//let publisher = ["A","B","C","D","E","F","G"].publisher
let publisher = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].publisher
let subscriber = CustomSubscriber()

publisher.subscribe(subscriber)







//: [Next](@next)
