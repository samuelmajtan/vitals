//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

@inlinable
func with<V>(_ value: V, modify: @escaping (inout V) -> Void) -> V {
    var value = value
    modify(&value)
    return value
}

@inlinable
func copy<P, Value>(_ p: P, modifying keyPath: WritableKeyPath<P, Value>, to newValue: Value) -> P {
    var copy = p
    copy[keyPath: keyPath] = newValue
    return copy
}

@inlinable
func round<T>(_ value: T, toNearest: T) -> T where T: BinaryFloatingPoint {
    round(value / toNearest) * toNearest
}

@inlinable
func round<T>(_ value: T, toNearest: T) -> T where T: BinaryInteger {
    T(round(Double(value), toNearest: Double(toNearest)))
}

@inlinable
func clamp<T>(_ x: T, min y: T, max z: T) -> T where T: Comparable {
    min(max(x, y), z)
}
