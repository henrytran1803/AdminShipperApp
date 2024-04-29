//
//  DetailShippingView.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 29/04/2024.
//

import SwiftUI
import Firebase
struct DetailShippingView: View {
    @State var order: Order
    @State var oder : Oder = Oder(name: "", adress: "", total: 0, discount: 0, date: Timestamp(date: Date()), products: [], status: .done, payment: .applePay)
    @State var isAcpept = false
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy 'at' HH:mm:ss"
        return formatter
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            Text("Đơn hàng số")
                .bold()
                .font(.title)
            Text(order.orderId)
                .bold()
                .font(.title)
            HStack(spacing: 0 ){
                Text("Khách hàng: ")
                Text(order.name)
                    .bold()
                    .font(.title3)
                
            }
            HStack(spacing: 0 ){
                Text("Địa chỉ: ")
                Text(order.address)
                    .bold()
                    .font(.title3)
                
            }
            HStack(spacing: 0 ){
                Text("Thanh toán: ")
                Text("\(oder.payment)")
                    .bold()
                    .font(.title3)
            }
            HStack(spacing: 0 ){
                Text("Tổng tiền: ")
                Text("\(String(format: "%.2f", (oder.total - (oder.total*oder.discount)/100)))")
                    .bold()
                    .font(.title3)
            }
            HStack(spacing: 0 ){
                Text("Ngày dặt: ")
                Text("\(formattedDate(from: oder.date))")                    .bold()
                    .font(.title3)
            }
            Button(action: {
                isAcpept = true
            }, label: {
                RoundedRectangle(cornerRadius: 5)
                     .frame(width: 300, height: 60)
                     .foregroundColor(Color("buttonwelcome"))
                     .overlay{
                         Text("Nhận đơn hàng")
                             .bold()
                             .foregroundColor(.white)
                     }
             }).padding()
                .onAppear{
                    OrderMV().getOrder(userId: order.userId, document: order.orderId){oder in
                        self.oder = oder ?? Oder(name: "", adress: "", total: 0, discount: 0, date: Timestamp(date: Date()), products: [], status: .done, payment: .applePay)
                        
                    }
                }
                .fullScreenCover(isPresented: $isAcpept, content: {
                    ShippingView(order: order)
                })
                    
        }
    }
    func formattedDate(from timestamp: Timestamp) -> String {
         let date = timestamp.dateValue()
         return dateFormatter.string(from: date)
     }
}

#Preview {
    DetailShippingView(order: Order(userId: "bla", orderId: "bla", name: "anhtran", address: "blabla", shiper: "blabla", lat: "", long: ""))
}
