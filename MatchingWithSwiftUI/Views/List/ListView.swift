//
//  ListView.swift
//  MatchingWithSwiftUI
//
//  Created by Manato Abe on 2024/10/25.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject private var viewModel = ListViewModel()
    
    var body: some View {
        Group {
            if viewModel.users.count > 0 {
                NavigationStack {
                    VStack(spacing: 0) {
                        // Cards
                        cards
                        
                        // Actions
                        actions
                    }
                    .background(.black, in : RoundedRectangle(cornerRadius: 15))
                    .padding(.horizontal, 6)
                    .navigationTitle("Fire Match")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            BrandImage(size: .small)
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            NavigationLink {
                                MyPageView()
                            } label: {
                                Image("avatar")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 32, height: 32)
                                    .clipShape(Circle())
                            }
                        }
                    }
                }
                .tint(.black)
            } else {
                //タイムラグに対応
                ProgressView()
                .padding()
                .tint(Color.white)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .scaleEffect(1.5)
            }
        }
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
