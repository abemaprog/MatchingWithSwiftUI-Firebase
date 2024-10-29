//
//  LoginView.swift
//  MatchingWithSwiftUI
//
//  Created by Manato Abe on 2024/10/29.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    
    var body: some View {
        NavigationStack {
            VStack {
                // Imgage
                BrandImage()
                
                // Form
                VStack(spacing: 24) {
                    InputField(text: $email, label: "メールアドレス", placeholder: "メールアドレスを入力してください")
                    
                    InputField(text: $password, label: "パスワード", placeholder: "半角英数字6文字以上", isSecureField: true)
                }
            }
            // Button
            BasicButton(label: "ログイン", icon: "arrow.right") {
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
