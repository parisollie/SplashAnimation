//
//  ContentView.swift
//  SplashAnimation
//
//  Created by Paul F on 01/03/25.
//

import SwiftUI

struct ContentView: View {
    //Paso 1.40 Do actions when animation has been finished....
    @State var endAnimation: Bool = false
    @State var animateHome: Bool = false
    
    var body: some View {
        //Paso 1.39
        ZStack{
            
            //Paso 1.42, Home...
            Home()
            // Animating Home like its moving from bottom...
            //Paso 2.5
                .offset(y: endAnimation ? 0 : getRect().height)
            //Paso 1.0
            //Paso 1.41,endAnimation: $endAnimation
            SplashScreen(endAnimation: $endAnimation)
        }
    }
}

#Preview {
    ContentView()
}
