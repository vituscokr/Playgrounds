//: [Previous](@previous)

import Foundation
import Combine
import UIKit

var subscriptions = Set<AnyCancellable>()


example(of: "drop(while:)") {
    let numbers = (1...10).publisher
    numbers
        .drop(while: {
            $0 % 5 != 0
        })
        .sink(receiveCompletion : { finished  in
            print("completion \(finished)")
        }, receiveValue: {
            print($0)
        })
        .store(in : &subscriptions)
}

example(of: "dropFirst") {
    let numbers = (1...10).publisher
    numbers
        .dropFirst(8)
        .sink(receiveCompletion : { finished  in
            print("completion \(finished)")
        }, receiveValue: {
            print($0)
        })
        .store(in : &subscriptions)
}

example(of: "last(where:)") {
    let number = PassthroughSubject<Int,Never>()
    
    number
        .last(where: {
            $0 % 2 == 0
        })
        .sink(receiveCompletion : { finished  in
            print("completion \(finished)")
        }, receiveValue: {
            print($0)
        })
        .store(in : &subscriptions)
    
    number.send(1)
    number.send(2)
    number.send(3)
    number.send(4)
    number.send(5)
    //finished
    number.send(completion: .finished)
}

example(of: "last(where:)") {
    let number = (1...9).publisher
    number
        .print("numbers")
        .last(where: {
            $0 % 2 == 0
        })
        .sink(receiveCompletion : { finished  in
            print("completion \(finished)")
        }, receiveValue: {
            print($0)
        })
        .store(in : &subscriptions)
    

    
    
}



example(of: "first(where:)") {
    let number = (1...9).publisher
    number
        .print("numbers")
        .first(where: {
            $0 % 2 == 0
        })
        .sink(receiveCompletion : { finished  in
            print("completion \(finished)")
        }, receiveValue: {
            print($0)
        })
        .store(in : &subscriptions)
}

example(of: "ignoreOutput") {
    let numbers = (1...10_000).publisher
    numbers
        .ignoreOutput()
        .sink(receiveCompletion : { finished  in
            print("completion \(finished)")
        }, receiveValue: {
            print($0)
        })
        .store(in : &subscriptions)
}
/// nil is filtered by copmactMap
example(of: "compactMap") {
    let strings = ["a", "1.24","3","def","45","0.23"].publisher
    
    strings
        .compactMap {Float($0)}
        .sink (receiveValue: {
            print($0)
        })
        .store(in : &subscriptions)
}

example(of: "removeDuplicates") {
    
    let words = "hey hey there! want to listen to mister mister ?"
        .components(separatedBy: " ")
        .publisher
    
    words
        .removeDuplicates()
        .sink (receiveValue: {
            print($0)
        })
        .store(in: &subscriptions)
    
}

example(of: "filter") {
    let number = (1...10).publisher
    
    number
        .filter { $0.isMultiple(of: 3) }
        .sink(receiveValue: { n in
            print("\(n) is a multiple of 3 ")
        })
        .store(in: &subscriptions)
}



example(of: "async / await") {
    let subject = CurrentValueSubject<Int, Never>(0)
    Task {
        for await element in subject.values {
            print("Element: \(element)")
        }
        print("Completed.")
    }
    subject.send(1)
    subject.send(2)
    subject.send(3)
    
    subject.send(completion:  .finished)
    
}

example(of: "Type erasure") {
    let subject = PassthroughSubject<Int,Never>()
    let publisher = subject.eraseToAnyPublisher()
    publisher
        .sink(receiveValue: {
            print($0)
        })
        .store(in: &subscriptions)
    
    subject.send(0)
    //publisher.send(1)
    
}

