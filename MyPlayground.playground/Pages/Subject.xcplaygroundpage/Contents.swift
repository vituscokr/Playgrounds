//: [Previous](@previous)

import Foundation
import SwiftUI
import Combine
// Subject는 Subscriber이며 동시에 Publisher이며 Value이다.
// Subject
//  PassThroughSubject
//  CurrentValueSubject
//참고 주소
//https://sujinnaljin.medium.com/combine-subject-a974340cb582
//https://velog.io/@devapploper/Swift-Combine-Subject-Basics
//https://www.swiftpal.io/articles/combine-creating-your-own-publishers-with-passthroughsubject-and-currentvaluesubject

let publisher = [1,2,3].publisher
let passThroughSubject = PassthroughSubject<Int, Never>()

// 구독자
let anySubscriber = AnySubscriber(passThroughSubject)

publisher.receive(subscriber: anySubscriber)

// 발행자
passThroughSubject.sink { value in
    print(value)
    
}

//CurrentValueSubject 는 초기에 값을 담을수 있다.
let currentSubject = CurrentValueSubject<Int, Never> (99)

//PassThroughSubject 는 생성시에는 초기값을 담을 수 없다.
let passthroughSubject = PassthroughSubject<Int, Never>()




let message = "이런 느낌 처음이야"
let currentValueSubject = CurrentValueSubject<String,Never> (message)

let subscriber = currentValueSubject
    .sink {
        print($0)
    }


currentValueSubject.send("계속 하게 되지?")


currentValueSubject.send("종료하기전에 하나 더 ")
currentValueSubject.send(completion:.finished)

currentValueSubject.send("종료되고 나서")


print("Current Value: \(currentValueSubject.value)")

let arrayPublisher = ["H","E","L","L","O"].publisher
let stringPublisher = "World".publisher

let arrayCancellable = arrayPublisher.sink { value in
    // Process value
    print(value)
}

let stringCancellable = stringPublisher.sink { value in
    // Process value
    
    print(value)
}



let passThroughSubjectTest = PassthroughSubject<String, Never>()
let subscriberTest = passThroughSubjectTest
                 .sink { message in
                   print(message)
         }


let messageA = "일등"
let messageB = "이등"

passThroughSubjectTest.send(messageA)
passThroughSubjectTest.send(messageB)
//: [Next](@next)
