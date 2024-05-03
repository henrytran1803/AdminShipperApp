//
//  ItemOrderList.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 29/04/2024.
//

import SwiftUI

struct ItemOrderList: View {
    @State var order: Order
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 330, height: 80)
            .foregroundColor(Color.white)
            .border(Color.black)
            .overlay{
                HStack{
                    Text(order.orderId)
                        .bold()
                        .padding(.horizontal)
                    Spacer()
                    VStack{
                        Text(order.shiper)
                            .bold()
                            .foregroundStyle(.secondary)
                        if order.shiper == "none"{
                            Text("Chưa giao")
                                .bold()
                                .foregroundStyle(.secondary)
                                .foregroundColor(.red)
                        }else {
                            Text("đã có người giao")
                                .bold()
                                .foregroundStyle(.secondary)
                                .foregroundColor(.green)
                        }
                        
                    }
                    .padding(.horizontal)
                }
            }
    }
}

#Preview {
    ItemOrderList(order: Order(userId: "", orderId: "", name: "", address: "", shiper: "", lat: "", long: ""))
}
