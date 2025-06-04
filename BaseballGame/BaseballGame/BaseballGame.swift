//
//  BaseballGame.swift
//  BaseballGame
//
//  Created by 김이든 on 6/4/25.
//

struct BaseballGame {
    func start() {
        let answer = makeAnswer()
        print(answer)
    }
    
    func makeAnswer() -> [Int] {
        return Array(Array(1...9).shuffled().prefix(3))
    }
}
