//
//  DetailDisount.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 28/04/2024.
//

import SwiftUI
import Firebase
struct DetailDisount: View {
    @State var discount : Discount = Discount(code: "", name: "", percent: 0, dueday: Timestamp(date: Date()), image: "")
    @State var isNew = true
    var body: some View {
        VStack{
            TextField("Code", text: $discount.code)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray)
                )
                .disabled(!isNew)
            TextField("Name", text: $discount.name)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray)
                )
                .disabled(!isNew)
            TextField("Percent", text: Binding<String>(
                get: { String(discount.percent) },
                set: { if let value = Double($0) { discount.percent = value } }
            ))
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray)
                )
                .disabled(!isNew)
            TextField("Image", text: $discount.image)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray)
                )
                .disabled(!isNew)
                DatePicker("Due Date", selection: Binding<Date>(
                    get: { self.discount.dueday.dateValue() },
                    set: { self.discount.dueday = Timestamp(date: $0) }
                ), displayedComponents: .date)
                .disabled(!isNew)
            if isNew{
                Button(action: {
                    DiscountMV().addDiscount(value: discount)
                }, label: {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 300, height: 60)
                        .foregroundColor(Color("buttonwelcome"))
                        .overlay{
                            Text("Complete")
                                .bold()
                                .foregroundColor(.white)
                        }
                }).padding()
            }
        }
    }
}

#Preview {
    DetailDisount()
}
