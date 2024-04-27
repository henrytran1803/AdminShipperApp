//
//  CustomTabBarShiper.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 27/04/2024.
//

import Foundation
import SwiftUI
enum TabShiper: String, CaseIterable {
    case home
    case history
    case setting
}
struct CustomTabbarShiper: View{
    @Binding var selectedTab: TabShiper
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    var body: some View {
        VStack {
            HStack {
                ForEach(TabShiper.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                        .foregroundColor(tab == selectedTab ? .white : .gray)
                        .font(.system(size: 20))
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 70)
            .background(Color("bgproduct"))
            .cornerRadius(20)
            .padding()
        }
    }
}
