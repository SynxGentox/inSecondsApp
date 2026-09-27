//
//  iconStyle.swift
//  Expense Tracker
//
//  Created by Aryan Verma on 30/03/26.
//

import SwiftUI

extension Image {
    func iconStyle(buttonHeight: CGFloat, buttonWidth: CGFloat, iconColor: Color, alignLeft: Bool) -> some View {
        self
            .resizable()
            .scaledToFit()
            .fontWeight(.regular)
            .foregroundStyle(iconColor)
            .padding(ButtonT.IconPaddingT.medium)
            .frame(maxWidth: buttonWidth, maxHeight: buttonHeight, alignment: alignLeft ? .leading : .center)
    }
}

