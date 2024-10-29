//
//  ListView.swift
//  MatchingWithSwiftUI
//
//  Created by Manato Abe on 2024/10/25.
//

import SwiftUI

struct ListView: View {
    
    private let viewModel = ListViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            // Cards
            cards
            
            // Actions
            actions
        }
        .background(.black, in : RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal, 6)
    }
}

#Preview {
    ListView()
}

extension ListView {
    private var cards: some View {
        ZStack {
            // UserがIdentifiableに準拠（ユニークなことを保証）しているため、第二引数にidを渡す必要がない。
            ForEach(viewModel.users.reversed()) { user in
                CardView(user: user)
            }
        }
    }
    
    private var actions: some View {
        HStack(spacing: 60) {
            // Nope
            Button {
                viewModel.nopeButtontapped()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.red)
                    .background {
                        Circle()
                            .stroke(.red, lineWidth: 1)
                            .frame(width: 60, height: 60)
                    }
            }
            
            // 戻す
            Button {
                print("ボタンがタップされました")
            } label: {
                Image(systemName: "arrow.counterclockwise")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.yellow)
                    .background {
                        Circle()
                            .stroke(.red, lineWidth: 1)
                            .frame(width: 50, height: 50)
                    }
            }
            
            // Like
            Button {
                print("ボタンがタップされました")
            } label: {
                Image(systemName: "heart")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.mint)
                    .background {
                        Circle()
                            .stroke(.red, lineWidth: 1)
                            .frame(width: 60, height: 60)
                    }
            }

        }
        .frame(height: 100)
        .foregroundColor(.white)
    }
}
