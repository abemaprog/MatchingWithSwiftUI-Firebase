//
//  RegistrationView.swift
//  MatchingWithSwiftUI
//
//  Created by Manato Abe on 2024/10/29.
//

import SwiftUI

struct RegistrationView: View {
    
    // private let authViewModel = AuthViewModel()
    // let authViewModel: AuthViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var email = ""
    @State private var name = ""
    @State private var age = 18
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            
            // Imgae
            BrandImage(size: .large)
                .padding(.vertical, 32)
            
            // Form
            VStack(spacing: 24) {
                InputField(text: $email, label: "メールアドレス", placeholder: "入力してください", keyboardType: .emailAddress)
                InputField(text: $name, label: "お名前", placeholder: "入力してください")
                PickerField(selection: $age, title: "年齢")
                InputField(text: $password, label: "パスワード", placeholder: "半角英数字6文字以上", isSeccureField: true)
                InputField(text: $confirmPassword, label: "パスワード（確認用）", placeholder: "もう一度、入力してください", isSeccureField: true)
            }
            
            // Button
            BasicButton(label: "登録", icon: "arrow.right") {
                Task {
                    await authViewModel.createAccount(
                        email: email,
                        password: password,
                        name: name,
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
    RegistrationView()
}
