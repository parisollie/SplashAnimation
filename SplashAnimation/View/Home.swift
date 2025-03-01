//
//  Home.swift
//  SplashAnimation
//
//  Created by Paul F on 01/03/25.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(1...5, id: \ .self) { index in
                        Image("Pic\(index)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width - 30, height: 220)
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
