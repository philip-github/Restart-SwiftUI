//
//  OnBoarding.swift
//  Restart
//
//  Created by Philip Al-Twal on 10/11/22.
//

import SwiftUI

struct OnBoarding: View {
    
    @AppStorage("onBoarding") var isOnBoardingViewActive: Bool = true
    @State private var buttonWidth: CGFloat = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "Share."
    
    var body: some View {
        ZStack{
            Color("ColorBlue")
                .edgesIgnoringSafeArea(.all)
            VStack{
                // MARK: Header
                VStack{
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    Text(
                    """
                    It's not how much we give but
                    how much love we put into giving.
                    """
                    )
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                }//: VSTACK
                .opacity(isAnimating ? 1: 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                Spacer()
                // MARK: Center
                ZStack{
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .blur(radius: abs(imageOffset.width / 5))
                        .offset(x: imageOffset.width * -1)
                        .animation(.easeOut(duration: 0.5), value: imageOffset)
                        
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .opacity(isAnimating ? 1 : 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .animation(.easeOut(duration: 1), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .gesture(
                            DragGesture()
                                .onChanged({ dragGesture in
                                    if abs(imageOffset.width) <= 150{
                                        imageOffset = dragGesture.translation
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                        }
                                    }
                                })
                                .onEnded({ _ in
                                    imageOffset = .zero
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1.0
                                        textTitle = "Share."
                                    }
                                })
                        )
                        .animation(.easeOut(duration: 0.5), value: imageOffset)
                }
                .padding()
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .opacity(isAnimating ? indicatorOpacity : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                    , alignment: .bottom
                )
                Spacer()
                // MARK: Footer
                ZStack{
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(10)
                    Text("Get Started")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    HStack {
                        Capsule()
                            .fill(Color.red.opacity(0.7))
                            .frame(width: buttonOffset + 80)
                        Spacer()
                    }//: HSTACK
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                        }//: ZSTACK
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged({ dragGesture in
                                    if dragGesture.translation.width > 0 && buttonOffset <= (buttonWidth - 80) {
                                        buttonOffset = dragGesture.translation.width
                                    }
                                })
                                .onEnded({ _ in
                                    withAnimation(.easeOut(duration: 0.5)) {
                                        if buttonOffset > buttonWidth / 2
                                        {
                                            let audioPlayer = RAudioPlayer.shared
                                            audioPlayer.play(with: "chimeup", type: "mp3")
                                            isOnBoardingViewActive = false
                                        }else{
                                            buttonOffset = 0
                                        }
                                    }
                                })
                        )
                        Spacer()
                    }//: HSTACK
                }//: ZSTACK
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            }//: VSTACK
        }//: ZSTACK
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.dark)
    }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
    }
}

