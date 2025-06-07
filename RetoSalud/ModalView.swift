//
//  ModalView.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import SwiftUI

struct ModalView: View {
    let date: Date
    var body: some View {
        VStack {
            Text("Fecha seleccionada")
                .font(.headline)
            Text(date, formatter: DateFormatter.fullDateFormatter)
                .font(.title)
                .padding()
        }
    }
}

private extension DateFormatter {
    static let fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateStyle = .full
        return formatter
    }()
}

#Preview {
    ModalView(date: .now)
}
