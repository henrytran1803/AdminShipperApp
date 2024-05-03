//
//  PickDateView.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 03/05/2024.
//

import SwiftUI
import Firebase
import Charts
struct DataChart {
    var date :Date
    var total : Double
}
struct PickDateView: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    @ObservedObject var orderMV = OrderMV()
    var body: some View {
        NavigationView{
            VStack {
                DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    .padding()
                
                DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                    .padding()
                HStack{
                    Button(action: {
                        let startTimestamp = Timestamp(date: startDate)
                        let endTimestamp = Timestamp(date: endDate)
                        
                        orderMV.fetchOrderBetweenDates(startDate: startTimestamp, endDate: endTimestamp) { fetchedOrders in
                            
                        }

                    }, label: {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 100, height: 40)
                            .foregroundColor(Color("buttonwelcome"))
                            .overlay{
                                Text("Lọc")
                                    .bold()
                                    .foregroundColor(.white)
                            }
                    }).padding()
        
                    if !orderMV.ordersfiller.isEmpty {
                        NavigationLink{
                            ChartLine(data: chartData)
                        } label:{
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 100, height: 40)
                                .foregroundColor(Color("buttonwelcome"))
                                .overlay{
                                    Text("LineChart")
                                        .bold()
                                        .foregroundColor(.white)
                                }
                        }.padding()
                        
                        NavigationLink{
                            ChartBar(data: chartData)
                        } label:{
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 100, height: 40)
                                .foregroundColor(Color("buttonwelcome"))
                                .overlay{
                                    Text("BarChart")
                                        .bold()
                                        .foregroundColor(.white)
                                }
                        }.padding()
                    } else {
                        Spacer()
                    }
                    
                }
                
                
                Spacer()
                List {
                    ForEach($orderMV.ordersfiller, id: \.hashValue) { order in
                        OrderRow(order: order)
                    }
                }
            }
        }
    }

    private var chartData: [DataChart] {
        var dataEntries: [DataChart] = []
        
        for order in orderMV.ordersfiller {
            let date = order.date.dateValue()
            let total = order.total
            
            let dataEntry = DataChart(date: date, total: total)
            dataEntries.append(dataEntry)
        }
        return dataEntries
    }
}



struct ChartLine: View {
    @State var data: [DataChart]
    var body: some View {
        Chart(data, id: \.date) {
            LineMark(
                x: .value("Month", $0.date),
                y: .value("Hours of Sunshine", $0.total)
            )
        }
        
    }
}
struct ChartBar: View {
    @State var data: [DataChart]
    var body: some View {
        Chart(data, id: \.date) {
            BarMark(
                x: .value("Month", $0.date),
                y: .value("Hours of Sunshine", $0.total)
            )
        }
        
    }
}
#Preview {
    PickDateView()
}

