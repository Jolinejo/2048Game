//
//  File.swift
//  2048Game
//
//  Created by Maryiam Ajlan on 07/09/2023.
//

import Foundation
import SwiftUI


class NumbersGame: ObservableObject {
    //static let food =
    
    static func createGame (_ table_: Array<[Int]>) -> Game
    {
        
        var num1 = Int.random(in: 0...10)
        if num1 == 10 {
            num1 = 4
        } else {
            num1 = 2
        }
        var num2 = Int.random(in: 0...10)
        if num2 == 10 {
            num2 = 4
        } else {
            num2 = 2
        }
        
        var randomPos: Array<(Int, Int)> = []
        
        while randomPos.count < 2 {
            let pos = (Int.random(in: 0...3), Int.random(in: 0...3))
            if !randomPos.contains(where: { $0 == pos }) {
                randomPos.append(pos)
            }
        }
        var table_modified = table_
        table_modified[randomPos[0].0][randomPos[0].1] = num1
        table_modified[randomPos[1].0][randomPos[1].1] = num2
        return Game(board: table_modified)
    }
    
    static var numbers = [
    [0,0,0,0],
    [0,0,0,0],
    [0,0,0,0],
    [0,0,0,0]
    ]
    
    
    @Published private var model: Game = createGame(numbers)
    
    var cards: Array<[Game.Card]> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    var running: Bool {
        get {
            model.running
        }
        set {
            model.running = newValue
        }
    }
    
   var win: Bool {
            get {
                model.win
            }
            set {
                model.win = newValue
            }
    }
    
    //MARK: - intent(s)
    func up () {
        model.up()
    }
    func right () {
        model.right()
    }
    func down () {
        model.down()
    }
    func left () {
        model.left()
    }
    
    func newGame () {
        model = NumbersGame.createGame(NumbersGame.numbers)
    }
    
}
