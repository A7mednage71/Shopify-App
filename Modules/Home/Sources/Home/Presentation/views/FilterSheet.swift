import SwiftUI
import Common

struct FilterSheet: View {
    @Binding var filterState: FilterState
    let availableVendors: [String]
    let availableProductTypes: [String]
    let availableTags: [String]
    let onApply: () -> Void
    let onReset: () -> Void
    
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var currentMaxPrice: Double = 2000
    private let maxLimit: Double = 5000
    
    private let availableSizes = ["S", "M", "L", "XL", "XXL"]
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Color.appBackgroundGray
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        
                        // 1. Price slider section
                        VStack(alignment: .leading, spacing: 14) {
                            HStack {
                                Text("Max Price")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.appTextPrimary)
                                Spacer()
                                Text("$\(Int(currentMaxPrice))")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.appPrimaryOrange)
                            }
                            
                            Slider(value: $currentMaxPrice, in: 0...maxLimit, step: 10)
                                .accentColor(.appPrimaryOrange)
                            
                            HStack {
                                Text("$0").font(.caption).foregroundColor(.appTextTertiary)
                                Spacer()
                                Text("$\(Int(maxLimit))").font(.caption).foregroundColor(.appTextTertiary)
                            }
                        }
                        .padding()
                        .background(Color.appBackgroundWhite)
                        .cornerRadius(16)
                        
                        // 2. Brands section
                        if !availableVendors.isEmpty {
                            VStack(alignment: .leading, spacing: 14) {
                                Text("Brands")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.appTextPrimary)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(availableVendors, id: \.self) { vendor in
                                            let isSelected = filterState.selectedVendors.contains(vendor)
                                            Text(vendor)
                                                .font(.system(size: 13, weight: .medium))
                                                .foregroundColor(isSelected ? .white : .appTextPrimary)
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 10)
                                                .background(isSelected ? Color.appPrimaryOrange : Color.appBackgroundGray.opacity(0.6))
                                                .cornerRadius(10)
                                                .onTapGesture {
                                                    if isSelected {
                                                        filterState.selectedVendors.remove(vendor)
                                                    } else {
                                                        filterState.selectedVendors.insert(vendor)
                                                    }
                                                }
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color.appBackgroundWhite)
                            .cornerRadius(16)
                        }
                        
                        // 3. Product Types section
                        if !availableProductTypes.isEmpty {
                            VStack(alignment: .leading, spacing: 14) {
                                Text("Product Types")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.appTextPrimary)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(availableProductTypes, id: \.self) { type in
                                            let isSelected = filterState.selectedProductTypes.contains(type)
                                            Text(type)
                                                .font(.system(size: 13, weight: .medium))
                                                .foregroundColor(isSelected ? .white : .appTextPrimary)
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 10)
                                                .background(isSelected ? Color.appPrimaryOrange : Color.appBackgroundGray.opacity(0.6))
                                                .cornerRadius(10)
                                                .onTapGesture {
                                                    if isSelected {
                                                        filterState.selectedProductTypes.remove(type)
                                                    } else {
                                                        filterState.selectedProductTypes.insert(type)
                                                    }
                                                }
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color.appBackgroundWhite)
                            .cornerRadius(16)
                        }
                        
                        // 4. Tags section
                        if !availableTags.isEmpty {
                            VStack(alignment: .leading, spacing: 14) {
                                Text("Tags")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.appTextPrimary)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(availableTags, id: \.self) { tag in
                                            let isSelected = filterState.selectedTags.contains(tag)
                                            Text(tag)
                                                .font(.system(size: 13, weight: .medium))
                                                .foregroundColor(isSelected ? .white : .appTextPrimary)
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 10)
                                                .background(isSelected ? Color.appPrimaryOrange : Color.appBackgroundGray.opacity(0.6))
                                                .cornerRadius(10)
                                                .onTapGesture {
                                                    if isSelected {
                                                        filterState.selectedTags.remove(tag)
                                                    } else {
                                                        filterState.selectedTags.insert(tag)
                                                    }
                                                }
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color.appBackgroundWhite)
                            .cornerRadius(16)
                        }
                        
                        // 5. Sizes section
                        VStack(alignment: .leading, spacing: 14) {
                            Text("Sizes")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.appTextPrimary)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(availableSizes, id: \.self) { size in
                                        let isSelected = filterState.selectedSizes.contains(size)
                                        Text(size)
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(isSelected ? .white : .appTextPrimary)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 10)
                                            .background(isSelected ? Color.appPrimaryOrange : Color.appBackgroundGray.opacity(0.6))
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                if isSelected {
                                                    filterState.selectedSizes.remove(size)
                                                } else {
                                                    filterState.selectedSizes.insert(size)
                                                }
                                            }
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color.appBackgroundWhite)
                        .cornerRadius(16)
                        
                        Color.clear.frame(height: 100)
                    }
                    .padding()
                }
                
                // 6. Bottom action buttons
                VStack(spacing: 0) {
                    Divider()
                    HStack(spacing: 16) {
                        Button(action: {
                            onReset()
                            currentMaxPrice = maxLimit
                        }) {
                            Text("Reset All")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.appTextSecondary)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.appBackgroundGray)
                                .cornerRadius(12)
                        }
                        
                        Button(action: {
                            filterState.minPrice = 0
                            filterState.maxPrice = currentMaxPrice
                            onApply()
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Apply Filters")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.appPrimaryOrange)
                                .cornerRadius(12)
                                .shadow(color: Color.appPrimaryOrange.opacity(0.3), radius: 8, x: 0, y: 4)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 16)
                    .background(Color.appBackgroundWhite)
                }
            }
            .navigationTitle("Filter Options")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.appTextPrimary)
                            .padding(8)
                            .background(Color.appBackgroundWhite)
                            .clipShape(Circle())
                    }
                }
            }
        }
        .onAppear {
            currentMaxPrice = filterState.maxPrice ?? maxLimit
        }
    }
}
