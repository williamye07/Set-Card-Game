//
//  CardView.swift
//  Set-Card-Game
//
//  Created by William Ye on 2021-04-15.
//

import SwiftUI

struct CardView: View {
    var card: SetGameModel<CardShape, CardShade, CardColor>.Card
    let color: Color
    let numShapes: Int
    let opacity: Double
    let shape: CardShape
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                if card.isMatched{
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(Color.green)
                } else {
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(card.isSelected ? Color.black : color, lineWidth: 3)
                    VStack {
                        ForEach(0..<numShapes, id: \.self){ _ in
                            if shape == .circle {
                                CircleView(color: color, opacity: opacity, width: geometry.size.width * 0.25, height: geometry.size.height * 0.25)
                            } else if shape == .oval {
                                OvalView(color: color, opacity: opacity, width: geometry.size.width * 0.75, height: geometry.size.height * 0.13)
                            } else {
                                RectangleView(color: color, opacity: opacity, width: geometry.size.width * 0.75, height: geometry.size.height * 0.13)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    init(card: SetGameModel<CardShape, CardShade, CardColor>.Card){
        
        self.card = card
        
        numShapes = card.numShapes
        shape = card.shape
        switch card.color{
        case .green:
            color = Color.green
        case .purple:
            color = Color.purple
        case .red:
            color = Color.red
        }
        
        switch card.shade{
        case .open:
            opacity = 0
        case .light:
            opacity = 0.4
        case .solid:
            opacity = 1
        }
        
        
    }
}
//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
