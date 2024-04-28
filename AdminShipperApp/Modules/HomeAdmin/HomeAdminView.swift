//
//  HomeAdminView.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 27/04/2024.
//

import SwiftUI

struct HomeAdminView: View {
    var body: some View {
        NavigationView{
        VStack{
            HeaderSignIn()
            Text("TRUNG TÂM QUẢN LÝ")
                .bold()
                .font(.title3)
                .foregroundColor(.secondary)
           

                List{
                    Section(header: Text("Category")) {
                        NavigationLink {
                            CategoryManagerView()
                        } label: {
                            Rectangle()
                                .frame(width: 320, height: 150)
                                .foregroundColor(Color.buttonwelcome)
                                .overlay{
                                    VStack(alignment: .leading){
                                        Text("CATEGORY")
                                            .bold()
                                            .font(.title)
                                            .foregroundColor(.white)
                                        Text("Quản lý danh mục sản phẩm một các nhânh chóng nhấn vào dể quản lý")
                                            .foregroundStyle(.white)
                                        
                                    }
                                }
                        }
                    }
                    Section(header: Text("Product")) {
                        NavigationLink {
                            ProductManagerView()
                        } label: {
                            Rectangle()
                                .frame(width: 320, height: 150)
                                .foregroundColor(Color.buttonwelcome)
                                .overlay{
                                    VStack(alignment: .leading){
                                        Text("PRODUCT")
                                            .bold()
                                            .font(.title)
                                            .foregroundColor(.white)
                                        Text("Quản lý danh mục sản phẩm một các nhânh chóng nhấn vào dể quản lý")
                                            .foregroundStyle(.white)
                                        
                                    }
                                }
                        }
                    }
                    Section(header: Text("Discount")) {
                        NavigationLink {
                            DiscountManagerView()
                        } label: {
                            Rectangle()
                                .frame(width: 320, height: 150)
                                .foregroundColor(Color.buttonwelcome)
                                .overlay{
                                    VStack(alignment: .leading){
                                        Text("DISCOUNT")
                                            .bold()
                                            .font(.title)
                                            .foregroundColor(.white)
                                        Text("Quản lý danh mục sản phẩm một các nhânh chóng nhấn vào dể quản lý")
                                            .foregroundStyle(.white)
                                    }
                                }
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeAdminView()
}
