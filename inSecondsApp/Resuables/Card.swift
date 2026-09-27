//
//  Card.swift
//  Expense Tracker
//
//  Created by Aryan Verma on 30/03/26.
//

import SwiftUI

extension View {
    @ViewBuilder
    func card(color: Color, radius: CGFloat) -> some View {
        self.background(color)
            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
    }
}
