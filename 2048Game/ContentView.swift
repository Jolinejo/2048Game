//
//  ContentView.swift
//  Memorize
//
//  Created by Maryiam Ajlan on 27/01/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: NumbersGame

    var body: some View {
        VStack{
            Text("2048")
                .font(.largeTitle)
            Text("Score is: \(viewModel.score)")
                .font(.title)
            ScrollView {
                LazyVGrid (columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach (viewModel.cards[0]) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
                                .onEnded { value in
                                    let horizontalAmount = value.translation.width
                                    let verticalAmount = value.translation.height
                                    
                                    if abs(horizontalAmount) > abs(verticalAmount) {
                                        if horizontalAmount < 0 {
                                            withAnimation {
                                                viewModel.left()
                                            }
                                        } else {
                                            withAnimation {
                                                viewModel.right()
                                            }
                                        }
                                    } else {
                                        if verticalAmount < 0 {
                                            withAnimation {
                                                viewModel.up()
                                            }
                                        } else {
                                            withAnimation {
                                                viewModel.down()
                                            }
                                        }
                                    }
                                })
                    }
                    ForEach (viewModel.cards[1]) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
                                .onEnded { value in
                                    let horizontalAmount = value.translation.width
                                    let verticalAmount = value.translation.height
                                    
                                    if abs(horizontalAmount) > abs(verticalAmount) {
                                        if horizontalAmount < 0 {
                                            withAnimation {
                                                viewModel.left()
                                            }
                                        } else {
                                            withAnimation {
                                                viewModel.right()
                                            }
                                        }
                                    } else  {
                                        if verticalAmount < 0 {
                                            withAnimation {
                                                viewModel.up()
                                            }
                                        } else {
                                            withAnimation {
                                                viewModel.down()
                                            }
                                        }
                                    }
                                })
                    }
                    ForEach (viewModel.cards[2]) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
                                .onEnded { value in
                                    let horizontalAmount = value.translation.width
                                    let verticalAmount = value.translation.height
                                    
                                    if abs(horizontalAmount) > abs(verticalAmount) {
                                        if horizontalAmount < 0 {
                                            withAnimation {
                                                viewModel.left()
                                            }
                                        } else {
                                            withAnimation {
                                                viewModel.right()
                                            }
                                        }
                                    } else  {
                                        if verticalAmount < 0 {
                                            withAnimation {
                                                viewModel.up()
                                            }
                                        } else {
                                            withAnimation {
                                                viewModel.down()
                                            }
                                        }
                                    }
                                })
                    }
                    ForEach (viewModel.cards[3]) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
                                .onEnded { value in
                                    let horizontalAmount = value.translation.width
                                    let verticalAmount = value.translation.height
                                    
                                    if abs(horizontalAmount) > abs(verticalAmount) {
                                        if horizontalAmount < 0 {
                                            withAnimation {
                                                viewModel.left()
                                            }
                                        } else {
                                            withAnimation {
                                                viewModel.right()
                                            }
                                        }
                                    } else  {
                                        if verticalAmount < 0 {
                                            withAnimation {
                                                viewModel.up()
                                            }
                                        } else {
                                            withAnimation {
                                                viewModel.down()
                                            }
                                        }
                                    }
                                })
                    }
                }
            }
            .scrollDisabled(true)
            .padding(.horizontal)
            .alert(isPresented: $viewModel.alert) {
                Alert(title: Text("You Lost"), message: Text("Game Over!"), dismissButton: Alert.Button.default(
                    Text("New Game"), action: viewModel.newGame 
                ))
                    }
            .alert(isPresented: $viewModel.win) {
                Alert(title: Text("You Won!"), message: Text("New Game?"), primaryButton: .default(Text("Yes"), action: viewModel.newGame),
                secondaryButton: .destructive(Text("No")))
                    }
            Spacer()
            newGame
        }
        .font(.largeTitle)
        .padding(.horizontal)
        .foregroundColor(Color("Ras"))
    }
    
    var newGame: some View {
        Button{
            viewModel.newGame()
        } label: {
            VStack {
                Text("New Game")
                    .font(.title2)
                    .padding()
                
            }
        }
    }
    
}

struct CardView: View {
    let card: Game<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            shape.fill(card.background)
            shape.strokeBorder(lineWidth: 3)
            Text(String(card.content))
                .font(.largeTitle)
            
        }
    }
}




















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = NumbersGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
            
    }
}
