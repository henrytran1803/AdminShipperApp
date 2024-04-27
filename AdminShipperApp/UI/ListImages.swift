//
//  ListImages.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 27/04/2024.
//

import SwiftUI

struct ListImages: View {
    @State var images : [String]
    @State var height : CGFloat
    var body: some View {
        TabView {
           ForEach(images, id: \.self) { imageName in
               AsyncImageCustom(url: imageName, framew: height, corner: 3)
           }
       }
       .tabViewStyle(.page(indexDisplayMode: .always))
       .frame(height: height)
    }
}

struct AsyncImageCustom : View {
    @State var url : String
    @State var framew : CGFloat
    @State var corner : CGFloat
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty: ZStack { Color.gray; ProgressView() }
            case .success(let image): image.resizable()
            case .failure(let error):
                Text(error.localizedDescription)
            }
        }
        .aspectRatio(contentMode: .fit)
        .frame(width: framew)
        .cornerRadius(corner)
    }
}
