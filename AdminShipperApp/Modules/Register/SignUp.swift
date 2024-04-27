//
//  SignUp.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 27/04/2024.
//

import SwiftUI

struct SignUp: View {
    @State var fullName = ""
    @State var userName = ""
    @State var passWord = ""
    @State var repeatPassWord = ""
    @State var openSignIn = false
    @State var isSignUp = false
    @State private var alertMismatchPassword = false
    @State private var alertSuccess = false
    @State private var alertFail = false
    var body: some View {
        VStack(){
            HeaderSignIn()
            HStack{
                VStack(alignment: .leading){
                    Text("Sign Up")
                        .bold()
                        .font(.title)
                    Text("Hi, There. Create new account.")
                        .foregroundColor(.secondary)
                }.padding(.leading)
                Spacer()
            }
            VStack{
                VStack(alignment: .leading, spacing: 0) {
                    Text("Full Name")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.secondary)
                    TextField("Enter your full name", text: $fullName)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.gray)
                        )
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Username")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.secondary)
                    TextField("Enter your username", text: $userName)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.gray)
                        )
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Password")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.secondary)
                    SecureField("Enter your password", text: $passWord)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.gray)
                        )
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Repeat password")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.secondary)
                    SecureField("Enter your Repeat password", text: $repeatPassWord)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.gray)
                        )
                }
            }.padding()
            Button(action: {
                if !userName.isEmpty && !fullName.isEmpty && !passWord.isEmpty && !repeatPassWord.isEmpty {
                    if passWord == repeatPassWord {
                        AuthViewModel().register(withEmail: userName, password: passWord, fullname: fullName) { success in
                            if success {
                                alertSuccess = true
                            } else {
                                alertFail = true
                            }
                        }
                    } else {
                        alertMismatchPassword = true
                    }
                } else {
                    alertMismatchPassword = true
                }

             }, label: {
                RoundedRectangle(cornerRadius: 5)
                     .frame(width: 300, height: 60)
                     .foregroundColor(Color("buttonwelcome"))
                     .overlay{
                         Text("SIGN UP")
                             .bold()
                             .foregroundColor(.white)
                     }
             }).padding()
           
             
             .alert(isPresented: $alertSuccess) {
                 Alert(
                     title: Text("Tạo thành công"),
                     message: Text("Ăn thôi."),
                     primaryButton: .default(
                         Text("Đăng nhập"),
                         action: open
                     ), secondaryButton: .cancel()
                 )
             }
             
             .alert(isPresented: $alertMismatchPassword) {
                  Alert(
                      title: Text("Sai mật khẩu"),
                      message: Text("Mật khẩu và mật khẩu lặp lại không khớp.")
                  )
              }
             .alert(isPresented: $alertFail) {
                 Alert(
                     title: Text("Tạo thất bại"),
                     message: Text("Có lỗi khi tạo, vui lòng thử lại.")
                 )
             }

            HStack{
                Text("Đã có tài khoản?")
                Button(action: {}, label: {
                    Text("Đăng nhập")
                        .foregroundColor(Color.buttonwelcome)
                        .bold()
                })
            }.padding()
            Spacer()
                .fullScreenCover(isPresented: $openSignIn, content: {
                    SignIn()
                })

        }.ignoresSafeArea(.all)
          
         
    }
    func GilroyFont(isBold: Bool = false, size: CGFloat) -> Font {
        if isBold {
            return Font.custom("Gilroy-ExtraBold", size: size)
        }else {
            return Font.custom("Gilroy-Light", size: size)
        }
    }
    func open(){
        openSignIn = true
    }

}

#Preview {
    SignUp()
}
