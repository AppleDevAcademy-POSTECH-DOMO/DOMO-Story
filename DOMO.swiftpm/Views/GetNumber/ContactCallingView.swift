//
//  SwiftUIView.swift
//
//
//  Created by OhSuhyun on 2023/03/28.
//

import NavigationStack
import SwiftUI

struct ContactCallingView: View {
    @State var lettersShowing: Double = 0
    @State var textduration: Double = 1.0
    @State var refreshToken: Bool = false
    // 도모 회전 각도 변수
    @State private var isRotating = 0.0
    @EnvironmentObject var bgm: BGM

    let screenHeight = UIScreen.main.bounds.size.height
    let screenWidth = UIScreen.main.bounds.size.width
    static let gradientStart = Color(red: 140.0 / 255, green: 89.0 / 255, blue: 181.0 / 255)
    static let gradientEnd = Color(red: 249 / 255, green: 227 / 255, blue: 255 / 255).opacity(0)

    // 이름
    let name = "부담스러운 도모쿤♫~♪~!"
    // 대사
    @State var script = "뭐?! 전화가 부담스럽다니…"
    // 배경화면
    let backgroundIamge = "BackgroundRoom"
    // 도모쿤 이미지
    let domoImage = "DomoSide"

    var body: some View {
        ZStack {
            // 배경 사진
            Image(backgroundIamge)
                .resizable()
                .scaledToFill()
                .frame(width: screenWidth, height: screenHeight)
                .onAppear{
                    bgm.firstBGM.pause()
                    bgm.failedBGM.play()
                    bgm.happyEffect.volume = 0.5
                }
            Color.black
                .opacity(0.7)
            VStack {
                Spacer()
                // 도모쿤을 위한 자리
                HStack {
                    Spacer()
                    VStack {
                        Image(domoImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenHeight * 0.8)
                            .padding(.trailing, 100)
                            // 도모 회전
                            .rotationEffect(.degrees(isRotating))
                            .onAppear {
                                // 도모 회전 소요 시간
                                withAnimation(.linear(duration: 1)
                                    .speed(1))
                                {
                                    // 회전할 각도
                                    isRotating = -60.0
                                }
                            }
                        Spacer()
                            .frame(height: screenHeight * 0.12)
                    }
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
                            bgm.happyEffect.volume = refreshToken ? 0.5 : 0.0
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
                                .simultaneousGesture(TapGesture().onEnded{
                                    bgm.buttonEffect.play()
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
                            
                            // 넥스트 버튼 -> ContactDreamView
                            PushView(destination: ContactDreamView()) {
                                ScriptButtonText(text: "NEXT")
                                    .padding(.trailing, screenWidth * 0.02)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                bgm.buttonEffect.play()
                                bgm.failedBGM.pause()
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
                    // 구식 Next Button
                    // NextButton()
                    //    .position(x: 1160, y: 190)
                    //
                }
                .frame(width: screenWidth, height: screenHeight * 0.3)
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct ContactCallingView_Previews: PreviewProvider {
    static var previews: some View {
        ContactCallingView()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(BGM())

    }
}
