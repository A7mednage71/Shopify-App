//
//  SwiftUIView.swift
//  
//
//  Created by Eyad waleed on 05/07/2026.
//

import SwiftUI
import MapKit

struct TapToPlacePinMapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var pinCoordinate: CLLocationCoordinate2D
    var onPinMoved: (CLLocationCoordinate2D) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = false
        mapView.setRegion(region, animated: false)

        let annotation = MKPointAnnotation()
        annotation.coordinate = pinCoordinate
        mapView.addAnnotation(annotation)

        let tapGesture = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleTap(_:))
        )
        mapView.addGestureRecognizer(tapGesture)

        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        if !context.coordinator.isProgrammaticRegionChange {
            mapView.setRegion(region, animated: true)
        }

        if let annotation = mapView.annotations.first(where: { $0 is MKPointAnnotation }) as? MKPointAnnotation,
           annotation.coordinate.latitude != pinCoordinate.latitude ||
           annotation.coordinate.longitude != pinCoordinate.longitude {
            annotation.coordinate = pinCoordinate
        }
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: TapToPlacePinMapView
        var isProgrammaticRegionChange = false

        init(_ parent: TapToPlacePinMapView) {
            self.parent = parent
        }

        @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            guard let mapView = gesture.view as? MKMapView else { return }
            let tapPoint = gesture.location(in: mapView)
            let coordinate = mapView.convert(tapPoint, toCoordinateFrom: mapView)

            parent.pinCoordinate = coordinate
            parent.onPinMoved(coordinate)

            if let annotation = mapView.annotations.first(where: { $0 is MKPointAnnotation }) {
                UIView.animate(withDuration: 0.2) {
                    (annotation as? MKPointAnnotation)?.coordinate = coordinate
                }
            }
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard annotation is MKPointAnnotation else { return nil }
            let identifier = "tapPin"
            let view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKMarkerAnnotationView
                ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.annotation = annotation
            view.canShowCallout = false
            view.animatesWhenAdded = true
            return view
        }

        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            parent.region = mapView.region
        }
    }
}
