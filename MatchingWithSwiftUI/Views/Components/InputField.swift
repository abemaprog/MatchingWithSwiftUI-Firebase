//
//  InputField.swift
//  MatchingWithSwiftUI
//
//  Created by Manato Abe on 2024/10/29.
//

import SwiftUI

struct InputField: View {
    
    @Binding var text: String
    let label: String
    let placeholder: String
    var isSecureField = false
    var withDivider = true
    var isVertical = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(label)
                .foregroundStyle(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text, axis: isVertical ? .vertical : .horizontal) //axis: .verticalで複数行に対応できる
            }
            
            if withDivider {
                Divider()
            }
        }
    }
}

#Preview {
    InputField(text: .constant(""), label: "メールアドレス", placeholder: "入力してください")
}
