//
//  Home.swift
//  SplashAnimation
//
//  Created by Paul F on 01/03/25.
//

import SwiftUI

struct Home: View {
    var body: some View {
        //Paso 2.1
        NavigationView{
            //Paso 2.2
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 20){
                    //Paso 2.3
                    ForEach(1...5,id: \.self){index in
                        //Paso 2.4
                        Image("Pic\(index)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: getRect().width - 30, height: 220)
                            .cornerRadius(15)
                    }
                }
                .padding(15)
            }
            .navigationTitle("Trending Posts")
        }
    }
}

#Preview {
    Home()
}
