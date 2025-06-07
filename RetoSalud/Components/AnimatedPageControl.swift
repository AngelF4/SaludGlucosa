//
//  AnimatedPageControl.swift
//  RetoSalud
//
//  Created by Alejandro on 07/06/25.
//

import SwiftUI

struct AnimatedPageControl: View {
    var numberOfPages: Int
    var currentPage: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Capsule()
                    .fill(index == currentPage ? Color.pink : Color.pink)
                    .frame(width: index == currentPage ? 35 : 10, height: 10)
                    .animation(.easeInOut(duration: 0.3), value: currentPage)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    AnimatedPageControl(numberOfPages: 4, currentPage: 1)
}
