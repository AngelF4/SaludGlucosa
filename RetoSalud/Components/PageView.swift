//
//  PageView.swift
//  Taggo
//
//  Created by Yahir Fuentes on 29/05/25.
//

import SwiftUI

struct PageView: View {
    var page: Page
    
    var body: some View {
        VStack(spacing: 20){
            Image("\(page.imageUrl)")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                            .clipped()
                            .cornerRadius(25)
                            .background(Color.gray.opacity(0.10))
                            .cornerRadius(10)
                            .padding()
                
            
            Text(page.name)
                .font(.title)
                .fontWeight(.semibold)
            
            Text(page.description)
                .font(.title3)
                .frame(width: 300)
        }
    }
}

#Preview {
    PageView(page: Page.samplePage)
}
