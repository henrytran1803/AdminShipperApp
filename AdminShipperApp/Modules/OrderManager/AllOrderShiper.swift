//
//  AllOrderShiper.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 30/04/2024.
//

import SwiftUI

struct AllOrderShiper: View {
    @ObservedObject var orderMV: OrderMV = OrderMV()
    @State var orders: [Oder] = []
    @ObservedObject var viewModel = PDFCreator()

    var body: some View {
        VStack{
            NavigationView {
                if viewModel.isLoading {
                    List {
                        ForEach($orders, id: \.hashValue) { order in
                            OrderRow(order: order)
                        }
                    }
                } else {
                    ProgressView("Loading")
                }
            }
        }
        .onAppear {
            loadOrder()
        }
    }
    func loadOrder() {
        orderMV.fetchAllOrder { orders in
            self.orders = orders
            viewModel.isLoading = true
        }
    }
}

#Preview {
    AllOrderShiper()
}
