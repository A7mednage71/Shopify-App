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
    let user: UserProfile
    
    public init(user: UserProfile) {
        self.user = user
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 16) {
            ZStack(alignment: .bottomTrailing) {
                Group {
                    if let urlString = user.profileImageURL, let url = URL(string: urlString) {
                        if #available(iOS 15.0, *) {
                            AsyncImage(url: url) { image in
                                image.resizable().scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .foregroundColor(AppColors.textSecondary.opacity(0.3))
                                .frame(width: 80, height: 80)
                                .background(AppColors.background)
                                .clipShape(Circle())
                        }
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .foregroundColor(AppColors.textSecondary.opacity(0.4))
                            .frame(width: 80, height: 80)
                            .background(AppColors.backgroundSecondary)
                            .clipShape(Circle())
                    }
                }
                .overlay(
                    Circle()
                        .stroke(AppColors.primary.opacity(0.2), lineWidth: 2)
                )
                .shadow(color: AppColors.shadow.opacity(0.2), radius: 4, x: 0, y: 2)
                
                Circle()
                    .fill(AppColors.primary)
                    .frame(width: 26, height: 26)
                    .overlay(
                        Image(systemName: "pencil")
                            .foregroundColor(AppColors.textWhite)
                            .font(.system(size: 11, weight: .bold))
                    )
                    .shadow(color: AppColors.shadow.opacity(0.3), radius: 2, x: 0, y: 1)
                    .offset(x: 2, y: 2)
            }
            
            VStack(alignment: .center, spacing: 6) {
                Text(user.name)
                    .font(AppFonts.title3.weight(.bold))
                    .foregroundColor(AppColors.textPrimary)
                Text(user.email)
                    .font(AppFonts.subheadline)
                    .foregroundColor(AppColors.textSecondary)
            }
            .multilineTextAlignment(.center)
        }
        .padding(.vertical, 28)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .background(AppColors.background)
        .cornerRadius(24)
        .shadow(color: AppColors.shadow.opacity(0.3), radius: 10, x: 0, y: 4)
    }
}
