//
//  itemViewFooter.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/24/21.
//
import SwiftUI

extension ItemView {
    func itemViewFooter(geometry: GeometryProxy) -> some View {
        Group {
            let device = UIDevice.current.userInterfaceIdiom
            let small = CGFloat(512)
            let large = CGFloat(568)
            
            /// template = {0: "💳 Cards", 1: "🔒 Passwords", 2: "🔑 Keys"}
            switch listItem.templateId {
            case 0:
                if device == .pad || device == .mac {
                    geometry.size.height <= small ? creditCardStack(true) : creditCardStack(false)
                } else {
                    geometry.size.height <= large ? creditCardStack(!Device().isIPhoneX()) : creditCardStack(false)
                }
            case 1:
                if device == .pad || device == .mac {
                    geometry.size.height <= small ? passwordStack(true) : passwordStack(false)
                } else {
                    geometry.size.height <= large ? passwordStack(!Device().isIPhoneX()) : passwordStack(false)
                }
            case 2:
                if device == .pad || device == .mac {
                    geometry.size.height <= small ? licenseKeyStack(true) : licenseKeyStack(false)
                } else {
                    geometry.size.height <= large ? licenseKeyStack(!Device().isIPhoneX()) : licenseKeyStack(false)
                }
            default:
                if device == .pad || device == .mac {
                    geometry.size.height <= small ? passwordStack(true) : passwordStack(false)
                } else {
                    geometry.size.height <= large ? passwordStack(!Device().isIPhoneX()) : passwordStack(false)
                }
            }
        }
    }
}
