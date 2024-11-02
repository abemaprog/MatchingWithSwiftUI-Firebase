//
//  MyPageView.swift
//  MatchingWithSwiftUI
//
//  Created by Manato Abe on 2024/10/31.
//

import SwiftUI

struct MyPageView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showEditProfileView = false
    
    var body: some View {
        List {
            // User info
            userInfo
            
            // System info
            Section("一般") {
                MyPageRow(iconname: "gear", label: "バージョン", tintColor: .gray, value: "1.0.0")
            }
            
            // Navigation
            Section("アカウント") {
                Button {
                    showEditProfileView.toggle()
                } label: {
                    MyPageRow(iconname: "square.and.pencil.circle.fill", label: "プロフィール変更", tintColor: .red)
                }
                Button {
                    authViewModel.logout()
                } label: {
                    MyPageRow(iconname: "arrow.left.circle.fill", label: "ログアウト", tintColor: .red)
                }
                Button {
                    
                } label: {
                    MyPageRow(iconname: "xmark.circle.fill", label: "アカウント削除", tintColor: .red)
                }
            }
        }
        .sheet(isPresented: $showEditProfileView) {
            EditProfileView()
        }
    }
}


#Preview {
    MyPageView()
        .environmentObject(AuthViewModel())
}

extension MyPageView {
    private var userInfo: some View {
        Section {
            HStack(spacing: 16) {
                Image("avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 4) {
                    Text(authViewModel.currentUser?.name ?? "")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    
                    Text(authViewModel.currentUser?.email ?? "")
                        .font(.footnote)
                        .tint(.gray)
                }
            }
        }
        
    }
}
