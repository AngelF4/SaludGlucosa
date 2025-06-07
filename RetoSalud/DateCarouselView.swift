//
//  DateCarouselView.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import SwiftUI

struct DateCarouselView: View {
    @Binding var selectedDate: Date
    @State private var modalDate: Date? = nil

    private let dates: [Date] = {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let weekday = calendar.component(.weekday, from: today)
        let startOfWeek = calendar.date(byAdding: .day, value: -(weekday - 1), to: today)!
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }()

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(dates, id: \.self) { date in
                        let isToday = Calendar.current.isDate(date, inSameDayAs: Date())
                        VStack(spacing: 8) {
                            Text(date, formatter: DateFormatter.weekdayFormatter)
                                .font(.subheadline)
                                .foregroundColor(isToday ? .primary : .secondary)
                            Text("\(Calendar.current.component(.day, from: date))")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.primary)
                        }
                        .id(date)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(
                            Group {
                                if isToday {
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(Color.pink.opacity(0.2))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 25)
                                                .stroke(Color.pink, lineWidth: 2)
                                        )
                                }
                            }
                        )
                        .padding(.vertical, 5)
                        .onTapGesture {
                            selectedDate = date
                            modalDate = date
                            withAnimation {
                                proxy.scrollTo(date, anchor: .center)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .onAppear {
                let today = Calendar.current.startOfDay(for: Date())
                proxy.scrollTo(today, anchor: .center)
            }
        }
        .sheet(item: $modalDate) { date in
            ModalView(date: date)
                .presentationDetents([.large])
        }
    }
}


private extension DateFormatter {
    static let weekdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "EE"
        return formatter
    }()
}

extension Date: @retroactive Identifiable {
    public var id: Date { self }
}

#Preview {
    @Previewable @State var date: Date = .now
    DateCarouselView(selectedDate: $date)
}
