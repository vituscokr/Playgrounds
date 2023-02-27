//: [Previous](@previous)

import Foundation

import Combine

var greeting = "Hello, playground"

/*
 
 참고 : https://www.vadimbulavin.com/swift-combine-framework-tutorial-getting-started/
 
let publisher = Just(1)

publisher.sink(receiveCompletion: { _ in
    print("finished")
}, receiveValue: { value in
    print(value)
})


let subject = PassthroughSubject<String, Never>()

subject.sink(receiveCompletion: { _ in
    print("finished")
}, receiveValue: { value in
        print(value)
})

subject.send("Hello")
subject.send("World")
subject.send(completion: .finished)
 let current = CurrentValueSubject<Int, Never>(1)

 current.sink { value in
     print("sink")
     print(value)
     
 }

 print(current.value)

 current.send(2)

 print(current.value)
 
*/

/*
Subject LifeStyle
1. 구독자가 발행자가 subscribe<S>(S)로 연결
2. 발행자는 구독의  receive<S>(subscriber: S) 호출
3. 발행자는 구독자의 구독요청을 receive(subscription:) 로 확인
 4. 구독자는 구독요청 request(:)
 5. 발행자는 구독자 eceive(_:) 를 호출하도록 값을 보낸다.
 7. 구독의 완료되어진다. (취소나 완료를 통해)
 
 구독자는 AnyCancellable protocol 을 따른다.
 */
/*
let subject = PassthroughSubject<Int, Never> ()

let token = subject
    .print()
    .sink(receiveValue: {
        print("received by subscriber: \($0)")
    })


subject.send(1)
*/
/*
Chaining Publishers with Operators
 
오퍼레이터(Operators) 는 발행자에서 호출되고 다른 발행자를 반환하는 특수 메서드입니다.
이를 통해 차례로 적용하여 체인을 만들 수 있습니다. 각 오퍼레이터(Operators)는 이전 오퍼레이터(Operators)가 반환한 발행자를 변환합니다.
*/
struct Repository:Codable {
    var id:Int
}

let url = URL(string: "https://api.github.com/users/V8tr/repos")!

let token = URLSession.shared.dataTaskPublisher(for: url)
    .map {
        $0.data
    }
    .decode(type: [Repository].self, decoder: JSONDecoder())
    .sink(receiveCompletion: { completion in
        print(completion)
    }, receiveValue: { repositories in
        print("V8tr has \(repositories.count) repositories")
        
    })








//: [Next](@next)
