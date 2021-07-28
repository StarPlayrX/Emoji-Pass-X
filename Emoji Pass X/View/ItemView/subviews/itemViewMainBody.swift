//
//  itemViewMainBody.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/24/21.
//
import SwiftUI

extension ItemView {
    func itemViewMainBody(_ geometry: GeometryProxy) -> some View {
        Group {
            let device = UIDevice.current.userInterfaceIdiom
            let small = CGFloat(512)
            let large = CGFloat(568)
            
            switch listItem.templateId {
            case 0:
                if device == .pad || device == .mac {
                    geometry.size.height <= small ? creditCardGroup(true) : creditCardGroup(false)
                } else {
                    geometry.size.height <= large ? creditCardGroup(!Device().isIPhoneX()) : creditCardGroup(false)
                }
            case 1:
                if device == .pad || device == .mac {
                    geometry.size.height <= small ? passwordGroup(true) : passwordGroup(false)
                } else {
                    geometry.size.height <= large ? passwordGroup(!Device().isIPhoneX()) : passwordGroup(false)
                }
            case 2:
                if device == .pad || device == .mac {
                    geometry.size.height <= small ? licenseKeyGroup(true) : licenseKeyGroup(false)
                } else {
                    geometry.size.height <= large ? licenseKeyGroup(!Device().isIPhoneX()) : licenseKeyGroup(false)
                }
            default:
                if device == .pad || device == .mac {
                    geometry.size.height <= small ? passwordGroup(true) : passwordGroup(false)
                } else {
                    geometry.size.height <= large ? passwordGroup(!Device().isIPhoneX()) : passwordGroup(false)
                }
            }
        }
    }
}
