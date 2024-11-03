//
//  LoginView.swift
//  MatchingWithSwiftUI
//
//  Created by Manato Abe on 2024/10/29.
//

import SwiftUI

struct LoginView: View {
    
    //private let authViewModel = AuthViewModel()
    //let authViewModel: AuthViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    
    
    var body: some View {
        NavigationStack {
            VStack {
                // Imgage
                BrandImage(size: .large)
                    .padding(.vertical, 32)
                
                // Form
                VStack(spacing: 24) {
                    InputField(text: $email, label: "メールアドレス", placeholder: "メールアドレスを入力してください", keyboardType: .emailAddress)
                    
                    InputField(text: $password, label: "パスワード", placeholder: "半角英数字6文字以上", isSecureField: true)
                }
            }
            // Button
            BasicButton(label: "ログイン", icon: "arrow.right") {
                Task {
                    await authViewModel.login(email: email, password: password)
                }
                print("ログインボタンがタップされました")
            }
            .padding(.top, 24)
            
            Spacer()
            
            // Navigation
            NavigationLink {
                RegistrationView()
                    .navigationBarBackButtonHidden()
            } label: {
                HStack {
                    Text("まだアカウントをお持ちでない方")
                    Text("会員登録")
                        .fontWeight(.bold)
                }
                .foregroundStyle(Color(.darkGray))
            }
        }
        .padding(.horizontal)
    }
}


#Preview {
    LoginView()
}


