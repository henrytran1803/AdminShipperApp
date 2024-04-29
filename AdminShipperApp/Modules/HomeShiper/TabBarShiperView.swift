//
//  TabBarShiperView.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 29/04/2024.
//

import SwiftUI

struct TabBarShiperView: View {
    @State private var tabSelected: TabShiper = .house
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            VStack {
                switch tabSelected {
                case .house:
                    HomeShiperView()
                case .shippingbox:
                    HomeAdminView()
                case .ellipsisCircle:
                    SettingView()
                }
                
                Spacer()
            }
            VStack {
                Spacer()
                CustomTabbarShiper(selectedTab: $tabSelected)
                
            }
        }.ignoresSafeArea()
    }
}
#Preview {
    TabBarShiperView()
}
