import Foundation

public enum Suit : CaseIterable {
    case clubs
    case diamonds
    case hearts
    case spades
}

extension Suit : CustomStringConvertible {
    public var description: String {
        switch(self) {
        case .clubs :
            return "♧"
        case .diamonds:
            return "♢"
        case .hearts:
            return "♡"
        case .spades:
            return "♤"
        }
    }
}




