//
//  RegistrationView.swift
//  MatchingWithSwiftUI
//
//  Created by Manato Abe on 2024/10/29.
//

import SwiftUI

struct RegistrationView: View {
    
    //private let authViewModel = AuthViewModel()
    let authViewModel: AuthViewModel
    @State private var email = ""
    @State private var name = ""
    @State private var age = 18
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            // Imgage
            BrandImage()
            
            // Form
            VStack(spacing: 24) {
                // メールアドレス
                InputField(text: $email, label: "メールアドレス", placeholder: "入力してください")
                // 名前
                InputField(text: $name, label: "お名前", placeholder: "入力してください")
                // 年齢
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("年齢")
                            .foregroundStyle(Color(.darkGray))
                            .fontWeight(.semibold)
                            .font(.footnote)
                        
                        Spacer()
                        
                        Picker(selection: $age) {
                            ForEach(18..<100) { number in
                                Text("\(number)")
                                    .tag(number)
                            }
                        } label: {
                            Text("年齢")
                        }
                        .tint(.black)
                        
                    }
                    Divider()
                }
                // パスワード
                InputField(text: $password, label: "パスワード", placeholder: "半角英数字6文字以上", isSecureField: true)
                // パスワード（確認用）
                InputField(text: $confirmPassword, label: "パスワード（確認用）", placeholder: "もう一度、入力してください", isSecureField: true)
            }
            // Button
            BasicButton(label: "登録", icon: "arrow.right") {
                Task {
                    await authViewModel.createAccount(
                        email: email,
                        name: name,
                        password: password,
                        age: age
                    )
                }
            }
            .padding(.top, 24)
            
            Spacer()
            
            // Navigation
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("すでにアカウントをお持ちの方")
                    Text("ログイン")
                        .fontWeight(.bold)
                }
                .foregroundStyle(Color(.darkGray))
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    RegistrationView(authViewModel: AuthViewModel())
}
