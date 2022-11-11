//
//  Home.swift
//  Restart
//
//  Created by Philip Al-Twal on 10/11/22.
//

import SwiftUI

struct Home: View {
    @AppStorage("onBoarding") var isOnBoardingViewActive: Bool = false
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                // MARK: Header
                ZStack{
                    CircleGroupView(shapeColor: Color("ColorBlue"), shapeOpacity: 0.2)
                    Image("character-2")
                        .resizable()
                        .scaledToFit()
                        .offset(y: isAnimating ? 29 : -29)
                        .animation(
                            Animation
                                .easeOut(duration: 4)
                                .repeatForever()
                            ,value: isAnimating)
                }
                .padding()
                // MARK: Center
                Text(
                    """
                    The time that leads to mastery is
                    dependent on the intinsity of our focus
                    """
                )
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)
                // MARK: Footer
                Spacer()
                Button {
                    withAnimation {
                        let audioPlayer = RAudioPlayer.shared
                        audioPlayer.play(with: "success", type: "m4a")
                        isOnBoardingViewActive = true
                    }
                } label: {
                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    Text("Restart")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                .padding()
            }//: VSTACK
        } //: VStack
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                isAnimating = true
            })
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
