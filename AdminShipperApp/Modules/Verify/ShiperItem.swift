//
//  ShiperItem.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 29/04/2024.
//

import SwiftUI

struct ShiperItem: View {
    @State var shiper: Shiper
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 330, height: 80)
            .foregroundColor(Color.white)
            .border(Color.black)
            .overlay{
                HStack{
                    Text(shiper.name)
                        .bold()
                        .padding(.horizontal)
                    Spacer()
                    VStack{
                        Text(shiper.cccd)
                            .bold()
                            .foregroundStyle(.secondary)
                        Text("Chưa xác minh")
                            .bold()
                            .foregroundStyle(.secondary)
                            .foregroundColor(.red)
                    }
                    .padding(.horizontal)
                }
            }
    }
}

#Preview {
    ShiperItem(shiper: Shiper(name: "name", cccd: "12312", diachi: "adssa", ngaysinh: "ádá"))
}
