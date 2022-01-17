//: [Previous](@previous)

import UIKit

var greeting = "Hello, playground"


//https://www.avanderlee.com/swift/asynchronous-operations/

class AsyncOperation :Operation {
    var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
    override var isReady:Bool {
        return super.isReady && state == .ready
    }
    override var isExecuting: Bool {
        return state == .excuting
    }
    override var isFinished :Bool {
        return state == .finished
    }
    
    override var isAsynchronous :Bool {
        return true
    }
    override func main() {
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(1), execute:  {
            
            print("Executing")
        })
    }
    override func start() {
        if isCancelled {
            state = .finished
            return
        }
        main()
        state = .excuting
    }
    
    override func cancel() {
        state = .finished
    }
}
extension AsyncOperation {
    
    enum State : String {
        case ready, excuting , finished
        
        fileprivate var keyPath: String {
            return "is\(rawValue.capitalized)"
        }
    }
    

}


let operation = AsyncOperation()

queue.addOperations([operation], waitUntilFinished: true)

print("Operation Finished")

//: [Next](@next)
