//
// Copyright (c) 2016-2017 wag it GmbH.
// License: MIT
//

import Foundation

/**
    This Layout should only be used on Layoutables whose margins cannot be controlled otherwise, 
    for example the root view of an UIViewController.
    Mirrors the child's layoutModes and frame.
 */
internal struct BayaMarginsLayout: BayaLayout {
    public var layoutModes: BayaLayoutOptions.Modes {
        return element.layoutModes
    }
    public var frame: CGRect {
        return element.frame
    }
    public var layoutMargins: UIEdgeInsets
    private var element: BayaLayoutable
    
    init(
        element: BayaLayoutable,
        layoutMargins: UIEdgeInsets) {
        self.element = element
        self.layoutMargins = layoutMargins
    }

    public mutating func layoutWith(frame: CGRect) {
        element.layoutWith(frame: frame)
    }

    public mutating func sizeThatFits(_ size: CGSize) -> CGSize {
        return element.sizeThatFitsWithMargins(size)
    }
}

internal extension BayaLayoutable {
    func layoutWithMargins(layoutMargins: UIEdgeInsets) -> BayaMarginsLayout {
        return BayaMarginsLayout(
            element: self,
            layoutMargins: layoutMargins)
    }
}
