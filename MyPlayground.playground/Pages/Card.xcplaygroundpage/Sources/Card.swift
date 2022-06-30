import Foundation

public struct Card {
    let suit : Suit
    /////1 for A, 13 for K,12 for Q,11 for J
    let rank : Int
    
    public init(suit: Suit, rank : Int) {
        self.suit = suit
        self.rank = rank
    }
    
    
}

extension Card : CustomStringConvertible {
    public var description : String {
        
        return suit.description + "\(rank)"
    }
}
