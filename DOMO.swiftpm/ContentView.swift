import SwiftUI

struct ContentView: View {

    let screenHeight = UIScreen.main.bounds.size.height
    let screenWidth = UIScreen.main.bounds.size.width
    static let gradientStart = Color(red: 140.0 / 255, green: 89.0 / 255, blue: 181.0 / 255)
    static let gradientEnd = Color(red: 249 / 255, green: 227 / 255, blue: 255 / 255).opacity(0)
    @State var text: String = ""
    // 이름
    let name = "도모쿤♫~♪~!"
    // 대사
    let script = "제가 알기론 라면은 일반 가정에서도 손쉽게 해먹을 수 있어서 \n게으른 서민들에게 인기가 매우 높다고 들었습니다만? 틀렸습니까?"
    var test = "add account ocean"
    var body: some View {
        ZStack {
            // 배경 사진
            Image("background")
                .resizable()
                .scaledToFill()
            VStack {
                Spacer()
                // 도모쿤을 위한 자리
                HStack {
                    Spacer()
                    Image("domokun")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight * 0.5)
                }
                // 대화창
                ZStack(alignment: .top) {
                    // 대화창 배경
                    Rectangle()
                        .fill(Color(red: 34 / 255, green: 6 / 255, blue: 56 / 255))
                        .opacity(0.72)
                        .onTapGesture {}
                    VStack(alignment: .leading, spacing: 0) {
                        // 대화창 상단
                        HStack {
                            // 이름
                            Text(name)
                                .font(.custom(.DungGeunMo, size: 40))
                                .foregroundColor(.white)
                                .padding(.leading, screenWidth * 0.05)
                            Spacer()
                            // 리플레이 버튼
                            Button {
                                typeWriter()
                            } label: {
                                Text("REPLAY")
                                    .font(.custom(.DungGeunMo, size: 30))
                                    .foregroundColor(.white)
                                    .underline()
                                    .opacity(0.6)
                                    .padding(.trailing, screenWidth * 0.03)
                            }
                        }
                        .padding(.vertical, screenHeight * 0.03)
                        // Divider
                        Rectangle()
                            .fill(LinearGradient(
                                gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                                startPoint: .init(x: 0, y: 0),
                                endPoint: .init(x: 1, y: 0)
                            ))
                            .frame(width: screenWidth * 0.5, height: screenHeight * 0.015)
                            .padding(.bottom, screenHeight * 0.03)
                            .onAppear {
                                typeWriter()
                            }
                        // 대사
                        Text(text)
                            .font(.custom(.gulim, size: 35))
                            .lineSpacing(10.0)
                            .foregroundColor(.white)
                            .padding(.horizontal, screenWidth * 0.05)
                    }
                }
                .frame(width: screenWidth, height: screenHeight * 0.3)
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }

    func typeWriter(at position: Int = 0) {
        if position == 0 {
            text = ""
        }
        if position < script.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                text.append(script[position])
                typeWriter(at: position + 1)
            }
        }
    }
}

struct Previews_ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

extension String {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
