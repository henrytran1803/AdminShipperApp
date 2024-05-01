//
//  AllOrderView.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 30/04/2024.
//

import SwiftUI
import PDFKit
import UIKit

struct AllOrderView: View {
    @ObservedObject var orderMV: OrderMV = OrderMV()
    @State var orders: [Oder] = [] // Đã sửa tên của Oder thành Order
    @ObservedObject var viewModel = PDFCreator()

    var body: some View {
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
        .navigationBarItems(trailing: Button("Export PDF") {
            createAndSavePDF()
        })
        .sheet(isPresented: $viewModel.showShareSheet) {
            if let data = viewModel.documentData {
                ActivityView(activityItems: [data])
            }
        }
        .onAppear {
            loadOrder()
        }
    }

    func loadOrder() {
        orderMV.fetchAllOrders { orders in
            self.orders = orders
            viewModel.isLoading = true
        }
    }

    func createAndSavePDF() {
        viewModel.createAndSavePDF(with: orders)
    }
}


struct ActivityViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIActivityViewController

    let activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return activityViewController
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    AllOrderView()
}
struct ActivityView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIActivityViewController
    
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}
