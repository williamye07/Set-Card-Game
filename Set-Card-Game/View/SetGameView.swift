//
//  ContentView.swift
//  Set-Card-Game
//
//  Created by William Ye on 2021-04-13.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel = SetCardGameViewModel()
    
    var columns = [GridItem(.flexible(minimum: 50)),
                   GridItem(.flexible(minimum: 50)),
                   GridItem(.flexible(minimum: 50)),
                   GridItem(.flexible(minimum: 50)),]
    
        var body: some View {
            VStack{
                
                HStack{
                    Button("New Game"){
                        withAnimation(.easeIn(duration: 0.2)){
                            viewModel.resetGame()
                        }
                        
                    }.padding()
                    Button("Deal 3 More Cards"){
                        withAnimation(.easeIn(duration: 0.2)){
                            viewModel.dealMoreCards()
                        }
                    }.padding()
                }
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)

                .padding()
                ScrollView {
                    LazyVGrid(columns: columns){
                        ForEach(viewModel.cardsOnBoard){ item in
                            if !item.isRemove && item.isDisplay{
                                CardView(card: item)
                                    .aspectRatio(4/7, contentMode: .fill)
                                
                                    .onTapGesture {
                                        withAnimation(.linear(duration: 0.2)){
                                            viewModel.choose(item)
                                        }
                                        
                                    }
                                    .transition(.offset(x: CGFloat.random(in: -1000...1000), y:CGFloat.random(in: -1000...1000)))
                            }
                            
                        }
                    }.padding()
                }
                .onAppear{
                    withAnimation(.linear(duration: 0.2)){
                        viewModel.dealBoard()
                    }
                }
                
            }
            
        
        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            SetGameView()
                .previewDevice("iPhone 11")
        
    }
}
