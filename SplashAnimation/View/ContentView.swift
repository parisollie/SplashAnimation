//
//  ContentView.swift
//  SplashAnimation
//
//  Created by Paul F on 01/03/25.
//

import SwiftUI

struct ContentView: View {
    // Do actions when animation has been finished....
    @State var endAnimation: Bool = false
    @State var animateHome: Bool = false
    
    var body: some View {

        ZStack{
            
            // Home...
            Home()
            // Animating Home like its moving from bottom...
                .offset(y: endAnimation ? 0 : getRect().height)
            
            SplashScreen(endAnimation: $endAnimation)
        }
    }
}

#Preview {
    ContentView()
}
