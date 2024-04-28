//
//  DiscountItemList.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 28/04/2024.
//

import SwiftUI
import Firebase
struct DiscountItemList: View {
    @State var discount : Discount
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 330, height: 80)
            .foregroundColor(Color.buttonwelcome)
            .overlay{
                HStack{
                    AsyncImageCustom(url: discount.image, framew: 80, corner: 10)
                        .padding(.horizontal)
                    Text(discount.code)
                        .bold()
                        .foregroundColor(.white)
                    Text(discount.name)
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

#Preview {
    DiscountItemList(discount: Discount(code: "aaa", name: "aaa", percent: 10, dueday: Timestamp(date: Date()), image: ""))
}
