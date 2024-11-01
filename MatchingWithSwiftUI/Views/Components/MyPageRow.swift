//
//  MyPageRow.swift
//  MatchingWithSwiftUI
//
//  Created by Manato Abe on 2024/10/31.
//

import SwiftUI

struct MyPageRow: View {
    
    let iconname: String
    let label: String
    let tintColor: Color
    var value: String? = nil
    
    var body: some View {
        HStack {
            Image(systemName: iconname)
                .imageScale(.large)
                .foregroundStyle(tintColor)
            
            Text(label)
                .font(.subheadline)
                .foregroundColor(.black)
            
            if let value = value {
                Spacer()
                Text(value)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    MyPageRow(iconname: "person.fill", label: "label", tintColor: .red, value: "1.0.0")
}
