//
//  SetGameModel.swift
//  Set-Card-Game
//
//  Created by William Ye on 2021-04-14.
//

import Foundation

struct SetGameModel <T1, T2, T3> where T1: Equatable, T2: Equatable, T3: Equatable {
    private var cards: Array<Card>
    private(set) var cardsOnBoard: Array<Card> = []
    private(set) var selectedCards: Array<Card> = []
    private var deckIndex = 12
    
    
    init(gameCardsFactory: (Int) -> (Int, T1, T2, T3)){
        cards = Array<Card>()
        
        for i in 0..<81{
            let tp = gameCardsFactory(i)
            cards.append(Card(id: i, numShapes: tp.0, shape: tp.1, shade: tp.2, color: tp.3))
        }
        
        cards.shuffle()
    }
    
    mutating func dealBoard() {
        cardsOnBoard = Array(cards[0..<12])
        for i in 0..<12{
            cardsOnBoard[i].isDisplay = true
        }
        print(cards.count)
        
    }
    
    mutating func resetGame(gameCardsFactory: (Int) -> (Int, T1, T2, T3)) {
        cards = Array<Card>()
        
        for i in 0..<81{
            let tp = gameCardsFactory(i)
            cards.append(Card(id: i, numShapes: tp.0, shape: tp.1, shade: tp.2, color: tp.3))
        }
        
        cards.shuffle()
        deckIndex = 12
        selectedCards = []
        print(cards.count)
    }
    
    mutating func dealMoreCards () {
        if deckIndex < cards.count{
            for i in deckIndex..<deckIndex+3{
                cardsOnBoard.append(cards[i])
                cardsOnBoard[i].isDisplay = true
            }
            deckIndex += 3
        }
        
    }
    mutating func removeCard(card: Card){
        for i in 0..<selectedCards.count{
            if selectedCards[i].id == card.id {
                selectedCards.remove(at: i)
                break
            }
        }
    }
    
    mutating func checkMatch(){
        if !((selectedCards[0].numShapes == selectedCards[1].numShapes && selectedCards[1].numShapes == selectedCards[2].numShapes) ||
                (selectedCards[0].numShapes != selectedCards[1].numShapes && selectedCards[1].numShapes != selectedCards[2].numShapes
        && selectedCards[0].numShapes != selectedCards[2].numShapes)) {
            return
        }
        
        if !((selectedCards[0].color == selectedCards[1].color && selectedCards[1].color == selectedCards[2].color) ||
                (selectedCards[0].color != selectedCards[1].color && selectedCards[1].color != selectedCards[2].color
        && selectedCards[0].color != selectedCards[2].color)) {
            return
        }
        
        if !((selectedCards[0].shape == selectedCards[1].shape && selectedCards[1].shape == selectedCards[2].shape) ||
                (selectedCards[0].shape != selectedCards[1].shape && selectedCards[1].shape != selectedCards[2].shape
            && selectedCards[0].shape != selectedCards[2].shape)) {
            return
        }
        
        if !((selectedCards[0].shade == selectedCards[1].shade && selectedCards[1].shade == selectedCards[2].shade) ||
                (selectedCards[0].shade != selectedCards[1].shade && selectedCards[1].shade != selectedCards[2].shade
                && selectedCards[0].shade != selectedCards[2].shade)) {
            return
        }
        
        for i in 0..<3{
            selectedCards[i].isMatched = true
            cardsOnBoard[cardsOnBoard.index(of: selectedCards[i])!].isMatched = true
        }
    }
    
    mutating func choose(card: Card) {
        let cardId = cardsOnBoard.index(of: card)!
        if selectedCards.count < 2 {
            cardsOnBoard[cardId].isSelected = !cardsOnBoard[cardId].isSelected
            if cardsOnBoard[cardId].isSelected {
                selectedCards.append(card)
            } else {
                removeCard(card: card)
            }
        } else if selectedCards.count == 2{
            cardsOnBoard[cardId].isSelected = !cardsOnBoard[cardId].isSelected
            if cardsOnBoard[cardId].isSelected {
                selectedCards.append(card)
                checkMatch()
            } else {
                removeCard(card: card)
            }
        } else if selectedCards.count == 3 {
            if selectedCards[0].isMatched {
                var flag = false
                for i in 0..<3{
                    if card.id == selectedCards[i].id{
                        flag = true
                    }
                    cardsOnBoard[cardsOnBoard.index(of: selectedCards[i])!].isRemove = true
                }
                selectedCards = []
                if !flag {
                    cardsOnBoard[cardId].isSelected = true
                    selectedCards.append(card)
                }
                dealMoreCards()
                
            } else {
                cardsOnBoard[cardsOnBoard.index(of: selectedCards[0])!].isSelected = false
                cardsOnBoard[cardsOnBoard.index(of: selectedCards[1])!].isSelected = false
                cardsOnBoard[cardsOnBoard.index(of: selectedCards[2])!].isSelected = false
                selectedCards = []
                cardsOnBoard[cardId].isSelected = true
                selectedCards.append(card)
            }
        }
        print("card chosen: \(cardsOnBoard[cardId])")
        print("card chosen set: \(selectedCards)")
        print("card chosen set count: \(selectedCards.count)")
    }
    
    
    struct Card: Identifiable {
        var id: Int
        
        var isSelected = false
        var isMatched = false
        var isRemove = false
        var isDisplay = false
        
        let numShapes: Int
        let shape: T1
        let shade: T2
        let color: T3
        
    }
}
