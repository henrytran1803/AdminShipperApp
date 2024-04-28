//
//  DiscountManagerView.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 28/04/2024.
//

import SwiftUI

struct DiscountManagerView: View {
    @ObservedObject var discoutMV = DiscountMV()
    @State var discounts: [Discount] = []

    
    var body: some View {
        NavigationView {
            List {
                ForEach(discounts, id: \.code) { discount in
                    NavigationLink {
                        DetailDisount(discount: discount, isNew: false)
                    } label: {
                        DiscountItemList(discount: discount)
                    }
                
                }
               .onDelete(perform: removeRows)
            }
            .navigationTitle("Quản lý giảm giá")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    NavigationLink {
                        DetailDisount()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }

            .onAppear {
                discoutMV.fetchDiscount { discounts in
                    self.discounts = discounts
                }
            }
        }
    }
    func removeRows(at offsets: IndexSet) {
        let index = offsets[offsets.startIndex]
        let discount = discounts[index]
        discoutMV.deleteDiscount(name: discount.code){ success in
        
            
        }
    }
}

#Preview {
    DiscountManagerView()
}
