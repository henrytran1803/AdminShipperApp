//
//  ProductItemList.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 28/04/2024.
//

import SwiftUI

struct ProductItemList: View {
    @State var product : Product
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 330, height: 80)
            .foregroundColor(Color.buttonwelcome)
            .overlay{
                HStack{
                    AsyncImageCustom(url: product.image, framew: 80, corner: 10)
                        .padding(.horizontal)
                    Text(product.name)
                        .bold()
                        .foregroundColor(.white)
                    Text(product.categoryName)
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
//    ProductItemList()
//}