example(of: "Dynamically adjusting Demand") {
    final class IntSubscriber : Subscriber {
        typealias Input = Int
        typealias Failure = Never
        
        func receive(subscription: Subscription) {
            print("구독을 시작합니다.")
            //subscription.request(.unlimited)
            subscription.request(.max(2))
        }
        
        func receive(_ input: Int) -> Subscribers.Demand {
         
                print("Received value : \(input)")
            switch(input) {
            case 1:
                return .max(2)
            case 3:
                return .max(1)
            default:
                return .none
            }
            //return .unlimited
        }
        
        func receive(completion: Subscribers.Completion<Never>) {
            print("Received  completion", completion)
        }
    }
    
    let subscriber = IntSubscriber()
    let subject = PassthroughSubject<Int, Never>()
    
    subject.subscribe(subscriber)
    
    subject.send(1)
    subject.send(2)
    subject.send(3)
    subject.send(4)
    subject.send(5)
    subject.send(6)
    
}

example(of: "CurrentValueSubject") {
    var subscription = Set<AnyCancellable>()
    let subject = CurrentValueSubject<Int, Never>(0)
    subject
        .print()
        .sink(
            receiveValue: {
                print($0)
            }
        )
        .store(in: &subscription)
    subject.send(1)
    subject.send(2)
    
    print(subject.value)
    subject.value = 3
    
    print(subject.value)
    subject.send(completion: .finished)
    
}



example(of: "PassthroughtSubject") {
    
    //define error
    enum MyError : Error {
        case test
    }
    
    final class StringSubscriber : Subscriber {
        typealias Input = String
        typealias Failure = MyError
        
        func receive(subscription: Subscription) {
            print("구독을 시작합니다.")
            //subscription.request(.unlimited)
            subscription.request(.max(3))
        }
        
        func receive(_ input: String) -> Subscribers.Demand {
         
            print("Received value : \(input)")
            return input == "World" ? .max(1) : .none
            //return .unlimited
        }
        
        func receive(completion: Subscribers.Completion<MyError>) {
            print("Received  completion", completion)
        }
    }
    
    let subscriber = StringSubscriber()
    
    let subject = PassthroughSubject<String, MyError>()
    subject.subscribe(subscriber)
    
    let subscription = subject.sink(
        receiveCompletion:{ completion in
            print("Received completion (sink)", completion)
        },
          receiveValue: { value in
         
                print("Received value (sink)", value)
          }
    )
    
    subject.send("Hello")
    subject.send("World")
    
    subject.send(completion: .failure(MyError.test))
}

example(of: "PassthroughtSubject") {
    let subject = PassthroughSubject<String, Never>()
    subject
        .sink { str in
            print(str)
        }
        .store(in: &subscriptions)
    
    
    subject.send("Hello")
    subject.send("World")
    
    subject.send(completion: .finished)
    
    subject.send("Still There?")
}

example(of: "Future") {
    func futureIncrement(
        integer : Int ,
        afterDelay delay: TimeInterval) -> Future<Int,Never>{
        
            Future<Int,Never> { promise in
                print("Original")
                DispatchQueue.global().asyncAfter(deadline : .now() + delay) {
                    promise(.success(integer + 1))
                }
            }
    }
    
    let future = futureIncrement(integer: 1, afterDelay: 3)
    future
        .sink(receiveCompletion:{ print($0)},
              receiveValue: { print($0) }
        )
        .store(in : &subscriptions)
    
//    future
//      .sink(receiveCompletion: { print("Second", $0) },
//            receiveValue: { print("Second", $0) })
//      .store(in: &subscriptions)
    
}

example(of: "Custom Subscriber") {
    let publisher = (1...6).publisher
    
    final class IntSubscriber : Subscriber {
        typealias Input = Int
        typealias Failure = Never
        
        func receive(subscription: Subscription) {
            print("구독을 시작합니다.")
            //subscription.request(.unlimited)
            subscription.request(.max(3))
        }
        
        func receive(_ input: Int) -> Subscribers.Demand {
         
                print("Received value : \(input)")
                return .none
            //return .unlimited
        }
        
        func receive(completion: Subscribers.Completion<Never>) {
            print("Received  completion", completion)
        }
    }
    
    let subscriber = IntSubscriber()
    
    publisher.subscribe(subscriber)
    
    
}

