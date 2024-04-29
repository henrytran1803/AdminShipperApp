//
//  OrderManagerView.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 29/04/2024.
//

import SwiftUI

struct OrderManagerView: View {
    @ObservedObject var orderMV = OrderMV()
    @State var isLoading = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    List {
                        ForEach(orderMV.orders, id: \.orderId) { order in
                            NavigationLink(destination: OrderDetail(order: order)) {
                                ItemOrderList(order: order)
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
            orderMV.fetchOrders { result in
                if result {
                    isLoading = true
                }
            }
        }
    }
}


#Preview {
    OrderManagerView()
}
