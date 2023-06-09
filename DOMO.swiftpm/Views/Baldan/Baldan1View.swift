//
//  SwiftUIView.swift
//
//
//  Created by 박상원 on 2023/03/28.
//

import NavigationStack
import SwiftUI

struct Baldan1View: View {
    @EnvironmentObject var bgm: BGM
    @State var lettersShowing: Double = 0
    @State private var textduration: Double = 1.0
    @State var refreshToken: Bool = false
    let screenHeight = UIScreen.main.bounds.size.height
    let screenWidth = UIScreen.main.bounds.size.width
    static let gradientStart = Color(red: 140.0 / 255, green: 89.0 / 255, blue: 181.0 / 255)
    static let gradientEnd = Color(red: 249 / 255, green: 227 / 255, blue: 255 / 255).opacity(0)
    let backgroundIamge = "BackgroundC5"
    let domoImage = "DomoHowl"
    // 이름
    let name = "도모쿤♫~♪~!"
    // 대사
    @State var script = "오늘부터 나 『도모쿤』이 아카데미를 접수해주겠어-!"
    var body: some View {
        ZStack {
            // 배경 사진
            Image(backgroundIamge)
                .resizable()
                .scaledToFill()
                .frame(height: screenHeight)
                .onAppear{
                    bgm.firstBGM.play()
                    bgm.happyEffect.volume = 0.5
                }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(domoImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight * 0.7)
                        .padding(.trailing, 200)
                }
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
                            bgm.happyEffect.volume = refreshToken ? 0.5 : 0.0
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
                            // 뒤로가기 버튼
                            BackButton()
                                .simultaneousGesture(TapGesture().onEnded{
                                    bgm.buttonEffect.play()
                                    bgm.firstBGM.stop()
                                    bgm.titleBGM.resume()
                                })
                            // 리플레이 버튼
                            Button {
                                refreshToken = true
                                textduration = 0.5
                                lettersShowing = 0
                            } label: {
                                ScriptButtonText(text: "REPLAY")
                                    .padding(.trailing, screenWidth * 0.02)
                            }
                            .simultaneousGesture(TapGesture().onEnded{
                                bgm.buttonEffect.play()
                            })
                            PushView(destination: Baldan2View()) {
                                ScriptButtonText(text: "NEXT")
                                    .padding(.trailing, screenWidth * 0.02)
                            }
                            .simultaneousGesture(TapGesture().onEnded{
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
                                textduration = 1.0
                                lettersShowing += Double(script.count)
//                                bgm.speakEffect.play()
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

struct Baldan1View_Previews: PreviewProvider {
    static var previews: some View {
        Baldan1View()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(BGM())
    }
}