example(of: "assgin(to:)") {
    class SomeObject {
        @Published var value = 0
    }
    
    let object = SomeObject()
    object.$value
        .sink {
            print($0)
        }

    (0..<10).publisher
        .assign(to: &object.$value)
}

example(of: "publisher and subscriber") {
    let center = NotificationCenter.default
    let myNotification = Notification.Name("MyNotification")
    
    let publisher = center.publisher(for: myNotification, object: nil)
    
    let subscription = publisher
        .print()
        .sink { _ in
            print("Notification received from a publisher")
        }
    
    center.post(name: myNotification, object: nil)
    
    subscription.cancel()
}

example(of: "Just") {
    let just = Just("Hello world!")
    just
        .sink(
          receiveCompletion: {
            print("Received completion", $0)
        },
          receiveValue: {
            print("Received value", $0)
        })
        .store(in: &subscriptions)
}

example(of: "assing(to:on:)") {
    class SomeObject {
        var value:String = "" {
            didSet {
                print(value)
            }
        }
    }
    
    let object = SomeObject()
    
    ["hello", "world"].publisher
        .assign(to: \.value, on: object)
        .store(in: &subscriptions)
}




example(of: "CurrentValueSubject") {
    let subject = CurrentValueSubject<Int, Never>(0)
    subject
        .print()
        .sink(receiveValue: { print($0)})
        .store(in: &subscriptions)
    
    print(subject.value)
    subject.send(1)
    subject.send(2)
    
    print(subject.value)
    
    subject.send(completion: .finished)
    
    
}

example(of: "Type erasure") {
    
    let subject = PassthroughSubject<Int, Never>()
    
    let publisher = subject.eraseToAnyPublisher()
    
    publisher
        .sink(receiveValue: { print($0)})
        .store(in: &subscriptions)
    
    subject.send(1)
    
}
//

example(of: "Collect") {
    ["A","B","C","D"].publisher
        .collect(2)
        .sink(receiveCompletion: { print($0) },
              receiveValue: { print($0)})
        .store(in: &subscriptions)
    
}

example(of: "map") {
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    [123,4,56].publisher
        .map {
            formatter.string(for: NSNumber(integerLiteral: $0)) ?? ""
        }
        .sink(receiveCompletion: { print($0) },
              receiveValue: { print($0)})
        .store(in: &subscriptions)
}

example(of: "replaceNil") {
    ["A","B",nil,"C"].publisher
        .replaceNil(with: "-")
        .map { $0!}
        .sink(receiveCompletion: { print($0) },
              receiveValue: { print($0)})
        .store(in: &subscriptions)
}

example(of: "replaceEmpty(with:)") {
    let empty = Empty<Int, Never>()
    
    empty
        .replaceEmpty(with: 1)
        .sink { value in
            print(value)
        }
        .store(in: &subscriptions)
}

example(of: "scan") {
    
    var dailyGainLoss: Int { .random(in: -10...10)}
    let august2019 = (0..<22)
        .map { _ in dailyGainLoss }
        .publisher
    august2019
        .scan(50) { latest, current in
            print("latest:" , latest)
            print("current:" , current)
            return max(0, latest + current)
            
        }
        .sink { value in
            print(value)
        }
        .store(in: &subscriptions)
}

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

example(of: "Just") {
    let just = Just("Hello World")
    _ = just.sink(
        receiveCompletion: { value in
        print("receive completion:\(value)")
    }, receiveValue : { value in
        print("receive value: \(value)")
    }
    ) //sink end
    
    _ = just.sink(
        receiveCompletion: { value in
        print("(another) receive completion:\(value)")
    }, receiveValue : { value in
        print("(another) receive value: \(value)")
    }
    ) //sink end
}

//checkbox 와 UIKit 에서 유용하게 사용한다는 데?
example(of: "assing(to:on:)") {
    class SomeObject {
        var value : String = ""  {
            didSet {
                print(value)
            }
        }
    }
    
    let object = SomeObject()
    let publisher = ["Hello", "World"].publisher
    _ = publisher
        .assign(to : \.value , on:object )
}

 */

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
