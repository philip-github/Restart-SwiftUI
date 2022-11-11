//
//  ContentView.swift
//  Restart
//
//  Created by Philip Al-Twal on 10/11/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onBoarding") var isOnBoardingViewActive: Bool = true
    
    var body: some View {
        ZStack{
            if isOnBoardingViewActive {
                OnBoarding()
            }else{
                Home()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
