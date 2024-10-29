//
//  ListViewModel.swift
//  MatchingWithSwiftUI
//
//  Created by Manato Abe on 2024/10/28.
//

import Foundation

class ListViewModel {
    var users = [User]()
    
    private var currentIndex = 0
    
    init() {
        self.users = getMOCKUSers()
    }
    
    private func getMOCKUSers() -> [User] {
        return [
            User.MOCK_USER1,
            User.MOCK_USER2,
            User.MOCK_USER3,
            User.MOCK_USER4,
            User.MOCK_USER5,
            User.MOCK_USER6,
            User.MOCK_USER7
        ]
    }
    func nopeButtontapped() {
        // カードがなくなった時にクラッシュさせないため
        if currentIndex >= users.count { return }
        
        // 第一引数にはnameを特定するための識別詞
        NotificationCenter.default.post(name: Notification.Name("NOPEACTION"), object: nil, userInfo: [
            "id": users[currentIndex].id
        ])
        currentIndex += 1
    }
    
    func likeButtontapped() {
        print("Likeボタンがタップされました。")
    }
}
