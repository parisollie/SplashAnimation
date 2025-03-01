//
//  ContentView.swift
//  SplashAnimation
//
//  Created by Paul F on 01/03/25.
//
import SwiftUI

struct ContentView: View {
    // Estados para controlar la animación
    @State var endAnimation: Bool = false
    @State var animateHome: Bool = false
    @State var showLogo: Bool = false // Controla la visibilidad del logo
    @State var startCircleAnimation: Bool = false // Controla la animación del círculo rojo

    var body: some View {
        ZStack {
            // Vista principal (Home)
            Home()
                // Animación para mover la vista Home desde la parte inferior
                .offset(y: animateHome ? 0 : getRect().height)
                .animation(.easeInOut(duration: 1).delay(1.0), value: animateHome)
            
            // SplashScreen con el círculo rojo y el logo
            if !endAnimation {
                ZStack {
                    Color.white.ignoresSafeArea()
                    
                    // Círculo rojo (animación del ratón)
                    Circle()
                        .trim(from: 0, to: startCircleAnimation ? 1 : 0)
                        /*.stroke(Color.red, style: StrokeStyle(lineWidth: 20, lineCap: .round))*/
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
                        .animation(.easeOut(duration: 1), value: startCircleAnimation)
                    
                    // Logo
                    if showLogo {
                        Image("logo") // Reemplaza "logo" con el nombre de tu imagen
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .transition(.opacity) // Animación de desvanecimiento
                    }
                }
                .opacity(endAnimation ? 0 : 1)
                .animation(.easeInOut(duration: 1), value: endAnimation)
                .onAppear {
                    // Iniciar la animación del círculo rojo
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeOut(duration: 1)) {
                            startCircleAnimation = true
                        }
                    }
                    
                    // Mostrar el logo después de que el círculo rojo esté completo
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(.easeInOut(duration: 1)) {
                            showLogo = true
                        }
                    }
                    
                    // Ocultar el logo y el círculo, y marcar el fin de la animación
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation(.easeInOut(duration: 1)) {
                            showLogo = false
                            startCircleAnimation = false
                            endAnimation = true
                        }
                    }
                }
            }
        }
        .onChange(of: endAnimation) { newValue in
            // Cuando la animación del SplashScreen termine, animar la vista Home
            if newValue {
                withAnimation(.easeInOut(duration: 1).delay(0.5)) {
                    animateHome = true
                }
            }
        }
    }
}

// Función para obtener el tamaño de la pantalla
extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}

#Preview {
    ContentView()
}
