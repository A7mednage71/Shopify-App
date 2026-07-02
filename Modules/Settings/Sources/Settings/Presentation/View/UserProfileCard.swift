//
//  SwiftUIView.swift
//  
//
//  Created by Esraa Ehab on 02/07/2026.
//

import SwiftUI

@available(iOS 14.0, *)
public struct UserProfileCard: View {
    let user: UserProfile
    let primaryOrange = Color(red: 255/255, green: 161/255, blue: 2/255)
    
    public init(user: UserProfile) {
        self.user = user
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 16) {
            
            ZStack(alignment: .bottomTrailing) {
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
                            .foregroundColor(.gray.opacity(0.3))
                            .frame(width: 80, height: 80) 
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .foregroundColor(.gray.opacity(0.3))
                        .frame(width: 80, height: 80) 
                        .background(Color.white)
                        .clipShape(Circle())
                }
                
                Circle()
                    .fill(primaryOrange)
                    .frame(width: 24, height: 24)
                    .overlay(Image(systemName: "pencil").foregroundColor(.white).font(.system(size: 12)))
                    .offset(x: 2, y: 2)
            }
            
            VStack(alignment: .center, spacing: 4) {
                Text(user.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .multilineTextAlignment(.center)
            
        }
        .padding(.vertical, 24) 
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .background(Color(red: 252/255, green: 243/255, blue: 230/255))
        .cornerRadius(20)
    }
}
