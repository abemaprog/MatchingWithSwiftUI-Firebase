//
//  BrandImage.swift
//  MatchingWithSwiftUI
//
//  Created by Manato Abe on 2024/10/29.
//

import SwiftUI

enum BrandImageSize: CGFloat {
    case large = 120
    case small = 32
}

struct BrandImage: View {
    
    let size: BrandImageSize
    
    var body: some View {
        LinearGradient(
            colors: [.brandColorLight, .brandColorDark],
            startPoint: .topTrailing,
            endPoint: .bottomLeading
        )
        .mask {
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
        }
        .frame(width: size.rawValue, height: size.rawValue)
        
        
//        Image(systemName: "flame.circle.fill")
//            .resizable()
//            .scaledToFill()
//            .foregroundStyle(.red)
//            .frame(width: size.rawValue, height: size.rawValue)
//            .padding(.vertical, 32)
    }
}

#Preview {
    BrandImage(size: .large)
}
