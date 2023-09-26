//
//  Game.swift
//  2048Game
//
//  Created by Maryiam Ajlan on 07/09/2023.
//

import Foundation
import SwiftUI

struct Game {
    
    private (set) var cards: Array<[Card]>
        
    private (set) var score: Int = 0
    
    public var running: Bool = false
    
    public var win: Bool = false
    
    private var wonBefore = 0
    
    private var numToColor = [(0, Color("PB")), (2, Color("UV")), (4, Color("Glau")), (8, Color("Wis")),
                              (16, Color("SX")), (32, Color("TT")), (64, Color("SF")), (128, Color("TH")),
                              (256, Color("TH")), (512, Color("FH")), (1024, Color("T")), (2048, Color("EI"))]
    
    private (set) var empty: Array<Int>
    
    func get_color(_ card: Card) -> Color {
        
        var col: Color? = nil
        for num in numToColor {
            if num.0 == card.content {
                col = num.1
                break
            }
        }
        if (col == nil) {
            col = Color("EI")
        }
        return col!
    }
    
    mutating func gen_new() {
        var num1 = Int.random(in: 0...10)
        if num1 == 10 {
            num1 = 4
        } else {
            num1 = 2
        }
        let id_to_change = empty.shuffled()[0]
        empty = empty.filter(){$0 != id_to_change}
        var new_arr = [[Card]]()
        
        for var row in cards {
            for  i in stride(from: 4 - 1, to: -1, by: -1) {
                if row[i].id ==  id_to_change {
                    row[i].content = num1
                    row[i].background = get_color(row[i])
                }
            }
            new_arr.append(row)
        }
        cards = new_arr
        if empty.isEmpty {
            print("HERE")
            var flag = true
            for i in (0...3){
                for j in (0...3){
                    if j != 3 && cards[i][j].content == cards[i][j+1].content {
                        flag = false
                    }
                    if i != 3 && cards[i][j].content == cards[i+1][j].content {
                        flag = false
                    }
                }
            }
            print(flag)
            running = flag
        }
    }
    
    mutating func up() {
        var flag = false
        var zeros = true
        for k in (0...3) {
            zeros = true
            while zeros {
                zeros = false
                for i in stride(from: 4 - 1, to: 0, by: -1) {
                    for j in stride(from: i-1, to: -1, by: -1) {
                        if cards[j][k].content == 0 && cards[j+1][k].content != 0 {
                            flag = true
                            zeros = true
                            cards[j][k].content = cards[j+1][k].content
                            cards[j+1][k].content = 0
                            cards[j][k].background = get_color(cards[j][k])
                            cards[j+1][k].background = get_color(cards[j+1][k])
                            empty = empty.filter(){$0 != cards[j][k].id}
                            empty.append(cards[j+1][k].id)
                        }
                    }
                }
            }
            for i in stride(from: 0, to: 4 - 1, by: 1) {
                if cards[i+1][k].content == cards[i][k].content && cards[i+1][k].content != 0 {
                    flag = true
                    cards[i][k].content = cards[i][k].content + cards[i+1][k].content
                    if cards[i][k].content == 2048 {
                        if (wonBefore == 0) {
                            wonBefore += 1
                            win = true
                        }
                            
                    }
                    cards[i+1][k].content = 0
                    cards[i][k].background = get_color(cards[i][k])
                    cards[i+1][k].background = get_color(cards[i+1][k])
                    score += cards[i][k].content
                    empty.append(cards[i+1][k].id)
                }
            }
            zeros = true
            while zeros {
                zeros = false
                for i in stride(from: 4 - 1, to: 0, by: -1) {
                    for j in stride(from: i-1, to: -1, by: -1) {
                        if cards[j][k].content == 0 && cards[j+1][k].content != 0 {
                            flag = true
                            zeros = true
                            cards[j][k].content = cards[j+1][k].content
                            cards[j+1][k].content = 0
                            cards[j][k].background = get_color(cards[j][k])
                            cards[j+1][k].background = get_color(cards[j+1][k])
                            empty = empty.filter(){$0 != cards[j][k].id}
                            empty.append(cards[j+1][k].id)
                        }
                    }
                }
            }
        }
        if flag {
            gen_new()
        }
    }
    mutating func down() {
        var flag = false
        var zeros = true
        for k in (0...3) {
            zeros = true
            while zeros {
                zeros = false
                for i in stride(from: 0, to: 4, by: 1) {
                    for j in stride(from: i+1, to: 4, by: 1) {
                        if cards[j][k].content == 0 && cards[j-1][k].content != 0 {
                            flag = true
                            zeros = true
                            cards[j][k].content = cards[j-1][k].content
                            cards[j-1][k].content = 0
                            cards[j][k].background = get_color(cards[j][k])
                            cards[j-1][k].background = get_color(cards[j-1][k])
                            empty = empty.filter(){$0 != cards[j][k].id}
                            empty.append(cards[j-1][k].id)
                        }
                    }
                }
            }
            for i in stride(from: 4 - 1, to: 0, by: -1) {
                if cards[i][k].content == cards[i-1][k].content && cards[i][k].content != 0 {
                    flag = true
                    cards[i][k].content = cards[i][k].content + cards[i-1][k].content
                    if cards[i][k].content == 2048 {
                        if (wonBefore == 0) {
                            wonBefore += 1
                            win = true
                        }
                    }
                    cards[i-1][k].content = 0
                    cards[i][k].background = get_color(cards[i][k])
                    cards[i-1][k].background = get_color(cards[i-1][k])
                    score += cards[i][k].content
                    empty.append(cards[i-1][k].id)
                }
            }
            zeros = true
            while zeros {
                zeros = false
                for i in stride(from: 0, to: 4, by: 1) {
                    for j in stride(from: i+1, to: 4, by: 1) {
                        if cards[j][k].content == 0 && cards[j-1][k].content != 0 {
                            flag = true
                            zeros = true
                            cards[j][k].content = cards[j-1][k].content
                            cards[j-1][k].content = 0
                            cards[j][k].background = get_color(cards[j][k])
                            cards[j-1][k].background = get_color(cards[j-1][k])
                            empty = empty.filter(){$0 != cards[j][k].id}
                            empty.append(cards[j-1][k].id)
                        }
                    }
                }
            }
        }
        if flag {
            gen_new()
        }
    }
   
