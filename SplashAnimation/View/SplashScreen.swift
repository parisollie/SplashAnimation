//
//  SplashScreen.swift
//  SplashAnimation
//
//  Created by Paul F on 01/03/25.
//


import SwiftUI

struct SplashScreen: View {
    @State private var startAnimation: Bool = false
    @State private var showDetails: Bool = false
    @State private var showLogo: Bool = false // Nuevo estado para controlar la visibilidad del logo
    @Binding var endAnimation: Bool
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            // Mouse Shape - Circle forming the mouse body
            MouseShape()
                .trim(from: 0, to: startAnimation ? 1 : 0)
                //.stroke(Color.red, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.red, Color.orange]), // Degradado de rojo a naranja
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                )
                .frame(width: 250, height: 250)
                .rotationEffect(.degrees(-30))
            
            // Logo
            if showLogo {
                Image("logo") // Reemplaza "logo" con el nombre de tu imagen
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .transition(.opacity) // Animación de desvanecimiento
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1)) {
                startAnimation = true
            }
            
            withAnimation(.spring().delay(0.5)) {
                showDetails = true
            }
            
            // Mostrar el logo después de un retraso
            withAnimation(.easeInOut(duration: 1).delay(1.5)) {
                showLogo = true
            }
            
            withAnimation(.easeInOut(duration: 1).delay(2.5)) {
                endAnimation = true
            }
        }
    }
}

// Definición de MouseShape
struct MouseShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let mid = rect.width / 2
        path.move(to: CGPoint(x: mid, y: rect.height))
        path.addArc(center: CGPoint(x: mid, y: rect.height / 2), radius: mid, startAngle: .degrees(90), endAngle: .degrees(-270), clockwise: false)
        return path
    }
}

// Definición de ArcMouth
struct ArcMouth: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: .degrees(0), endAngle: .degrees(180), clockwise: true)
        return path
    }
}

// Definición de Whiskers
struct Whiskers: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX - 50, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX + 50, y: rect.midY))
        path.move(to: CGPoint(x: rect.midX - 50, y: rect.midY - 10))
        path.addLine(to: CGPoint(x: rect.midX + 50, y: rect.midY - 10))
        path.move(to: CGPoint(x: rect.midX - 50, y: rect.midY + 10))
        path.addLine(to: CGPoint(x: rect.midX + 50, y: rect.midY + 10))
        return path
    }
}

// Vista previa
struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen(endAnimation: .constant(false))
    }
}
