//
//  TabBarAdminView.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 28/04/2024.
//

import SwiftUI

struct TabBarAdminView: View {
    @State private var tabSelected: TabAdmin = .manager
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            VStack {
                switch tabSelected {
                case .manager:
                    HomeAdminView()
                case .order:
                    VerifyShiper()
                case .setting:
                    OrderManagerView()
                case .setting1:
                    SettingView()
                }

                Spacer()
            }
            VStack {
                Spacer()
                CustomTabBar(selectedTab: $tabSelected)
                
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    TabBarAdminView()
}
