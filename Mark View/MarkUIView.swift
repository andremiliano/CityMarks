//
//  MarkUIView.swift
//  CityMarks
//
//  Created by André Emiliano on 01/12/2023.
//

import SwiftUI
import MapKit

struct MarkUIView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: MarkDetailViewModel

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                AsyncImage(url: viewModel.imageUrl) { image in
                    image.resizable()
                        .scaledToFit()
                        .overlay(closeButton)

                } placeholder: {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .scaleEffect(2.0, anchor: .center)
                        .padding()
                }
                Text(viewModel.markName)
                    .foregroundColor(.primary)
                    .font(.title)
                    .padding()
                Text(viewModel.locationDescription)
                    .foregroundColor(.primary)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(viewModel.markDescription)
                    .foregroundColor(.primary)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                setUpMap
                    .padding()
                    .frame(width: 400, height: 300, alignment: .bottom)
            }
        }
    }

    var setUpMap: some View {
        Map(coordinateRegion: .constant(
            MKCoordinateRegion(center: viewModel.mapCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        ),
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: .constant(.follow),
            annotationItems: [MarkLocation(name: viewModel.markName, coordinate: viewModel.mapCoordinate)]) { item in
            MapMarker(coordinate: item.coordinate, tint: .red)
        }
    }
    
    var closeButton: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle")
                        .padding(10)
                        .foregroundColor(.black)
                }
            }
            .padding(5)
            Spacer()
        }
    }
}
