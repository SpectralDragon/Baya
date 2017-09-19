//
// Copyright (c) 2016-2017 wag it GmbH.
// License: MIT
//

import Foundation
import UIKit

/**
    Wraps a Layoutable in order to modify its layout modes.
    Mirrors layout modes and frame from its child.
 */
public struct BayaMatchParentLayout: BayaLayout {
    public var layoutMargins: UIEdgeInsets {
        return element.layoutMargins
    }
    public var frame: CGRect {
        return element.frame;
    }
    public var layoutModes: BayaLayoutOptions.Modes = BayaLayoutOptions.Modes.default

    private var element: BayaLayoutable

    init(
        element: BayaLayoutable,
        layoutModes: BayaLayoutOptions.Modes) {
        self.element = element
        self.layoutModes = layoutModes
    }

    mutating public func layoutWith(frame: CGRect) {
        element.layoutWith(frame: frame)
    }

    public mutating func sizeThatFits(_ size: CGSize) -> CGSize {
        return element.sizeThatFits(size)
    }
}

public extension BayaLayoutable {
    /// Specifies that the element should fill its parent's width.
    /// - returns: A BayaMatchParentLayout.
    func layoutMatchingParentWidth() -> BayaLayout {
        return BayaMatchParentLayout(
            element: self,
            layoutModes: BayaLayoutOptions.Modes(
                width: .matchParent,
                height: .wrapContent))
    }

    /// Specifies that the element should fill its parent's height.
    /// - returns: A BayaMatchParentLayout.
    func layoutMatchingParentHeight() -> BayaLayout {
        return BayaMatchParentLayout(
            element: self,
            layoutModes: BayaLayoutOptions.Modes(
                width: .wrapContent,
                height: .matchParent))
    }

    /// Specifies that the element should fill its parent's size.
    /// - returns: A BayaMatchParentLayout.
    func layoutMatchingParent()
            -> BayaLayout {
        return BayaMatchParentLayout(
            element: self,
            layoutModes: BayaLayoutOptions.Modes(
                width: .matchParent,
                height: .matchParent))
    }
}
