import Foundation

public struct Deck {
    
   public var  cards : [Card]
    
    public init() {
        self.cards = [Card]()
        Suit.allCases.map {
            for i in 1...13 {
                self.cards.append(Card(suit: $0, rank: i))
            }
        }
        
        cards.shuffle()
    }
    
    public var count: Int {
        return cards.count
    }
    
    public var isEmpty : Bool {
        return count == 0 ? true : false 
    }
}
