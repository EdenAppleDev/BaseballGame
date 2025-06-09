//
//  BaseballGame.swift
//  BaseballGame
//
//  Created by 김이든 on 6/4/25.
//

struct BaseballGame {
    func start() {
        print("환영합니다! 원하시는 번호를 입력해주세요\n1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
        
        while true {
            if let input = readLine() {
                switch input {
                case "1":
                    print("< 게임을 시작합니다 >")
                    playGame()
                case "2":
                    print("< 게임 기록 보기 >")
                case "3":
                    print("종료합니다")
                    return
                default:
                    print("*올바르지 않은 입력값입니다*\n원하시는 번호를 입력해주세요\n1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
                }
            }
        }
    }
    
    func playGame(){
        let answer = makeAnswer()
        var inputArray: [Int] = []
        
        print("서로 다른 숫자 3자리를 입력해주세요. (첫 자리는 0이 될 수 없습니다)")
        
        while inputArray != answer {
            // 유저에게 입력값을 받고 [Int]타입 배열로 전환
            // Int가 아니면 빈배열이 나옴
            // if let 으로 안전하게 언래핑
            if let input = readLine() {
                // String.Element 타입을 String으로 바꾸고 input.map으로 배열 생성
                // String을 Int로 바꾸고 nil은 제외되게 .compactMap 사용
                inputArray = input.map { String($0) }.compactMap { Int($0) }
            }
            // 세자리가 아니거나, 0을 가지거나 특정 숫자가 두번 사용된 경우 guard문의 continue를 사용해 밑에 코드를 건너뜀
            guard inputArray.count == 3, Set(inputArray).count == 3, inputArray[0] != 0 else {
                print("*올바르지 않은 입력값입니다*\n서로 다른 숫자 3자리를 입력해주세요. (첫 자리는 0이 될 수 없습니다)")
                continue            }
            // for문, switch문에서 쓸 변수지정
            var strikeCount = 0
            var ballCount = 0
            var nothingCount = 0
            // 0에서 2까지 배열 index에 맞게 3번 반복
            for i in 0..<3 {
                //서로의 인덱스의 값이 같은지 확인후 true면 스트라이크 변수에 +1
                if answer[i] == inputArray[i] {
                    strikeCount += 1
                    //정답 배열에 사용자 입력값을 포함하는지 확인후 true면 볼 변수에 +1
                } else if answer.contains(inputArray[i]){
                    ballCount += 1
                    //위 조건에 충족되지 않다는 뜻은 입력값배열의[i]가 정답에 없다 -> nothing
                } else {
                    nothingCount += 1
                }
            }
            // switch 문을 사용해 각자의 상황에 맞게 출력
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
    //정답을 만드는 함수 [Int] 배열로 반환
    func makeAnswer() -> [Int] {
        //1...9까지의 배열을 만들고 .shuffled() 을 사용해 무작위로 썩어줌
        //.prefix(3)으로 배열의 앞에 3개 요소만 가져옴 데이터타입은 ArraySlice<Int>
        //Array() 괄호 안에 감싸 데이터타입을 Array로 만들어줘서 return
        var arr: [Int] = []
        repeat {
            arr = Array((0...9).shuffled().prefix(3))
        } while arr[0] == 0
        return arr
    }
}
