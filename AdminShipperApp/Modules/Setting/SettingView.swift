//
//  SettingView.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 29/04/2024.
//

import SwiftUI
import PhotosUI
import FirebaseStorage
import FirebaseAuth

struct SettingView: View {
    @State var showVerifyView = false
    @State var isLogout = false
    @State var data: Data?
    @State var selectedItem: [PhotosPickerItem] = []
   @State var uid = ""

    var body: some View {
        VStack{
                Section {
                    
                    let imageURL: String = "\(uid)"
                    AsyncImageCustom(url: imageURL,framew: 20,corner: 300)
                    HStack{
                        PhotosPicker(selection: $selectedItem, maxSelectionCount: 1, selectionBehavior: .default, matching: .images, preferredItemEncoding: .automatic) {
                            if let data = data, let image = UIImage(data: data) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame( maxHeight: 80)
                                    .cornerRadius(300)
                            } else {
                                Label("Select a picture", systemImage: "photo.on.rectangle.angled")
                            }
                        }.onChange(of: selectedItem) { newValue in
                            guard let item = selectedItem.first else {
                                return
                            }
                            item.loadTransferable(type: Data.self) { result in
                                switch result {
                                case .success(let data):
                                    if let data = data {
                                        self.data = data
                                    }
                                case .failure(let failure):
                                    print("Error: \(failure.localizedDescription)")
                                }
                            }
                        }
                        
                    }
                    Button("Change picture") {
                        let storageReference = Storage.storage().reference().child("\(uid)")
                        
                        storageReference.putData(data!, metadata: nil) { (metadata, error) in
                            guard let metadata = metadata else {
                                return
                            }
                        }
                    }.disabled(data == nil)
                }.padding()
            Spacer()
            List{
                
                Section(header: Text("Tài khoản")) {
                    Button(action: {
                        isLogout = true
                        AuthViewModel().signOut()
                    }, label: {
                        
                        Text("Đăng xuất")
                            .bold()
                            .foregroundColor(.red)
                    })
                    if showVerifyView {
                        Button(action: {
                            NavigationLink{
                                VerifyView()
                            }label: {
                                Text("Bạn chưa verify")
                            }
                            
                        }, label: {
                            Text("Bạn chưa verify")
                        })
                    }
                }
            }
            Spacer()
        }
        .onAppear {
            AuthViewModel().checkUserVerify { verify in
                UserDefaults.standard.set(verify, forKey: "verify")
                if verify == "true" {
                }else {
                    showVerifyView = true
                }
            }
        }
        .fullScreenCover(isPresented: $isLogout, content: {
            WelcomeView()
        })
        .onAppear{
            guard let user = Auth.auth().currentUser else {
                print("DEBUG: No current user")
                return
            }
            
            self.uid = user.uid
        }
    }
}

#Preview {
    SettingView()
}
