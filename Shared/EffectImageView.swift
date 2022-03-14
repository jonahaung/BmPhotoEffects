//
//  EffectImageView.swift
//  BmPhotoEffects (iOS)
//
//  Created by Aung Ko Min on 14/3/22.
//

import SwiftUI

struct EffectImageView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    let uiImage: UIImage
    @State private var showControls = true
    
    var body: some View {
        VStack {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
        }
        .onTapGesture {
            withAnimation(.interactiveSpring()) {
                showControls.toggle()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(topBar, alignment: .top)
        
    }
    
    private var topBar: some View {
        Group {
            if showControls {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image.close
                        
                    }
                    Spacer()
                    Image.share
                        .tapToPresent(ActivityView([uiImage]), false)
                }
                .imageScale(.large)
                .padding()
                .transition(.opacity)
            }
        }
    }
}
