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
    var isSeccureField = false
    var withDivider = true
    var isVertical = false
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(label)
                .foregroundStyle(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            if isSeccureField {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text, axis: isVertical ? .vertical : .horizontal)
                    .textInputAutocapitalization(.never)
                    .keyboardType(keyboardType)
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
