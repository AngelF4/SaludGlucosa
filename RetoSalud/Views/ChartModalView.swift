//
//  ChartModalView.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import SwiftUI
import Charts

struct GlucoseData: Identifiable {
    let id = UUID()
    let time: Date
    let level: Double
}

struct ChartModalView: View {
    // Datos de ejemplo para las 3 comidas del día
    let data: [GlucoseData] = [
        GlucoseData(time: Calendar.current.date(bySettingHour: 6, minute: 0, second: 0, of: .now)!, level:  90),
        GlucoseData(time: Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: .now)!, level: 175),
        GlucoseData(time: Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: .now)!, level: 110),
        GlucoseData(time: Calendar.current.date(bySettingHour: 15, minute: 0, second: 0, of: .now)!, level: 165),
        GlucoseData(time: Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: .now)!, level:  95),
        GlucoseData(time: Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: .now)!, level: 140),
        GlucoseData(time: Calendar.current.date(bySettingHour: 23, minute: 0, second: 0, of: .now)!, level:  87),
    ]

    var body: some View {
        Chart {
            ForEach(data) { point in
                AreaMark(
                    x: .value("Hora", point.time),
                    y: .value("Glucosa", point.level)
                )
                .foregroundStyle(Gradient(colors: [.pink, .clear]))
                .interpolationMethod(.catmullRom)

                LineMark(
                    x: .value("Hora", point.time),
                    y: .value("Glucosa", point.level)
                )
                .interpolationMethod(.catmullRom)

                PointMark(
                    x: .value("Hora", point.time),
                    y: .value("Glucosa", point.level)
                )
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .hour, count: 3)) { value in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.hour().minute(), centered: true)
            }
        }
        .chartYScale(domain: 0...160)
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .padding()
        .navigationTitle("Glucosa Diaria")
    }
}

#Preview {
    ChartModalView()
}
