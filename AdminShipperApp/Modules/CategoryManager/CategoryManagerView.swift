//
//  CategoryManagerView.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 28/04/2024.
//

import SwiftUI

struct CategoryManagerView: View {
    @ObservedObject var categoryMV = CategoryMV()
    @State var categories: [CategoriesDetail] = []
    @State var alertSuccess = false
    @State var alertFail = false
    @State var alertSure = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(categories, id: \.name) { category in
                    NavigationLink {
                        DetailCategory(isNew: false, category: category, name: category.name)
                    } label: {
                        CategoryItemList(category: category)
                    }
                
                }
                .onDelete(perform: removeRows)
            }
            .navigationTitle("Quản lý danh mục")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        DetailCategory()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
//            .alert(isPresented: $alertSure) {
//                Alert(
//                    title: Text("Bạn có chắc chắn?"),
//                    message: Text("Bạn muốn xoá danh mục này?"),
//                    primaryButton: .default(Text("Đồng ý"), action: { /* Handle delete confirmation */ }),
//                    secondaryButton: .cancel()
//                )
//            }
            .onAppear {
                categoryMV.fetchCategoriesDetails { categories in
                    self.categories = categories
                }
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        let index = offsets[offsets.startIndex]
        let category = categories[index]
        categoryMV.deleteCategory(name: category.name) { success in
            if success {
                categories.remove(at: index)
                alertSuccess = true
            } else {
                alertFail = true
            }
        }
    }
}


#Preview {
    CategoryManagerView()
}
