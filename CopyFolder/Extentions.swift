//
//  Extentions.swift
//  CopyFolder
//
//  Created by Eric Hemmeter on 10/10/23.
//

import SwiftUI

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
