//
//  CustomOperators.swift
//  Loom
//
//  Created by Aaron Haight on 12/5/25.
//

import Foundation
import SwiftUI

// UI is weird so we need to make a custom operator for unwrapping
public func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
