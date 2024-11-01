//
//  CardView.swift
//  MatchingWithSwiftUI
//
//  Created by Manato Abe on 2024/10/25.
//

import SwiftUI

struct CardView: View {
    
    @State private var offset: CGSize = .zero //位置
    let user: User
    let adjustIndex: (Bool) -> Void
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Background
            Color.black
            
            // Image
            imageLayer
            
            // Gradient
            //第一引数に開始点と終了点のカラー
            //第二引数から第三引数にかけて第一引数で設定したカラーのグラデーション
            LinearGradient(colors: [.clear, .black], startPoint: .center, endPoint: .bottom)
            
            //Infomation
            infomationLayer
            
            //Like and Nope
            LikeandNope
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .offset(offset)
        .gesture(gesture)
        .scaleEffect(scale) //画像の比を保ったまま拡大、縮小できる
        .rotationEffect(.degrees(angle))
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ACTIONFROMBUTTON"), object: nil)) { data in
            receiveHandler(data: data)
        }
    }
}

#Preview {
    ListView()
}
// MARK: -UI
extension CardView {
    private var imageLayer: some View {
        Image(user.photoUrl ?? "avatar") // アンラップする必要 nil結合演算子
            .resizable()
            .aspectRatio(contentMode: .fill) //元の縦横比を維持
            .frame(width: 100)
    }
    
    private var infomationLayer: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text(user.name)
                    .font(.largeTitle.bold())
                Text("\(user.age)")
                    .font(.title2)
                Image(systemName: "checkmark.seal.fill")
                    .foregroundStyle(.white, .blue)
                    .font(.title2)
            }
            // messageがある場合にのみ処理実行
            // nil結合演算子でも良いが、messageが表示されない方がUI的にも良い
            if let message = user.message {
                Text(message)
            }
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    private var LikeandNope: some View {
        HStack {
            //Lile
            Text("Like")
                .likeNopeText(isLiked: true)
                .opacity(opacity)
            
            Spacer()
            
            //Nope
            Text("Nope")
                .likeNopeText(isLiked: false)
                .opacity(-opacity)
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

// MARK: -Action
extension CardView {
    private var screenWidth: CGFloat {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return 0.0 }
        return window.screen.bounds.width
    }
    
    private var scale: CGFloat {
        return max(1.0 - (abs(offset.width) / screenWidth), 0.75)
    }
    
    private var angle: Double {
        return (offset.width / screenWidth) * 10.0
    }
    
    private var opacity: Double {
        return (offset.width / screenWidth) * 4.0
    }
    
    private func removeCard(isLiked: Bool, height: CGFloat = 0.0) {
        withAnimation(.smooth) {
            offset = CGSize(width: isLiked ? screenWidth * 1.5 : -screenWidth * 1.5, height: height)
        }
        adjustIndex(false)
    }
    
    private func resetCard() {
        withAnimation(.smooth) {
            offset = .zero
        }
        adjustIndex(true)
    }
    
    // someによりさまざまな型を内包した抽象的なデータ型を表現できる
    private var gesture: some Gesture {
        DragGesture()
        //変化を感知する
        //省略構文（doc見る）
            .onChanged { value in
                //translation:x,y軸のそれぞれ変更された値を取得
                let width = value.translation.width
                let height = value.translation.height
                //三項演算子（好き）
                //min, max関数
                let limitedHeight = height > 0 ? min(height, 100) : max(height, -100)
                offset = CGSize(width: width, height: limitedHeight)
            }
            .onEnded { value in
                let width = value.translation.width
                let height = value.translation.height
                
                // 1/4以上外（日本語？）だったら外に飛ばす。
                guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                let screenWidth = window.screen.bounds.width
                //絶対値に変換
                if (abs(width) > (screenWidth/4)) {
                    removeCard(isLiked: width > 0, height: height)
                } else {
                    resetCard()
                }
            }
    }
    private func receiveHandler(data: NotificationCenter.Publisher.Output) {
        guard
            let info = data.userInfo,
            let id = info["id"] as? String,
            let action = info["action"] as? Action
        else { return }
        
        if id == user.id {
            switch action {
                
            case .nope:
                removeCard(isLiked: false)
            case .redo:
                resetCard()
            case .like:
                removeCard(isLiked: true)
            }
        }
    }
}

