//
//  CategoryItemList.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 28/04/2024.
//

import SwiftUI

struct CategoryItemList: View {
    @State var category : CategoriesDetail
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 330, height: 80)
            .foregroundColor(Color.buttonwelcome)
            .overlay{
                HStack{
                    AsyncImageCustom(url: category.category.image, framew: 80, corner: 10)
                        .padding(.horizontal)
                    Text(category.name)
                        .bold()
                        .foregroundColor(.white)
                    Spacer()
                    Image("edit")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .padding()
                }
            }
    }
}

//#Preview {
//    CategoryItemList(category:.constant(CategoriesDetail(name: "name", category: Categories(detail: "", image: ""))))
//}

