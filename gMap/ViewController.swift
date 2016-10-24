//
//  ViewController.swift
//  gMap
//
//  Created by Cybermac002 on 08/10/16.
//  Copyright © 2016 Cybermac002. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate {
    
    var locationManager = CLLocationManager()
    let marker1 = GMSMarker()
    let marker2 = GMSMarker()
    
    var dist = String()
    
    var lat1:CLLocationDegrees = 55.7558
    var long1: CLLocationDegrees = 37.6173
    
    var lat2 = CLLocationDegrees()
    var long2 = CLLocationDegrees()

    @IBOutlet var distanceLbl: UILabel!
    @IBOutlet var mapView1: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(lat1, longitude: long1, zoom: 15.0)
        mapView1.delegate = self
        mapView1.camera = camera
        marker1.position = camera.target
        
        marker1.draggable = true
        marker1.title = "Sydney"
        marker1.snippet = "Australia"
        marker1.map = mapView1
        marker1.icon = GMSMarker.markerImageWithColor(UIColor.blueColor())
        marker1.appearAnimation = kGMSMarkerAnimationPop

        
       let a = String(lat1)
        let b = String(long1)
        var c = a+","+b
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//      func mapView(mapView: GMSMapView!, willMove gesture: Bool)
//    {
//     // print(mapView.myLocation.coordinate.latitude)
//    }
//    func mapView(mapView: GMSMapView!, didChangeCameraPosition position: GMSCameraPosition!)
//    {
//        print(position.target.latitude)
//         print(position.target.longitude)
//    }
    
    func mapView(mapView: GMSMapView!, idleAtCameraPosition position: GMSCameraPosition!)
    {
        // print(mapView.myLocation.coordinate.latitude)
    
    }
    
    
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D)
    {
         print(coordinate.latitude)
          print(coordinate.longitude)
        marker2.map = mapView1
        marker2.icon = GMSMarker.markerImageWithColor(UIColor.redColor())
        marker2.appearAnimation = kGMSMarkerAnimationPop
        marker2.draggable = true
        lat2 = coordinate.latitude
        long2 = coordinate.longitude
        marker2.position.latitude = lat2
        marker2.position.longitude = long2
        
        CalculateDist()
        
    }
    
//    func mapView(mapView: GMSMapView!, didEndDraggingMarker marker: GMSMarker!) {
//        
//        print(marker1.position.latitude)
//        print(marker1.position.longitude)
//    }
//    
   
    func CalculateDist()
    {
        
        let a = String(lat1)
        let b = String(long1)
        let d = String(lat2)
        let e = String(long2)
        let c = a+","+b
        let f = d+","+e
        print(f)
        print(c)
 
         //let urlString = "\("https://maps.googleapis.com/maps/api/geocode/json")?latlng=\(a),\(b)&key=\("AIzaSyCVMXlAxVUv5jk3SZvyHS28T-3QHwFuKRY")"
        let urlString = "\("https://maps.googleapis.com/maps/api/distancematrix/json")?origins=\(a),\(b)&destinations=\(d),\(e)&key=\("AIzaSyCVMXlAxVUv5jk3SZvyHS28T-3QHwFuKRY")"
        var directionsURL = NSURL(string: urlString)!
        print(urlString)

        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let directionsData = NSData(contentsOfURL: directionsURL)
            let dictionary: Dictionary<NSObject, AnyObject> = try! NSJSONSerialization.JSONObjectWithData(directionsData!, options: NSJSONReadingOptions.MutableContainers) as! Dictionary<NSObject, AnyObject>
         
            print(dictionary.description)
            let status = dictionary["status"] as! String
            let origin = (dictionary["origin_addresses"] as! Array< AnyObject>)[0]
            
            if (origin.containsString(" India"))
            
            {
                print("Its INDIA")
            }
            else {
                print("not in india")
            }
            
            
            
            print(origin)
            if status == "OK" {
                let row = (dictionary["rows"] as! Array<Dictionary<NSObject, AnyObject>>)[0]
               let element = (row["elements"] as! Array<Dictionary<NSObject, AnyObject>>)[0]
                let dista = element["distance"] as! Dictionary<NSObject, AnyObject>
                
                let reqdist = dista["text"] as! String
                
                print(reqdist)
                
                self.distanceLbl.text = reqdist
                
            }
            else{}
        })
            
    }
    
}
