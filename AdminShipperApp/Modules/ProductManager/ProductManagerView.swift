//
//  ProductManagerView.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 28/04/2024.
//

import SwiftUI

struct ProductManagerView: View {
    @ObservedObject var productMV = ProductMV()
    @State var products: [Product] = []
    @State var alertSuccess = false
    @State var alertFail = false
    @State var alertSure = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(products, id: \.name) { product in
                    NavigationLink {
                        DetailProduct(product: product, isNew: false, nameproduct: product.name, namecate: product.categoryName)
                    } label: {
                        ProductItemList(product: product)
                    }
                
                }
               .onDelete(perform: removeRows)
            }
            .navigationTitle("Quản lý sản phẩm")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        DetailProduct()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }

            .onAppear {
                productMV.fetchProductsFromAllCategories { products in
                    self.products = products
                }
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        let index = offsets[offsets.startIndex]
        let product = products[index]
        productMV.deleteProduct(name: product.name, categoryOld: product.categoryName) { success in
            if success {
                products.remove(at: index)
                alertSuccess = true
            } else {
                alertFail = true
            }
        }
    }
}

#Preview {
    ProductManagerView()
}
