//
//  ContentView.swift
//  Memorize
//
//  Created by Maryiam Ajlan on 27/01/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: NumbersGame
    
    func makeGame(){
        viewModel.newGame()
    }
    
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
            .sheet(isPresented: $viewModel.win) {
                SecondView(win: $viewModel.win, action: makeGame)
                    .presentationDetents([.medium, .large])
                   }
            .alert(isPresented: $viewModel.running) {
                Alert(title: Text("You Lost"), message: Text("Game Over!"), dismissButton: Alert.Button.default(
                    Text("New Game"), action: viewModel.newGame
                ))
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

struct SecondView: View {
    
    @State private var offset: CGFloat = 1000
    @Binding var win: Bool
    let action: () -> ()
    
    var body: some View {
        ZStack{
            Color(.black)
                .opacity(0.5)
            VStack {
                Text("You Win!")
                    .font(.title2)
                    .bold()
                    .padding()
                
                Text("New Game?")
                    .font(.body)
                
                Button {
                    action()
                    close()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color("UV"))
                        Text("Yes")
                            .font(.title3)
                            .padding()
                    }
                    .padding()
                }
                .padding()
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay {
                VStack {
                    HStack{
                        Spacer()
                        Button {
                            close()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title2)
                                .fontWeight(.medium)
                        }
                        .tint(.black)
                    }
                    Spacer()
                }
                .padding()
            }
            .shadow(radius: 20)
            .padding(30)
            .offset(x: 0, y: offset)
            .onAppear {
                withAnimation(.spring()) {
                    offset = 0
                }
            }
        }
        
    }
    
    func close() {
        withAnimation(.spring()) {
            offset = 1000
            win = false
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
                .font(.title)
            
        }
    }
}



















