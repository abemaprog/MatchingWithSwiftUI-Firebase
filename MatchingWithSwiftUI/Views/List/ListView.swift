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
                CardView(user: user) { isRedo in
                    viewModel.adjustIndex(isRedo: isRedo)
                }
            }
        }
    }
    
    private var actions: some View {
        HStack(spacing: 60) {
            // Nope, Redo, Lile
            ForEach(Action.allCases, id: \.self) { type in
                type.createActionButton(viewModel: viewModel)
            }

        }
        .frame(height: 100)
        .foregroundColor(.white)
    }
}
