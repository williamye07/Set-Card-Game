//
//  gameCards.swift
//  Set-Card-Game
//
//  Created by William Ye on 2021-04-14.
//

import Foundation


enum CardShape: CaseIterable {
    case circle, rectangle, oval
}

enum CardShade: CaseIterable {
    case solid, light, open
}

enum CardColor: CaseIterable {
    case green, red, purple
}

struct cardDescript {
    let numShapes: Int
    let cShape: CardShape
    let cShade: CardShade
    let cColor: CardColor
}

func createGameCards() -> Array<cardDescript> {
    var arr: Array<cardDescript> = []
    
    for i in 1..<4{
        for shape in CardShape.allCases{
            for shade in CardShade.allCases{
                for color in CardColor.allCases{
                    arr.append(cardDescript(numShapes: i, cShape: shape, cShade: shade, cColor: color))
                }
            }
        }
    }
    return arr
}


let gameCards = createGameCards()




