import Foundation

public class  GameTable {
    public var deck:Deck
    var holder : [Card?] = []
    
    public init() {
        deck = Deck()
        
        for _ in 0...24 {
            holder.append(nil)
        }
    }
    
    
    public func  place(to holderIndex:Int) {
        let card = self.deck.cards.removeFirst()
        self.holder[holderIndex] = card
    }
    
    public func show() {
        for (i, card) in self.holder.enumerated() {
            guard let card = card else {
                return
            }
            print("\(i): \(card.description) ")
            
        }
    }
}
