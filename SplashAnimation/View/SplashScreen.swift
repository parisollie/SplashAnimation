//
//  SplashScreen.swift
//  SplashAnimation
//
//  Created by Paul F on 01/03/25.
//

import SwiftUI

struct SplashScreen: View {
    
    //Paso 1.14 Animation Properties...
    @State var startAnimation: Bool = false
    
    //Paso 1.15
    @State var circleAnimation1: Bool = false
    @State var circleAnimation2: Bool = false
    
    //Paso 1.22 End
    @Binding var endAnimation: Bool
    
    var body: some View {
        
        //Paso 1.1
        ZStack{
            //Paso 1.2
            Color("SplashColor")
            
            Group{
                
                //Paso 1.5 Custom Shape With Animation....
                SplashShape()
                //Paso 1.13 trimming...
                    .trim(from: 0, to: startAnimation ? 1 : 0)
                //Paso 1.9 stroke to get outline...
                    .stroke(Color.white,style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                
                //Paso 1.14 Two Circles...
                Circle()
                    .fill(.white)
                    .frame(width: 35, height: 35)
                    //Paso 1.16
                    .scaleEffect(circleAnimation1 ? 1 : 0)
                    .offset(x: -80, y: 22)
                
                Circle()
                    .fill(.white)
                    .frame(width: 35, height: 35)
                    .scaleEffect(circleAnimation2 ? 1 : 0)
                    .offset(x: 80, y: -22)
            }
            // Default Frame...
            .frame(width: 220, height: 130)
            //Paso 1.10
            .scaleEffect(endAnimation ? 0.15 : 0.9)
            //Paso 1.24
            .rotationEffect(.init(degrees: endAnimation ? 85 : 0))
            
            //Paso 1.30 Bottom Ta Line...
            VStack{
                //Paso 1.31
                Text("Powered by")
                    .font(.callout)
                    .fontWeight(.semibold)
                
                Text("Le-Paullie")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            //Paso 1.38
            .frame(maxHeight: .infinity,alignment: .bottom)
            .foregroundColor(Color.white.opacity(0.8))
            .padding(.bottom,getSafeArea().bottom == 0 ? 15 : getSafeArea().bottom)
            .opacity(startAnimation ? 1 : 0)
            .opacity(endAnimation ? 0 : 1)
        }
        //Paso 1.25 Moving View Up....
        //Con esto  movemos el tiempo a otra pantalla:getRect().height * 1.5
        .offset(y: endAnimation ? -(getRect().height * 1.5) : 0)
        //Paso 1.3
        .ignoresSafeArea()
        //Paso 1.17
        .onAppear {
            // Delay Start...
            withAnimation(.spring().delay(0.15)){
                //Paso 1.18 First Circle...
                circleAnimation1.toggle()
            }
            
            //Paso 1.19 Next Shape..
            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1.05, blendDuration: 1.05).delay(0.4)){
                //Paso 1.20
                startAnimation.toggle()
            }
            
            //Paso 1.21 Final scnd Circle...
            withAnimation(.spring().delay(0.7)){
                circleAnimation2.toggle()
            }
            //Paso 1.23
            withAnimation(.easeInOut(duration: 0.65).delay(1.1)){
                
                endAnimation = true
            }
        }
    }
}
//Paso 1.26 Extending View to get Screen Frame...
extension View{
    //Paso 1.27
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
    
    // SafeArea...
    func getSafeArea()->UIEdgeInsets{
        
        //paso 1.28
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .zero
        }
        //Paso 1.29
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return .zero
        }
        
        return safeArea
    }
}

//Paso 1.4
struct SplashShape: Shape{
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            //Paso 1.6
            let mid = rect.width / 2
            let height = rect.height
            
            //Paso 1.7 80 = 40: Arc Radius...
            path.move(to: CGPoint(x: mid - 80, y: height))
            
            //Paso 1.8
            path.addArc(center: CGPoint(x: mid - 40, y: height), radius: 40, startAngle: .init(degrees: 180), endAngle: .zero, clockwise: true)
            
            //Paso 1.11 straight line...
            path.move(to: CGPoint(x: mid, y: height))
            path.addLine(to: CGPoint(x: mid, y: 0))
            
            //Paso 1.12 another arc...
            path.addArc(center: CGPoint(x: mid + 40, y: 0), radius: 40, startAngle: .init(degrees: -180), endAngle: .zero, clockwise: false)
        }
    }
}


#Preview {
    SplashScreen(endAnimation: .constant(false))
}
