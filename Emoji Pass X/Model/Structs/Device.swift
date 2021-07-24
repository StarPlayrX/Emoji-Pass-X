//
//  Device.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/14/21.
//

import UIKit

struct Device {
    func iPhoneXMag() -> CGFloat {
        UIDevice.current.hasNotch ? 12.0 : 8.0
    }

    func iPhoneXSearch() -> CGFloat {
        UIDevice.current.hasNotch ? 38.0 : 34.0
    }

    func iPhoneXLeading() -> CGFloat {
        UIDevice.current.hasNotch ? -16.0 : -8.0
    }

    func iPhoneXCell() -> CGFloat {
        UIDevice.current.hasNotch ? 8.0 : 4.0
    }

    func isIPhoneX() -> Bool {
        UIDevice.current.hasNotch
    }
}
