//
//  SetCardGameViewModel.swift
//  Set-Card-Game
//
//  Created by William Ye on 2021-04-14.
//

import SwiftUI

class SetCardGameViewModel: ObservableObject {
    @Published private var model: SetGameModel<CardShape, CardShade, CardColor> = createGameModel()
    
    
    private static func createGameModel() -> SetGameModel<CardShape, CardShade, CardColor>{
        return SetGameModel<CardShape, CardShade, CardColor>(){ cardIndex in
            return (gameCards[cardIndex].numShapes, gameCards[cardIndex].cShape, gameCards[cardIndex].cShade, gameCards[cardIndex].cColor)
        }
    }
    
    var cardsOnBoard: Array<SetGameModel<CardShape, CardShade, CardColor>.Card>{
        model.cardsOnBoard
    }
    
    func dealBoard(){
        model.dealBoard()
    }
    
    func resetGame() {
        model.resetGame(){ cardIndex in
            return (gameCards[cardIndex].numShapes, gameCards[cardIndex].cShape, gameCards[cardIndex].cShade, gameCards[cardIndex].cColor)
        }
        model.dealBoard()
    }
    
    
    func dealMoreCards() {
        model.dealMoreCards()
    }
    
    func choose(_ card: SetGameModel<CardShape, CardShade, CardColor>.Card) {
        model.choose(card: card)
    }
}
