//
//  Final2View.swift
//  
//
//  Created by Chaeeun Shin on 2023/03/30.
//

import SwiftUI
import NavigationStack

struct Final2View: View {
    @State var lettersShowing: Double = 0
    @State private var textduration: Double = 1.0
    @State var refreshToken: Bool = false
    
    let screenHeight = UIScreen.main.bounds.size.height
    let screenWidth = UIScreen.main.bounds.size.width
    static let gradientStart = Color(red: 140.0 / 255, green: 89.0 / 255, blue: 181.0 / 255)
    static let gradientEnd = Color(red: 249 / 255, green: 227 / 255, blue: 255 / 255).opacity(0)

    let backgroundIamge = "BackgroundFlower"
    // 이름
    let name = "설레는 도모쿤♫~♪~!"
    // 대사
    @State var script = " 쿠쿠. 너가 내 처음이닷! "
    var body: some View {
        ZStack {
            // 배경 사진
            Image(backgroundIamge)
                .resizable()
                .scaledToFill()
                .frame(height: screenHeight)

            
            VStack {
                Spacer()
                // 대화창
                ZStack(alignment: .top) {
                    // 대화창 배경
                    Rectangle()
                        .fill(Color(red: 34 / 255, green: 6 / 255, blue: 56 / 255))
                        .opacity(0.72)
                    VStack(alignment: .leading, spacing: 0) {
                        // 대화창 상단
                        HStack {
                            // 이름
//                            Text(name)
//                                .font(.custom(.DungGeunMo, size: 40))
//                                .foregroundColor(.white)
//                                .padding(.leading, screenWidth * 0.05)
                            Spacer()
                            BackButton()
                            // 리플레이 버튼
                            Button {
                                refreshToken = true
                                textduration = 0.5
                                lettersShowing = 0
                            } label: {
                                ScriptButtonText(text: "REPLAY")
                                    .padding(.trailing, screenWidth * 0.02)
                            }
                            PushView(destination: EndingView()) {
                                ScriptButtonText(text: "NEXT")
                                    .padding(.trailing, screenWidth * 0.02)
                            }
                        }
                        .padding(.vertical, screenHeight * 0.03)

                    }
                }
                .frame(width: screenWidth, height: screenHeight * 0.3)
            }
        }
        .ignoresSafeArea()
    }
}

struct EndingView: View {
    @State private var isButtonVisible = false
    static let mintColor = Color(red: 66 / 255, green: 255 / 255, blue: 232 / 255)
    let logoImage = "Success"
    var body: some View {
        ZStack {
            Final2View()
            Color.black
                .opacity(0.6)
            VStack {
                Image(logoImage)
                PushView(destination: MemberView()) {
                    Text("The end ...")
                        .font(.custom(.DungGeunMo, size: 70))
                        .foregroundColor(Self.mintColor)
                }
            }
            .offset(y: isButtonVisible ? 0 : 600)
            .animation(.easeInOut(duration: 1.5), value: isButtonVisible)
            .onAppear {
                isButtonVisible = true
            }
        }
        .ignoresSafeArea()
    }
}

struct Final2View_Previews: PreviewProvider {
    static var previews: some View {
        Final2View()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

