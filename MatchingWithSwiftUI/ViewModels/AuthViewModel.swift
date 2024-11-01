//
//  AuthViewModel.swift
//  MatchingWithSwiftUI
//
//  Created by Manato Abe on 2024/10/30.
//Test@example.com, test00

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        print("ログインユーザー: \(self.userSession?.email)")
    }
    
    // Login
    @MainActor //Mianスレッドで実行することを保証する
    func login(email: String, password: String) async{
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            print("ログイン成功: \(result.user.email)")
            self.userSession = result.user
            print("self.userSession: \(self.userSession?.email)")
            } catch {
            // errorはデフォルトなので省略可
            print("ログイン登録失敗: \(error.localizedDescription)") // localizedDescriptionでエラー文を文字列で取得
            }
    }
    
    // Logout
    func logout() {
        do {
            try Auth.auth().signOut()
            print("ログアウト成功")
            self.userSession = nil
        } catch {
            print("ログアウト失敗: \(error.localizedDescription)")
        }
        
    }
    
    
    // Create Account
    // async: 非同期処理を行うことができる関数にできる
    @MainActor
    func createAccount(email: String,name: String, password: String, age: Int) async {
        do {
            // await 非同期処理で使われ、その処理が終わるまで次に進むのを停止する
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("ユーザー登録成功: \(result.user.email)")
            self.userSession = result.user
            
            let newUser = User(id: result.user.uid, name: name, email: email, age: age)
            await uploadUserData(withUser: newUser)
        } catch {
            // errorはデフォルトなので省略可
            print("ユーザー登録失敗: \(error.localizedDescription)") // localizedDescriptionでエラー文を文字列で取得
        }
        print("アカウント登録から呼び出されました")
    }
    
    
    // Delete Account
    
    
    // Upload User Data
    private func uploadUserData(withUser user: User) async {
        do {
            let userData = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(userData)
            print("データ保存成功")
        } catch {
            print("データ保存失敗: \(error.localizedDescription)")
        }
    }
}
