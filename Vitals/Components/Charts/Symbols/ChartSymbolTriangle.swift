//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation
import SwiftUI
import Charts

struct ChartSymbolTriangle: ChartSymbolShape, InsettableShape {

    let inset: CGFloat
    
    var perceptualUnitRect: CGRect {
        CGRect(
            x: 0.15,
            y: 0.15,
            width: 0.7,
            height: 0.7
        )
    }
    
    init(inset: CGFloat = 0) {
        self.inset = inset
    }
    
    func path(in rect: CGRect) -> Path {
        let minimumDimension = min(rect.width, rect.height) - inset * 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        let half = minimumDimension / 2
        
        var path = Path()
        path.move(to: CGPoint(x: center.x, y: center.y - half))
        path.addLine(to: CGPoint(x: center.x - half, y: center.y + half))
        path.addLine(to: CGPoint(x: center.x + half, y: center.y + half))
        path.closeSubpath()
        
        return path
    }

    func inset(by amount: CGFloat) -> Self {
        .init(inset: inset + amount)
    }

}
