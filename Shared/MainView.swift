//
//  ContentView.swift
//  Shared
//
//  Created by Aung Ko Min on 14/3/22.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Constants
    
    private struct Constants {
        struct Button {
            static let size: CGFloat = 80
            static let cornerRadius: CGFloat = 40
            static let spacing: CGFloat = 32
            static let borderWidth: CGFloat = 3
        }
        struct Title {
            static let topSpacing: CGFloat = 32
            static let sideSpacing: CGFloat = 16
        }
    }
    
    @StateObject private var manager = MainViewManager()
    
    var body: some View {
        VStack {
            HStack {
                Image.heart
                    .foregroundColor(.red)
                Spacer()
            }
            .padding()
            Spacer()
            VStack {
                ForEach(FilterType.allCases) { filter in
                    Button(action: {
                        withAnimation(.interactiveSpring()) {
                            manager.filterType = filter
                        }
                    }, label: {
                        Text(filter.rawValue)
                            .font(manager.filterType == filter ? XFont.title : XFont.subtitle )
                    })
                }
            }
            
            .padding(.horizontal, Constants.Title.sideSpacing)
            .padding(.top, Constants.Title.topSpacing)
            
            Spacer()

            HStack {
                Image
                    .camera
                    .frame(width: Constants.Button.size)
                    .padding(Constants.Button.spacing)
                    .background(Circle().strokeBorder(lineWidth: Constants.Button.borderWidth))
                    .tapToPresent (
                        ImagePicker(.camera) {
                            manager.process(image: $0)
                        }
                        .edgesIgnoringSafeArea(.vertical)
                    )
                Spacer()
                Image
                    .photo
                    .frame(width: Constants.Button.size)
                    .padding(Constants.Button.spacing)
                    .background(Circle().strokeBorder(lineWidth: Constants.Button.borderWidth))
                    .tapToPresent (
                        ImagePicker(.photoLibrary) {
                            manager.process(image: $0)
                        }
                            .edgesIgnoringSafeArea(.vertical)
                    )
            }
            .imageScale(.large)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(overlayView)
        .alert(item: $manager.errorMessage) {
            Alert(title: Text("Error"), message: Text($0), dismissButton: .cancel())
        }
        .fullScreenCover(item: $manager.resultImage) {
            EffectImageView(uiImage: $0)
        }
        .task {
            manager.start()
        }
    }
    
    private var overlayView: some View {
        Group {
            if manager.showSpinner {
                VStack {
                    SpinnerView()
                        .frame(width: 150, height: 150)
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity).background(.black.opacity(0.9))
            }
        }
    }
}
