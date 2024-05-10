//
//  DetailProduct.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 28/04/2024.
//

import SwiftUI

struct DetailProduct: View {
    @State var category: [String] = []
    @State var selectedCategoryIndex = 0
    @State var product: Product = Product(name: "", detail: "", price: 0, quality: 0, star: 0, image: "", categoryName: "")
    @State var isNew = true
    @State var nameproduct = ""
    @State var namecate = ""
    
    var body: some View {
        
        VStack{
            Picker("Select Category", selection: $selectedCategoryIndex) {
                ForEach(0..<category.count, id: \.self) { index in
                    Text(category[index])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .onAppear {
                if !isNew {
                    if let index = category.firstIndex(of: product.categoryName) {
                        selectedCategoryIndex = index
                    }
                }
            }
            
            TextField("Name", text: $product.name)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray)
                )
            
            TextField("Detail", text: $product.detail)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray)
                )
            
            TextField("Image", text: $product.image)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray)
                )
            
            TextField("Price", text: Binding<String>(
                get: { String(product.price) },
                set: { if let value = Double($0) { product.price = value } }
            ))
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray)
                )
            
            TextField("Quality", text: Binding<String>(
                get: { String(product.quality) },
                set: { if let value = Int($0) { product.quality = value } }
            ))
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray)
                )
            
            TextField("Star", text: Binding<String>(
                get: { String(product.star) },
                set: { if let value = Double($0) { product.star = value } }
            ))
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray)
                )
            
            Button(action: {
                if isNew {
                    product.categoryName = category[selectedCategoryIndex]
                    ProductMV().addProduct(value: self.product, category: product.categoryName)
                }else {
                    
                    product.categoryName = category[selectedCategoryIndex]
                    
                    ProductMV().addNewProductAndDeleteOld(value: product, categoryName: product.categoryName, oldName: nameproduct, categoryOld: namecate)
                    
                }
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
        .onAppear {
            CategoryMV().fetchDocumentNames { documentNames in
                self.category = documentNames
            }
        }

    }

}


#Preview {
    DetailProduct()
}
