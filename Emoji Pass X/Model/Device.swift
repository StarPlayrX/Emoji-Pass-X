//
//  Device.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/14/21.
//

import UIKit

func iPhoneXMag() -> CGFloat {
    return UIDevice.current.hasNotch ? 12 : 8
}

func iPhoneXSearch() -> CGFloat {
    return UIDevice.current.hasNotch ? 38 : 34
}

func iPhoneXLeading() -> CGFloat {
    return UIDevice.current.hasNotch ? -16.0 : -8.0
}

func iPhoneXCell() -> CGFloat {
    return UIDevice.current.hasNotch ? 8.0 : 4.0
}

func isIPhoneX() -> Bool {
    return UIDevice.current.hasNotch ? true : false
}

public extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
