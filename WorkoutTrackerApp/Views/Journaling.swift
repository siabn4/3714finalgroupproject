//
//  Journaling.swift
//  
//
//  Created by CS3714 on 12/3/25.
//

import SwiftUI

struct JournalView: View {
    @State private var entryText: String = ""        // Journal entry text from user
    @State private var showSavedAlert = false        // Controls whether the save confirmation is visible

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {

                // Title
                Text("Today’s Journal")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)

                ZStack(alignment: .topLeading) {

                    // Show placeholder when entry is empty
                    if entryText.isEmpty {
                        Text("Start writing your thoughts…")
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 12)
                    }

                    // User can type journal entry here
                    TextEditor(text: $entryText)
                        .font(.body)
                        .padding(8)
                        .background(.thinMaterial)   // SwiftUI-native background
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                Spacer()
            }
            // Save button for journal entry, disables if text is empty
            .navigationBarItems(
                trailing:
                    Button("Save") {
                        saveEntry()
                    }
                    .disabled(entryText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            )
            // Alerts the user after saving
            .alert("Journal Saved", isPresented: $showSavedAlert) {
                Button("OK", role: .cancel) {}
            }
        }
    }

    // MARK: - Mock Save
    // Simulates saving journal entry; shows confirmation alert
    func saveEntry() {
        print("Saved entry:", entryText)
        showSavedAlert = true
    }
}

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
    }
}
