import Common
import SwiftUI

public struct PersonalInformationView: View {
    @ObservedObject private var viewModel: ProfileDataViewModel
    @State private var form = ProfileInformationForm()
    @State private var isEditing = false

    public init(viewModel: ProfileDataViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                header

                switch viewModel.state {
                case .idle, .loading:
                    loadingView
                case .failure(let message):
                    failureView(message)
                case .success(let profile):
                    content(profile)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 18)
        }
        .background(AppColors.backgroundSecondary.ignoresSafeArea())
        .navigationTitle("Personal Information")
        .settingsInlineNavigationTitle()
        .task {
            await viewModel.loadProfileIfNeeded()
        }
        .onChange(of: viewModel.state) { state in
            guard case .success(let profile) = state, !isEditing else { return }
            form = ProfileInformationForm(profile: profile)
        }
        .alert("Could not update profile", isPresented: saveErrorBinding) {
            Button("OK", role: .cancel) {
                viewModel.saveErrorMessage = nil
            }
        } message: {
            Text(viewModel.saveErrorMessage ?? "Please try again.")
        }
    }

    private var header: some View {
        PersonalInformationHeaderView()
    }

    private var loadingView: some View {
        PersonalInformationLoadingView()
    }

    private func failureView(_ message: String) -> some View {
        PersonalInformationFailureView(
            message: message,
            onRetry: {
                Task {
                    await viewModel.loadProfile()
                }
            }
        )
    }

    private func content(_ profile: CustomerProfile) -> some View {
        VStack(spacing: 16) {
            readOnlySection(profile)

            if isEditing {
                editSection
                PersonalInformationActionButtons(
                    isSaving: viewModel.isSaving,
                    onSave: saveChanges,
                    onCancel: { cancelEditing(profile) }
                )
            } else {
                PersonalInformationEditButton {
                    beginEditing(profile)
                }
            }
        }
    }

    private func readOnlySection(_ profile: CustomerProfile) -> some View {
        ProfileInfoSection(title: "Current Details") {
            ProfileInfoRow(icon: "person.fill", title: "Name", value: profile.displayName)
            Divider().background(AppColors.border)
            ProfileInfoRow(icon: "envelope.fill", title: "Email", value: profile.displayEmail)
            Divider().background(AppColors.border)
            ProfileInfoRow(icon: "phone.fill", title: "Phone", value: profile.displayPhone)
            Divider().background(AppColors.border)
            ProfileInfoRow(icon: "calendar", title: "Customer Since", value: profile.displayCreatedAt)
        }
    }

    private var editSection: some View {
        ProfileInfoSection(title: "Edit Details") {
            ProfileEditableRow(icon: "person.fill", title: "First Name", text: $form.firstName)
            Divider().background(AppColors.border)
            ProfileEditableRow(icon: "person", title: "Last Name", text: $form.lastName)
            Divider().background(AppColors.border)
            ProfileEditableRow(
                icon: "phone.fill",
                title: "Phone",
                text: $form.phone,
                keyboardType: .phonePad,
                textInputAutocapitalization: .never
            )
        }
    }

    private func beginEditing(_ profile: CustomerProfile) {
        form = ProfileInformationForm(profile: profile)
        isEditing = true
    }

    private func saveChanges() {
        Task {
            await viewModel.updateProfile(form.updateInput)
            if viewModel.saveErrorMessage == nil {
                isEditing = false
            }
        }
    }

    private func cancelEditing(_ profile: CustomerProfile) {
        form = ProfileInformationForm(profile: profile)
        isEditing = false
        viewModel.saveErrorMessage = nil
    }

    private var saveErrorBinding: Binding<Bool> {
        Binding(
            get: { viewModel.saveErrorMessage != nil },
            set: { isPresented in
                if !isPresented {
                    viewModel.saveErrorMessage = nil
                }
            }
        )
    }
}
