//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import NavigatorUI

struct KnownCheckpoints: NavigationCheckpoints {
    
    static var home: NavigationCheckpoint<Void> { checkpoint() }
    static var health: NavigationCheckpoint<Void> { checkpoint() }
    static var search: NavigationCheckpoint<Void> { checkpoint() }

}
