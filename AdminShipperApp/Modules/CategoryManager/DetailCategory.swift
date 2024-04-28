//
//  DetailCategory.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 28/04/2024.
//

import SwiftUI

struct DetailCategory: View {
    @State var isNew = true
    @State var category : CategoriesDetail = CategoriesDetail(name: "", category: Categories(detail: "", image: ""))
    @State var name = ""
    var body: some View {
        VStack{
            TextField("name", text: $category.name)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray)
                )
            TextField("detail", text: $category.category.detail)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray)
                )
            TextField("images", text: $category.category.image)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray)
                )
            Button(action: {
                addCategory()
            }, label: {
                RoundedRectangle(cornerRadius: 5)
                     .frame(width: 300, height: 60)
                     .foregroundColor(Color("buttonwelcome"))
                     .overlay{
                         Text("HOÀN THÀNH")
                             .bold()
                             .foregroundColor(.white)
                     }
             }).padding()
        }.padding()
    }
    
    func addCategory(){
        if self.isNew {
            CategoryMV().addCategory(value: category.category, name: category.name)
        }else {
            CategoryMV().updateCategoryName(oldName: name, newName: category.name)
            CategoryMV().updateCategory(value: category.category, name: category.name)
        }
    }
    
}

#Preview {
    DetailCategory()
}
