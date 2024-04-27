//
//  HeaderSignIn.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 27/04/2024.
//

import SwiftUI

struct HeaderSignIn: View {
    var body: some View {
        Rectangle()
            .frame(width: .infinity, height: 200)
            .foregroundColor(.white)
            .overlay{
                ZStack{
                    Rectangle()
                        .frame(width: .infinity, height: 200)
                        .foregroundColor(Color("buttonwelcome"))
                        .overlay{
                            VStack{
                                Spacer()
                                HStack{
                                    Image("city")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200)
                                    ZStack{
                                        Image("city")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 200)
                                        VStack{
                                            Spacer()
                                            Image("bike")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30)
                                        }.frame(height: 100)
                                    }
                                    Image("city")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200)
                                }
                            }
                        }
                    VStack{
                        Spacer()
                        HStack{
                            
                            Rectangle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("buttonwelcome"))
                                .border(Color.white,width: 3)
                                .overlay{
                                    Image("ImageLaucher")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                }.padding(.leading, 20)
                            Spacer()
                        }
                    }
                    Spacer()
                }
            }
    }
}

#Preview {
    HeaderSignIn()
}
