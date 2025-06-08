//
//  ModalView.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import SwiftUI

private struct dataCard: Identifiable {
    let id = UUID()
    let iconName: String
    let title: String
    let subtitle: [String]
    let foregroundStyle: Color
}

struct ModalView: View {
    
    private let data = [
        dataCard(iconName: "sunrise.fill", title: "Desayuno", subtitle: [
            "Tu comida 1",
            "Tu comida 2",
            "Tu comida 3"
        ], foregroundStyle: .yellow),
        dataCard(iconName: "sun.max.fill", title: "Comida", subtitle: [
            "Tu comida 1",
            "Tu comida 2",
            "Tu comida 3"
        ], foregroundStyle: .orange),
        dataCard(iconName: "moon.fill", title: "Cena", subtitle: [
            "Tu comida 1",
            "Tu comida 2",
            "Tu comida 3"
        ], foregroundStyle: .indigo)
    ]
    
    let date: Date
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Niveles de glucosa")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    Text("175 dl/ml")
                        .font(.largeTitle.bold())
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                Spacer()
                VStack(spacing: 8) {
                    Text(date, formatter: DateFormatter.weekdayFormatter)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("\(Calendar.current.component(.day, from: date))")
                        .font(.title)
                        .bold()
                        .foregroundColor(.primary)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(
                    Capsule()
                        .stroke(.pink, lineWidth: 2)
                )
                .padding(.horizontal)
            }
            ScrollView {
                
                ChartModalView()
                    .frame(height: 250)
                
                ForEach(data, id: \.id) { item in
                    // Card content
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text(item.title)
                                .font(.headline)
                            Spacer()
                            Image(systemName: item.iconName)

                        }
                        .foregroundStyle(.secondary)
                        ForEach(item.subtitle, id: \.self) { subtitle in
                            HStack(alignment: .top, spacing: 8) {
                                Text("•")
                                    .font(.headline)
                                Text(subtitle)
                                    .font(.headline)
                            }
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .background(item.foregroundStyle.quaternary)
                    .cornerRadius(20)
                    .padding([.bottom, .horizontal])
                    
                }
            }
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
    
    static let weekdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "EE"
        return formatter
    }()
}

#Preview {
    ModalView(date: .now)
}
