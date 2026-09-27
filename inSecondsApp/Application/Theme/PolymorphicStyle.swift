//
//  PolymorphicStyle.swift
//  Expense Tracker
//
//  Created by Aryan Verma on 01/04/26.
//

import SwiftUI

struct PolymorphicStyle: View {
    let isImage: String
    let infinite: Bool
    let alignLeft: Bool
    var body: some View {
        isImage(str: isImage)
    }
    @ViewBuilder
    func isImage(str: String) -> some View {
        if UIImage(systemName: str) != nil {
            Image(systemName: str)
            // Got to iconStyle.swift to edit the iconStyle
                .iconStyle(
                    buttonHeight: ButtonT.HeightT.medium,
                    buttonWidth: infinite ? ButtonT.WidthT.infinite : ButtonT.WidthT.medium,
                    iconColor: .primary, alignLeft: alignLeft
                )
        }
        else if UIImage(named: str) != nil {
            Image(str)
            // Got to iconStyle.swift to edit the iconStyle
                .iconStyle(
                    buttonHeight: ButtonT.HeightT.medium,
                    buttonWidth: infinite ? ButtonT.WidthT.infinite : ButtonT.WidthT.medium,
                    iconColor: .primary, alignLeft: alignLeft
                )
        }
        else {
            Text(str)
            // Go to FontStyle.swift to change buttonStyle
                .amountStyle(fontSize: FontT.primary)
                .foregroundStyle(GetColor.primary)
                .padding(ButtonT.IconPaddingT.medium)
                .frame(
                    maxWidth: infinite ? ButtonT.WidthT.infinite : ButtonT.WidthT.medium,
                    maxHeight: ButtonT.HeightT.medium
                )
        }
    }
}
