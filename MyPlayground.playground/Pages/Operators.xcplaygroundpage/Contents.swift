//: [Previous](@previous)
import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()




example(of: "collect") {
    
    ["A","B","C","D","E"].publisher
        .collect(2)
        .sink(
            receiveCompletion: {print($0)},
            receiveValue: {print($0)}
        )
        .store(in: &subscriptions)
}

example(of: "map") {
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    
    [113, 4, 56].publisher
        .map {
            formatter.string(from: NSNumber(integerLiteral: $0)) ?? ""
        }
        .sink(receiveValue: { print($0)})
        .store(in: &subscriptions)
}


example(of: "mapping key paths") {
    let publisher = PassthroughSubject<Coordinate, Never>()
    
    publisher
        .map(\.x, \.y)
        .sink(
            receiveValue : { x, y in
                print(
                "This coordinate at (\(x), \(y) is in a quadrant)",
                quadantOf(x: x, y: y)
                )
                
            }
        )
        .store(in : &subscriptions)
    
    publisher.send(Coordinate(x: 10, y: -8))
    
    publisher.send(Coordinate(x: 0, y: 5))
    
}

example(of: "tryMap") {
    Just("Dictionry name that does not exist")
        .tryMap {
            try FileManager.default.contentsOfDirectory(atPath: $0)
        }
        .sink(
            receiveCompletion: {
                print("receiveCompletion")
                print( $0)},
            receiveValue : {
                print("receiveValue")
                print($0)}
        )
        .store(in : &subscriptions)
}

example(of: "flatMap") {
    func decode(_ codes:[Int]) -> AnyPublisher<String, Never> {
        Just(
            codes
                .compactMap { code in
                    guard (32...255).contains(code) else {
                        return nil
                    }
                    return String(UnicodeScalar(code) ?? " " )
                }
                .joined()
        )
        .eraseToAnyPublisher()
    }
    
    [72,101, 108, 108, 111,44, 32, 87, 111, 114, 108, 100, 33]
        .publisher
        .collect()
        .flatMap(decode)
        .sink(receiveValue: { print($0)})
        .store(in: &subscriptions)
}

example(of: "replaceNil") {
    ["A", nil, "C"].publisher
        .eraseToAnyPublisher()
        .replaceNil(with: "-")
        .sink(
            receiveValue: { print($0)}
        )
        .store(in: &subscriptions)
}

example(of: "replaceEmpty(with:)") {
    
    let empty = Empty<Int, Never>()
    empty
        .replaceEmpty(with:1)
        .sink(
            receiveCompletion: { print($0) },
            receiveValue: { print($0)}
        )
        .store(in: &subscriptions)
    
}

example(of: "scan") {
    var dailyGainLoss : Int { .random(in : -10...10)}
    let august2019 = (0..<22)
        .map { _ in dailyGainLoss}
        .publisher
    
    print(august2019)
    
    august2019
        .scan(50) { latest, current in
            max(0, latest + current)
        }
        .sink( receiveValue : { value in
            print(value)
        })
        .store(in : &subscriptions)
}
//: [Next](@next)