    mutating func left() {
        var flag = false
        var zeros = true
        var new_arr = [[Card]]()
        for var row in cards {
            zeros = true
            while zeros {
                zeros = false
                for i in stride(from: 4 - 1, to: 0, by: -1) {
                    for j in stride(from: i-1, to: -1, by: -1) {
                        if row[j].content == 0 && row[j+1].content != 0 {
                            flag = true
                            zeros = true
                            row[j].content = row[j+1].content
                            row[j+1].content = 0
                            row[j].background = get_color(row[j])
                            row[j+1].background = get_color(row[j+1])
                            empty = empty.filter(){$0 != row[j].id}
                            empty.append(row[j+1].id)
                        }
                    }
                }
            }
            for i in stride(from: 0, to: 4 - 1, by: 1) {
                if row[i+1].content == row[i].content && row[i+1].content != 0 {
                    flag = true
                    row[i].content = row[i].content + row[i+1].content
                    if row[i].content == 2048 {
                        if (wonBefore == 0) {
                            wonBefore += 1
                            win = true
                        }
                            
                    }
                    row[i+1].content = 0
                    row[i].background = get_color(row[i])
                    row[i+1].background = get_color(row[i+1])
                    score += row[i].content
                    empty.append(row[i+1].id)
                }
            }
            zeros = true
            while zeros {
                zeros = false
                for i in stride(from: 4 - 1, to: 0, by: -1) {
                    for j in stride(from: i-1, to: -1, by: -1) {
                        if row[j].content == 0 && row[j+1].content != 0 {
                            flag = true
                            zeros = true
                            row[j].content = row[j+1].content
                            row[j+1].content = 0
                            row[j].background = get_color(row[j])
                            row[j+1].background = get_color(row[j+1])
                            empty = empty.filter(){$0 != row[j].id}
                            empty.append(row[j+1].id)
                        }
                    }
                }
            }
            new_arr.append(row)
        }
        cards = new_arr
        if flag {
            gen_new()
        }
    }
    mutating func right() {
        var flag = false
        var zeros = true
        var new_arr = [[Card]]()
        for var row in cards {
            zeros = true
            while zeros {
                zeros = false
                for i in stride(from: 0, to: 4, by: 1) {
                    for j in stride(from: i+1, to: 4, by: 1) {
                        if row[j].content == 0 && row[j-1].content != 0 {
                            flag = true
                            zeros = true
                            row[j].content = row[j-1].content
                            row[j-1].content = 0
                            row[j].background = get_color(row[j])
                            row[j-1].background = get_color(row[j-1])
                            empty = empty.filter(){$0 != row[j].id}
                            empty.append(row[j-1].id)
                        }
                    }
                }
            }
            for i in stride(from: 4 - 1, to: 0, by: -1) {
                if row[i].content == row[i-1].content && row[i].content != 0 {
                    flag = true
                    row[i].content = row[i].content + row[i-1].content
                    if row[i].content == 2048 {
                        if (wonBefore == 0) {
                            wonBefore += 1
                            win = true
                        }
                            
                    }
                    row[i-1].content = 0
                    row[i].background = get_color(row[i])
                    row[i-1].background = get_color(row[i-1])
                    score += row[i].content
                    empty.append(row[i-1].id)
                }
            }
            zeros = true
            while zeros {
                zeros = false
                for i in stride(from: 0, to: 4, by: 1) {
                    for j in stride(from: i+1, to: 4, by: 1) {
                        if row[j].content == 0 && row[j-1].content != 0 {
                            flag = true
                            zeros = true
                            row[j].content = row[j-1].content
                            row[j-1].content = 0
                            row[j].background = get_color(row[j])
                            row[j-1].background = get_color(row[j-1])
                            empty = empty.filter(){$0 != row[j].id}
                            empty.append(row[j-1].id)
                        }
                    }
                }
            }
            new_arr.append(row)
        }
        cards = new_arr
        if flag {
            gen_new()
        }
    }
    
    
    init(board: [[Int]]) {
        cards = [[Card]]()
        empty = [Int]()

        var i = 0
        for row in board{
            var cardsRow = Array<Card>()
            for elem in row {
                i += 1
                var col: Color? = nil
                for num in numToColor {
                    if num.0 == elem {
                        col = num.1
                        break
                    }
                }
                if col == nil {
                    col = Color("Wis")
                }
                if elem == 0 {
                    empty.append(i)
                }
                cardsRow.append(Card(content: elem, background: col!, id: i))
                
            }
            cards.append(cardsRow)
    }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: Int
        var background: Color
        var wasSeen: Bool = false
        var id: Int
    }
}

