//
// Copyright (c) 2016-2017 wag it GmbH.
// License: MIT
//

import Foundation

/**
    A layout that uses a fixed size to layout its element.
*/
public struct FixedSizeLayout: BayaLayout {
    public var layoutMargins: UIEdgeInsets
    public var frame: CGRect

    private var element: BayaLayoutable
    private var fixedWidth: CGFloat?
    private var fixedHeight: CGFloat?

    init(
        element: BayaLayoutable,
        width: CGFloat?,
        height: CGFloat?,
        layoutMargins: UIEdgeInsets = UIEdgeInsets.zero) {
        self.fixedWidth = width
        self.fixedHeight = height
        self.element = element
        self.layoutMargins = layoutMargins
        self.frame = CGRect()
    }

    mutating public func layoutWith(frame: CGRect) {
        self.frame = frame
        element.layoutWith(frame: frame)
    }

    public func sizeThatFits(_ size: CGSize) -> CGSize {
        let fit = self.sizeThatFitsWithMargins(of: element, size: size)
        return CGSize(
            width: fixedWidth ?? (fit.width + horizontalMargins(of: element)),
            height: fixedHeight ?? (fit.height + verticalMargins(of: element)))
    }
}

// MARK: Fixed size shortcut

public extension BayaLayoutable {
    func fixedSize(width: CGFloat?, height: CGFloat?) ->
        BayaLayoutable {
        return FixedSizeLayout(element: self, width: width, height: height)
    }
}