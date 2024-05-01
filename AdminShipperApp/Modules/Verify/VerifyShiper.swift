//
//  VerifyShiper.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 29/04/2024.
//

import SwiftUI

struct VerifyShiper: View {
    @ObservedObject var shiperMV = ShiperMV()
    @State var isLoading = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    List {
                        ForEach(shiperMV.shipers, id: \.cccd) { shiper in
                            NavigationLink(destination: DetailShiper(shiper: shiper)) {
                                ShiperItem(shiper: shiper)
                            }
                        }
                    }
                } else {
                    ProgressView("Loading...")
                }
            }
            .navigationBarTitle("Quản lý xét duyệt đơn", displayMode: .inline)
        }
        .onAppear {
            shiperMV.fetchShiperVerifyRealTime { result in
                if result {
                    isLoading = true
                }
            }
        }
    }
    
}
#Preview {
    VerifyShiper()
}
