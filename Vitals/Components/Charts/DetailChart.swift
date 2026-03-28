//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import SwiftUI
import Charts

struct DetailChart: View {

    // MARK: - Properties
    
    let source: Chartable
    
    // MARK: - Lifecycle
    
    init(_ source: Chartable) {
        self.source = source
    }

    // MARK: - View

    var body: some View {
        Text("Detail Chart")
    }

}

// MARK: - Preview

#Preview {
    //DetailChart(<#any Chartable#>)
}
