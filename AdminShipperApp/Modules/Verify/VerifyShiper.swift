//
//  VerifyShiper.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 29/04/2024.
//

import SwiftUI

struct VerifyShiper: View {
    @ObservedObject var shiperMV = ShiperMV()
    var body: some View {
        NavigationView {
            Text("Quản lý xét duyệt")
                .foregroundColor(.black)
                .bold()
                .font(.title)
            VStack {
                if shiperMV.shipers.isEmpty {
                    Text("Không có ai xét duyệt")
                        .foregroundColor(.gray)
                } else {
                    List {
                        ForEach(shiperMV.shipers, id: \.cccd) { shiper in
                            NavigationLink(destination: DetailShiper(shiper: shiper)) {
                                ShiperItem(shiper: shiper)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            shiperMV.fetchShiperVerifyRealTime()
        }
    }

        
    
}

#Preview {
    VerifyShiper()
}
