//
//  TimelineItem.swift
//  RetoSalud
//
//  Created by Angel HG on 07/06/25.
//

import Foundation
import SwiftUI

struct TimelineItem: Identifiable {
    let id = UUID()
    let iconName: String
    let title: String
    let subtitle: String
    let foregroundStyle: Color
}
