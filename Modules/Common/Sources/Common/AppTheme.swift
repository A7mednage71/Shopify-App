import Foundation
import SwiftUI

private enum AppColorAsset {
    static func color(_ name: String) -> Color {
        Color(name, bundle: .module)
    }
}

public enum AppColors {
    public static let primary = Color.appPrimaryOrange
    public static let primaryDark = Color.appPrimaryOrangeDark
    public static let primaryLight = Color.appPrimaryOrangeSecondary

    public static let secondary = Color.appPrimaryPink
    public static let background = Color.appBackgroundWhite
    public static let backgroundSecondary = Color.appBackgroundGray
    public static let textPrimary = Color.appTextPrimary
    public static let textSecondary = Color.appTextSecondary
    public static let textTertiary = Color.appTextTertiary
    public static let textWhite = Color.appTextWhite
    public static let border = Color.appBorderLight
    public static let shadow = Color.appCardShadow
    public static let success = Color.appSuccessGreen
    public static let error = Color.appErrorRed
    public static let disabled = Color.appDisabled
}

public enum AppFonts {
    public static let largeTitle = Font.system(size: 34, weight: .bold)
    public static let title1 = Font.system(size: 28, weight: .bold)
    public static let title2 = Font.system(size: 22, weight: .semibold)
    public static let title3 = Font.system(size: 20, weight: .semibold)
    public static let headline = Font.system(size: 17, weight: .semibold)
    public static let body = Font.system(size: 17)
    public static let callout = Font.system(size: 16)
    public static let subheadline = Font.system(size: 15)
    public static let footnote = Font.system(size: 13)
    public static let caption = Font.system(size: 12)

    public static func customFont(name: String, size: CGFloat) -> Font {
        Font.custom(name, size: size)
    }
}

public extension Color {
    static let appPrimaryOrange = AppColorAsset.color("AppPrimaryOrange")
    static let appPrimaryOrangeDark = AppColorAsset.color("AppPrimaryOrangeDark")
    static let appPrimaryOrangeSecondary = AppColorAsset.color("AppPrimaryOrangeSecondary")
    static let appPrimaryPink = AppColorAsset.color("AppPrimaryPink")

    static let appBackgroundWhite = AppColorAsset.color("AppBackgroundWhite")
    static let appBackgroundGray = AppColorAsset.color("AppBackgroundGray")
    static let appSearchBarBg = AppColorAsset.color("AppSearchBarBg")

    static let appTextPrimary = AppColorAsset.color("AppTextPrimary")
    static let appTextSecondary = AppColorAsset.color("AppTextSecondary")
    static let appTextTertiary = AppColorAsset.color("AppTextTertiary")
    static let appTextStrikePrice = AppColorAsset.color("AppTextStrikePrice")
    static let appTextWhite = AppColorAsset.color("AppTextWhite")
    static let appTextWhiteSecondary = AppColorAsset.color("AppTextWhiteSecondary")
    static let appTextWhiteTertiary = AppColorAsset.color("AppTextWhiteTertiary")

    static let appSearchIcon = AppColorAsset.color("AppSearchIcon")
    static let appStarFilled = AppColorAsset.color("AppStarFilled")
    static let appStarEmpty = AppColorAsset.color("AppStarEmpty")

    static let appBorderLight = AppColorAsset.color("AppBorderLight")
    static let appBorderMedium = AppColorAsset.color("AppBorderMedium")

    static let appWhiteOverlayLight = AppColorAsset.color("AppWhiteOverlayLight")
    static let appWhiteOverlayMedium = AppColorAsset.color("AppWhiteOverlayMedium")
    static let appCardShadow = AppColorAsset.color("AppCardShadow")
    static let appOrangeShadow = AppColorAsset.color("AppOrangeShadow")

    static let appSuccessGreen = AppColorAsset.color("AppSuccessGreen")
    static let appErrorRed = AppColorAsset.color("AppErrorRed")
    static let appDisabled = AppColorAsset.color("AppDisabled")
}

public extension Font {
    static let appBarTitle = Font.system(size: 18, weight: .bold)

    static let heroTitle = Font.system(size: 30, weight: .bold)
    static let heroSubtitle = Font.system(size: 15, weight: .medium)
    static let bannerTitle = Font.system(size: 24, weight: .bold)
    static let bannerSubtitle = Font.system(size: 14, weight: .medium)

    static let sectionTitle = Font.system(size: 20, weight: .bold)
    static let sectionAction = Font.system(size: 13, weight: .semibold)
    static let offerTitle = Font.system(size: 16, weight: .bold)
    static let offerSubtitle = Font.system(size: 13, weight: .regular)

    static let productName = Font.system(size: 14, weight: .semibold)
    static let productDesc = Font.system(size: 12, weight: .regular)
    static let productPrice = Font.system(size: 15, weight: .bold)
    static let productOldPrice = Font.system(size: 12, weight: .regular)
    static let productDiscount = Font.system(size: 12, weight: .semibold)
    static let reviewCount = Font.system(size: 11, weight: .regular)

    static let buttonPrimary = Font.system(size: 15, weight: .bold)
    static let buttonSmall = Font.system(size: 12, weight: .semibold)
    static let dealButtonIcon = Font.system(size: 12, weight: .bold)

    static let dealIcon = Font.system(size: 16, weight: .bold)
    static let dealIndicator = Font.system(size: 13, weight: .semibold)
    static let timerText = Font.system(size: 12, weight: .bold)
    static let dealUnitLabel = Font.system(size: 10, weight: .medium)

    static let searchPlaceholder = Font.system(size: 15, weight: .regular)
}

public extension View {
    func categoryLabelStyle() -> some View {
        font(.system(size: 11, weight: .medium))
            .foregroundColor(.appTextPrimary)
    }

    func sectionTitleStyle() -> some View {
        font(.sectionTitle)
            .foregroundColor(.appTextPrimary)
    }
}
