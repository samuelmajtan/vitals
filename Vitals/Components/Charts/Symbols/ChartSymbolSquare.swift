//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import SwiftUI
import Charts

struct ChartSymbolSquare: ChartSymbolShape, InsettableShape {

    // MARK: - Properties

    let inset: CGFloat

    var perceptualUnitRect: CGRect {
        let scaleAdjustment: CGFloat = 0.75
        return CGRect(
            x: 0.5 - scaleAdjustment / 2,
            y: 0.5 - scaleAdjustment / 2,
            width: scaleAdjustment,
            height: scaleAdjustment
        )
    }

    // MARK: - Lifecycle

    init(inset: CGFloat = 0) {
        self.inset = inset
    }

    // MARK: - Methods

    func path(in rect: CGRect) -> Path {
        let cornerRadius: CGFloat = 1
        let minDimension = min(rect.width, rect.height)
        return Path(
            roundedRect: .init(
                x: rect.midX - minDimension / 2,
                y: rect.midY - minDimension / 2,
                width: minDimension,
                height: minDimension
            ),
            cornerRadius: cornerRadius
        )
    }

    func inset(by amount: CGFloat) -> ChartSymbolSquare {
        ChartSymbolSquare(inset: inset + amount)
    }

}
