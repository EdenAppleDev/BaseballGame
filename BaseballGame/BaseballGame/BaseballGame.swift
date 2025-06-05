//
//  BaseballGame.swift
//  BaseballGame
//
//  Created by 김이든 on 6/4/25.
//

struct BaseballGame {
    func start() {
        let answer = makeAnswer()
        var inputArray: [Int] = []
        
        while inputArray != answer {
            print("숫자를 입력하세요")
            // 1. 유저에게 입력값을 받음
            if let input = readLine() {
                inputArray = input.compactMap { Int(String($0)) }
            }
            // 2. 정수로 변환되지 않는 경우 반복문 처음으로 돌아가기
            // 3. 세자리가 아니거나, 0을 가지거나 특정 숫자가 두번 사용된 경우 반복문 처음으로 돌아가기
            guard inputArray.count == 3, !inputArray.contains(0), inputArray.count != 0 else {
                print("올바르지 않은 입력값입니다")
                continue
            }
            // 4. 정답과 유저의 입력값을 비교하여 스트라이크/볼을 출력하기
            // 만약 정답이라면 break 호출하여 반복문 탈출
            var strikeCount = 0
            var ballCount = 0
            var nothingCount = 0
            
            for i in 0..<3 {
                if answer[i] == inputArray[i] {
                    strikeCount += 1
                } else if answer.contains(inputArray[i]){
                    ballCount += 1
                } else {
                    nothingCount += 1
                }
            }
            
            switch (strikeCount, ballCount, nothingCount) {
            case (3, 0, 0):
                print("정답입니다")
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
    }
    func makeAnswer() -> [Int] {
        return Array(Array(1...9).shuffled().prefix(3))
    }
}
