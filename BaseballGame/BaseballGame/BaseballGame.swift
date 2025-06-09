//
//  BaseballGame.swift
//  BaseballGame
//
//  Created by 김이든 on 6/4/25.
//

struct BaseballGame {
    var recordManager = RecordManager() // 기록 관리 인스턴스
    
    mutating func start() {
        print("환영합니다! 원하시는 번호를 입력해주세요\n1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
        
        while true {
            if let input = readLine() {
                switch input {
                case "1":
                    print("< 게임을 시작합니다 >")
                    let trialCount = playGame()
                    recordManager.add(trialCount: trialCount)
                case "2":
                    print("< 게임 기록 보기 >")
                    recordManager.showRecords()
                case "3":
                    print("종료합니다")
                    return
                default:
                    print("*올바르지 않은 입력값입니다*\n1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
                }
            }
        }
    }
    
    // 게임 시작 함수
    func playGame() -> Int {
        let answer = makeAnswer()
        var inputArray: [Int] = []
        var trialCount = 0
        
        print("서로 다른 숫자 3자리를 입력해주세요. (첫 자리는 0이 될 수 없습니다)")
        
        while inputArray != answer {
            if let input = readLine() {
                inputArray = input.map { String($0) }.compactMap { Int($0) }
            }
            
            guard inputArray.count == 3, Set(inputArray).count == 3, inputArray[0] != 0 else {
                print("*올바르지 않은 입력값입니다*\n서로 다른 숫자 3자리를 입력해주세요. (첫 자리는 0이 될 수 없습니다)")
                continue
            }
            
            trialCount += 1 // 유효한 입력만 카운트
            
            var strikeCount = 0
            var ballCount = 0
            var nothingCount = 0
            
            for i in 0..<3 {
                if answer[i] == inputArray[i] {
                    strikeCount += 1
                } else if answer.contains(inputArray[i]) {
                    ballCount += 1
                } else {
                    nothingCount += 1
                }
            }
            
            switch (strikeCount, ballCount, nothingCount) {
            case (3, 0, 0):
                print("정답입니다\n1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
                return trialCount
            case (0, 0, 3):
                print("Nothing")
            case (0, _, _):
                print("\(ballCount)볼")
            case (_, 0, _):
                print("\(strikeCount)스트라이크")
            default:
                print("\(strikeCount)스트라이크 \(ballCount)볼")
            }
        }
        
        return trialCount
    }
    
    // 정답을 만드는 함수 [Int] 배열로 반환
    func makeAnswer() -> [Int] {
        var arr: [Int] = []
        repeat {
            arr = Array((0...9).shuffled().prefix(3))
        } while arr[0] == 0
        return arr
    }
}
//기록 관리 구조체
struct RecordManager {
    private var records: [Int] = []
    
    mutating func add(trialCount: Int) {
        records.append(trialCount)
    }
    
    func showRecords() {
        if records.isEmpty {
            print("< 저장된 게임 기록이 없습니다 >")
        } else {
            for (index, trial) in records.enumerated() {
                print("\(index + 1)번째 게임 : 시도 횟수 - \(trial)")
            }
        }
    }
}
