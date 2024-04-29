//
//  OrderDetail.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 29/04/2024.
//

import SwiftUI

struct OrderDetail: View {
    @ObservedObject var shiperMV = ShiperMV()
    @State var order: Order
    @State private var selectedShipper : Int = 0
    var body: some View {
        VStack{
            TextField("Order ID", text: $order.orderId)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray)
                )
                .disabled(true)
            TextField("Name", text: $order.name)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray)
                )
                .disabled(true)
            TextField("Address", text: $order.address)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray)
                )
                .disabled(true)
//            TextField("Shiper", text: $order.shiper)
//                .padding()
//                .overlay(
//                    RoundedRectangle(cornerRadius: 8)
//                        .stroke(lineWidth: 2)
//                        .foregroundColor(.gray)
//                )
//                .disabled(true)
            Picker("Select Category", selection: $selectedShipper) {
                ForEach(0..<shiperMV.verifiedShippers.count, id: \.self) { index in
                    Text(shiperMV.verifiedShippers[index].fullname)
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            Button(action: {
                OrderMV().updateShipperForOrder(orderId: order.orderId, newShipper: shiperMV.verifiedShippers[selectedShipper].uid)
            }, label: {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 300, height: 60)
                    .foregroundColor(Color("buttonwelcome"))
                    .overlay{
                        Text("Xác nhận")
                            .bold()
                            .foregroundColor(.white)
                    }
            }).padding()

        }.onAppear{
            shiperMV.fetchVerifiedShippers()
        }
    }
}

#Preview {
    OrderDetail(order: Order(userId: "", orderId: "", name: "", address: "", shiper: "", lat: "", long: ""))
}
