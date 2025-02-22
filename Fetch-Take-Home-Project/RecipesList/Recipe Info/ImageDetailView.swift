//
//  ImageDetailView.swift
//  Fetch-Take-Home-Project
//
//  Created by Jenny Shalai on 2025-02-21.
//

import SwiftUI

struct ImageDetailView: View {
    let largeImage: Image
    
    var body: some View {
        ZStack {
            largeImage
                .resizable()
                .scaledToFit()
        }
    }
}
