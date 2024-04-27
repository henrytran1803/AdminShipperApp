//
//  WelcomeView.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 27/04/2024.
//

import SwiftUI

struct WelcomeView: View {
    @State private var nameimages : [String] =  ["shiper","shiper","shiper","shiper","shiper"]
    @State var isOpen = false
    var body: some View {
        VStack(alignment: .center){
            Rectangle()
                .frame(width: .infinity, height: 550)
                .foregroundColor(Color("welcome"))
                .overlay{
                    TabView {
                       ForEach(nameimages, id: \.self) { imageName in
                           Image(imageName)
                               .resizable()
                               .scaledToFill()

                       }
                   }
                   .tabViewStyle(.page(indexDisplayMode: .always))
                   .frame(height: 400)
                }
            VStack{
                Text("Monitor your package's journey ")
                    .bold()
                    .font(.system(size: 20))
                Text("at every stage.")
                    .bold()
                    .font(.system(size: 20))
            }.padding()
            Text("Keep track of your package's location in real-time.")
                .foregroundStyle(.secondary)
                .padding()
            Button(action: { isOpen = true}, label: {
               RoundedRectangle(cornerRadius: 5)
                    .frame(width: 300, height: 60)
                    .foregroundColor(Color("buttonwelcome"))
                    .overlay{
                        Text("NEXT")
                            .bold()
                            .foregroundColor(.white)
                    }
            })
            Spacer()
                .fullScreenCover(isPresented: $isOpen, content: {
                    SignIn()
                })
        }.ignoresSafeArea()
    }
}

#Preview {
    WelcomeView()
}
