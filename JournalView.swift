//
//  ContentView.swift
//  mentalhealth.c
//
//  Created by CS3714 on 12/3/25.
//

import SwiftUI

struct JournalView: View {
    @State private var entryText: String = ""
    @State private var showSavedAlert = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Today’s Journal")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                
                ZStack(alignment: .topLeading) {
                    
                    // Placeholder
                    if entryText.isEmpty {
                        Text("Start writing your thoughts…")
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 12)
                    }
                    
                    TextEditor(text: $entryText)
                        .font(.body)
                        .padding(8)
                        .background(.thinMaterial)   // <-- SwiftUI-native background
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationBarItems(
                trailing:
                    Button("Save") {
                        saveEntry()
                    }
                    .disabled(entryText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            )
            .alert("Journal Saved", isPresented: $showSavedAlert) {
                Button("OK", role: .cancel) {}
            }
        }
    }
    
    // MARK: - Mock Save
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
