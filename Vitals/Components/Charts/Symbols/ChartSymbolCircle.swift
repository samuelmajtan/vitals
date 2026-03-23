//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import SwiftUI
import Charts

struct ChartSymbolCircle: ChartSymbolShape , InsettableShape {

    let inset: CGFloat

    var perceptualUnitRect: CGRect {
        CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
    }

    init(inset: CGFloat = 0) {
        self.inset = inset
    }

    func path(in rect: CGRect) -> Path {
        let minimumDimension = min(rect.width, rect.height) - inset * 2
        let frame = CGRect(
            x: rect.midX - minimumDimension / 2,
            y: rect.midY - minimumDimension / 2,
            width: minimumDimension,
            height: minimumDimension
        )
        return Path(ellipseIn: frame)
    }

    func inset(by amount: CGFloat) -> Self {
        .init(inset: inset + amount)
    }

}
