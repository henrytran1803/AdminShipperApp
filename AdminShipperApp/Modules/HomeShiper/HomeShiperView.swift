//
//  HomeShiperView.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 27/04/2024.
//

import SwiftUI
import FirebaseAuth

struct HomeShiperView: View {
    @State var showVerifyView = false
    @ObservedObject var orderMV = OrderMV()
    var body: some View {
        VStack {
            HeaderSignIn()
            Text("Thông báo đơn hàng mới")
                .bold()
                .font(.system(size: 20))
                .foregroundColor(.secondary)
            Spacer()
            NavigationStack{
                List {
                    ForEach(Array(orderMV.ordersShiper.keys), id: \.self) { shipperName in
                        Section(header: Text("Shipper: \(shipperName)")) {
                            ForEach(orderMV.ordersShiper[shipperName] ?? [], id: \.self) { order in
                                NavigationLink(destination: DetailShippingView(order: order)) {
                                    ItemOrderList(order: order)
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            AuthViewModel().checkUserVerify { verify in
                UserDefaults.standard.set(verify, forKey: "verify")
                if verify == "true" {
                    guard let user = Auth.auth().currentUser else {
                        print("DEBUG: No current user")
                        return
                    }
                    let uid = user.uid

                    orderMV.fetchShipsByShipper(shiper: uid)
                }else{
                    showVerifyView = true
                }
            }
        }
        .sheet(isPresented: $showVerifyView) {
            VerifyView()
        }
    }
}


#Preview {
    HomeShiperView()
}
extension Order: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(orderId)
    }
    
    static func == (lhs: Order, rhs: Order) -> Bool {
        return lhs.orderId == rhs.orderId
    }
}
