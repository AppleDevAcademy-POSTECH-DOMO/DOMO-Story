//
//  SwiftUIView.swift
//
//
//  Created by 박상원 on 2023/03/28.
//

import NavigationStack
import SwiftUI

struct Sulmoon8View: View {
    @State var lettersShowing: Double = 0
    @State var textduration: Double = 1.0
    @State var refreshToken: Bool = false
    @EnvironmentObject var bgm: BGM

    let screenHeight = UIScreen.main.bounds.size.height
    let screenWidth = UIScreen.main.bounds.size.width
    static let gradientStart = Color(red: 140.0 / 255, green: 89.0 / 255, blue: 181.0 / 255)
    static let gradientEnd = Color(red: 249 / 255, green: 227 / 255, blue: 255 / 255).opacity(0)

    // 이름
    let name = "김칫국 도모쿤♫~♪~!"
    // 대사
    @State var script = "아닛! 그녀가 나 도모쿤이 이상형이라고 돌려 말한 게 아닐까??!!\n오오옷!! 끼요오오옷~~~!!!!!"
    // 배경화면
    let backgroundIamge = "BackgroundLove"
    // 도모쿤 이미지
    let domoImage = "DomoOhyesReverse"

    var body: some View {
        ZStack {
            // 배경 사진
            Image(backgroundIamge)
                .resizable()
                .scaledToFill()
                .frame(width: screenWidth)
            VStack {
                Spacer()
                Image(domoImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight * 0.65)
                    .padding(.bottom, 160)
                    .padding(.leading, 200)
            }
            VStack {
                Spacer()
                // 대화창
                ZStack(alignment: .top) {
                    // 대화창 배경
                    Rectangle()
                        .fill(Color(red: 34 / 255, green: 6 / 255, blue: 56 / 255))
                        .opacity(0.72)
                        .onTapGesture {
                            bgm.buttonEffect.play()
                            textduration = refreshToken ? 3.0 : 1.0
                            lettersShowing += Double(script.count)
                            refreshToken = false
                        }
                    VStack(alignment: .leading, spacing: 0) {
                        // 대화창 상단
                        HStack {
                            // 이름
                            Text(name)
                                .font(.custom(.DungGeunMo, size: 40))
                                .foregroundColor(.white)
                                .padding(.leading, screenWidth * 0.05)
                            Spacer()
                            BackButton()
                                .simultaneousGesture(TapGesture().onEnded {
                                    bgm.buttonEffect.play()
                                })

                            // 리플레이 버튼
                            Button {
                                bgm.buttonEffect.play()
                                refreshToken = true
                                textduration = 0.5
                                lettersShowing = 0
                            } label: {
                                ScriptButtonText(text: "REPLAY")
                                    .padding(.trailing, screenWidth * 0.02)
                            }
                            PushView(destination: PosterView()) {
                                ScriptButtonText(text: "NEXT")
                                    .padding(.trailing, screenWidth * 0.02)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                bgm.buttonEffect.play()
                            })
                        }
                        .padding(.vertical, screenHeight * 0.03)
                        Rectangle()
                            .fill(LinearGradient(
                                gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                                startPoint: .init(x: 0, y: 0),
                                endPoint: .init(x: 1, y: 0)
                            ))
                            .frame(width: screenWidth * 0.5, height: screenHeight * 0.015)
                            .padding(.bottom, screenHeight * 0.03)
                            .onAppear {
                                textduration = 3.0
                                lettersShowing += Double(script.count)
                            }
                        // 대사
                        AppearingText(
                            fullText: script,
                            numberOfLettersShow: lettersShowing,
                            font: .custom(.gulim, size: 35)
                        )
                        .lineSpacing(10.0)
                        .foregroundColor(.white)
                        .fixedSize()
                        .padding(.horizontal, screenWidth * 0.05)
                        .animation(.linear(duration: textduration), value: lettersShowing)
                    }
                }
                .frame(width: screenWidth, height: screenHeight * 0.3)
            }
        }
        .ignoresSafeArea()
    }
}

struct Sulmoon8View_Previews: PreviewProvider {
    static var previews: some View {
        Sulmoon8View()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(BGM())
    }
}
