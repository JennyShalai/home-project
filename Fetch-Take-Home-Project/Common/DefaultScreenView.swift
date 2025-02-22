//
//  DefaultScreenView.swift
//  Fetch-Take-Home-Project
//
//  Created by Jenny Shalai on 2025-02-19.
//

import SwiftUI

struct DefaultScreenView: View {
    let text: String
    let image: String
    let color: Color
    
    init(text: String, image: String, color: Color = .black) {
        self.text = text
        self.image = image
        self.color = color
    }
    
    var body: some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundColor(color)
            Text(text)
                .font(.title2)
        }
    }
}
