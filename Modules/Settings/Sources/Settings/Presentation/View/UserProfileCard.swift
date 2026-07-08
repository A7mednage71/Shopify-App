//
//  SwiftUIView.swift
//  
//
//  Created by Esraa Ehab on 02/07/2026.
//

import SwiftUI
import Common

@available(iOS 14.0, *)
public struct UserProfileCard: View {
    let state: CustomerProfileState
    let onRetry: () -> Void
    let onEdit: () -> Void
    
    public init(
        state: CustomerProfileState,
        onRetry: @escaping () -> Void,
        onEdit: @escaping () -> Void
    ) {
        self.state = state
        self.onRetry = onRetry
        self.onEdit = onEdit
    }
    
    public var body: some View {
        Group {
            switch state {
            case .idle, .loading:
                loadingContent
            case .success(let profile):
                profileContent(profile)
            case .failure(let message):
                failureContent(message)
            }
        }
        .padding(.vertical, 28)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .background(AppColors.background)
        .cornerRadius(24)
        .shadow(color: AppColors.shadow.opacity(0.3), radius: 10, x: 0, y: 4)
    }

    private var loadingContent: some View {
        VStack(alignment: .center, spacing: 14) {
            ProgressView()
                .tint(AppColors.primary)

            Text("Loading profile")
                .font(AppFonts.subheadline.weight(.semibold))
                .foregroundColor(AppColors.textSecondary)
        }
        .frame(minHeight: 132)
    }

    private func profileContent(_ profile: CustomerProfile) -> some View {
        VStack(alignment: .center, spacing: 16) {
            ZStack(alignment: .bottomTrailing) {
                CachedImage(urlString: nil, failureImageName: "product_placeholder")
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(AppColors.primary.opacity(0.2), lineWidth: 2)
                )
                .shadow(color: AppColors.shadow.opacity(0.2), radius: 4, x: 0, y: 2)
                
                Button(action: onEdit) {
                    Circle()
                        .fill(AppColors.primary)
                        .frame(width: 26, height: 26)
                        .overlay(
                            Image(systemName: "pencil")
                                .foregroundColor(AppColors.textWhite)
                                .font(.system(size: 11, weight: .bold))
                        )
                        .shadow(color: AppColors.shadow.opacity(0.3), radius: 2, x: 0, y: 1)
                }
                .buttonStyle(.plain)
                .offset(x: 2, y: 2)
            }
            
            VStack(alignment: .center, spacing: 6) {
                Text(profile.displayName)
                    .font(AppFonts.title3.weight(.bold))
                    .foregroundColor(AppColors.textPrimary)
                Text(profile.displayEmail)
                    .font(AppFonts.subheadline)
                    .foregroundColor(AppColors.textSecondary)
            }
            .multilineTextAlignment(.center)
        }
    }

    private func failureContent(_ message: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: "person.crop.circle.badge.exclamationmark")
                .font(.system(size: 38, weight: .semibold))
                .foregroundColor(AppColors.primary)

            Text(message)
                .font(AppFonts.subheadline)
                .foregroundColor(AppColors.textSecondary)
                .multilineTextAlignment(.center)

            Button(action: onRetry) {
                Text("Retry")
                    .font(AppFonts.callout.weight(.bold))
                    .foregroundColor(AppColors.primary)
            }
            .buttonStyle(.plain)
        }
    }
}
