//
//  SwiftUIView 2.swift
//
//
//  Created by Eyad waleed on 04/07/2026.
//

import SwiftUI
import Common

public struct AddressesView: View {
    @ObservedObject private var viewModel: AddressesViewModel
    let onAddAddress: () -> Void
    @State private var showSnackbar = false
    @State private var snackbarMessage = ""
    @State private var showingDeleteAlert = false
    @State private var addressToDelete: AddressDomain? = nil
    
    public init(viewModel: AddressesViewModel ,onAddAddress: @escaping () -> Void) {
        self.viewModel = viewModel
        self.onAddAddress = onAddAddress
    }
    
    public var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Saved Addresses")
                    .font(.headline)
                    .padding(.top)
                    .padding(.horizontal, 24)
                List {
                    ForEach(viewModel.addressesList, id: \.id) { address in
                        AddressItem(
                            isSelected: Binding(
                                get: {
                                    if(viewModel.selectedAddressID == address.id ){
                                    }
                                    return viewModel.selectedAddressID == address.id },
                                set: { isSelected in
                                    if isSelected {
                                        viewModel.selectedAddressID = address.id
                                    }
                                }
                            ), addressItem: address
                        )
                        .onTapGesture {
                            viewModel.selectedAddressID = address.id
                        }
                        .listRowSeparator(.hidden)
                        
                        
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                addressToDelete = address
                                showingDeleteAlert = true
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                    
                    NewAddressButton(action: {
                        onAddAddress()
                    })
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .padding(.top, 8)
                }
                .listStyle(.plain)
                
                
                CustomBtn(label: "Apply", action: {
                    Task {
                        await viewModel.saveDefaultAddressSelection()
                        triggerSnackbar(message: "Default address updated successfully!")
                    }
                })
                .disabled(viewModel.isSelectionUnchanged)
                .opacity(viewModel.isSelectionUnchanged ? 0.5 : 1.0)
                .padding(.horizontal, 24)
                .padding(.bottom)
            }
            
            if showSnackbar {
                VStack {
                    Spacer()
                    HStack(spacing: 12) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.white)
                        Text(snackbarMessage)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .fontWeight(.medium)
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 24)
                    .background(Color.black.opacity(0.85))
                    .cornerRadius(25)
                    .shadow(radius: 6)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .padding(.bottom, 90)
                }
                .animation(.spring(), value: showSnackbar)
            }
        }
        .alert("Delete Address", isPresented: $showingDeleteAlert, presenting: addressToDelete) { address in
            Button("Delete", role: .destructive) {
                var transaction = Transaction()
                transaction.disablesAnimations = true
                
                withTransaction(transaction) {
                    Task {
                        let targetTitle = address.address1
                        await viewModel.deleteAddress(id: address.id)
                        triggerSnackbar(message: "Removed '\(targetTitle)' successfully.")
                    }
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: { address in
            Text("Are you sure you want to delete '\(address.address1)'?")
        }
    }
    
    private func triggerSnackbar(message: String) {
        snackbarMessage = message
        withAnimation {
            showSnackbar = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation {
                showSnackbar = false
            }
        }
    }
}
