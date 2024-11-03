//
//  EditProfileView.swift
//  MatchingWithSwiftUI
//
//  Created by Manato Abe on 2024/10/31.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var name = ""
    @State var age = 18
    @State var message = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                // background
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                
                // EditField
                editField
            }
            .navigationTitle("プロフィール変更")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { // error here
                    Button("キャンセル") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("変更") {
                        Task {
                            
                            guard let currentUser = authViewModel.currentUser else { return }
                            
                            await authViewModel.updateUserProfile(
                                withId: currentUser.id,
                                name: name,
                                age: age,
                                message: message)
                        }
                        dismiss()
                    }
                }
            }
            .font(.subheadline)
            .foregroundStyle(.primary)
        }
    }
}

#Preview {
    EditProfileView()
        .environmentObject(AuthViewModel())
}

extension EditProfileView {
    private var editField: some View {
        VStack(spacing: 16) {
            // Photo
            PhotosPicker(selection: $authViewModel.selectedImage) {
                Group {
                    if let uiImage = authViewModel.profileImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .frame(width: 150)
                    } else {
                        ZStack {
                            Image("avatar")
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .frame(width: 150)
                            
                            Image(systemName: "photo.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(Color.white.opacity(0.75))
                                .frame(width: 60)
                            
                        }
                    }
                }
            }
            
            // InputField
            InputField(text: $name, label: "お名前", placeholder: "")
            PickerField(selection: $age, title: "年齢")
            InputField(text: $message, label: "メッセージ", placeholder: "入力してください", withDivider: false)
        }
        .padding(.horizontal)
        .padding(.vertical, 32)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 1)
        }
        .padding()
        .onAppear {
            if let currentUser = authViewModel.currentUser {
                name = currentUser.name
                age = currentUser.age
                message = currentUser.message ?? ""
            }
        }
    }
}


