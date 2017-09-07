//
//  ViewController.swift
//  DITMap
//
//  Created by D7702_09 on 2017. 8. 31..
//  Copyright © 2017년 lyw. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate{
    let anno = ""
    @IBOutlet weak var myMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //델리게이트 시점에 따라 부르는것
        // Do any additional setup after loading the view, typically from a nib.
        //DIT 위치 35.166616, 129.072126
        //35.168406, 129.057834
        //cl - 지도의 중심점 
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.166616, 129.072126)//DIT 명시적방법
        
        let location2 = CLLocationCoordinate2DMake(35.168406, 129.057834)//시민공원
        
        //반경(span)
        let span = MKCoordinateSpanMake(0.05, 0.05)//반경 0.1 800메다
        
        //지도에 보여줄 영역
        let region = MKCoordinateRegionMake(location, span) //앞의 선언한 인자를 받음
        
        
        //지도(MapVIew)에 보여주기
        myMapView.setRegion(region, animated: true)
        
        //pin(annotation) 꽂기
        let anno01 = MKPointAnnotation()
        anno01.coordinate = location
        anno01.title = "DIT 동의과학대학교"
        anno01.subtitle = "나의 꿈이 자라는곳"
        let anno02 = MKPointAnnotation()
        anno02.coordinate = location2
        anno02.title = "시민공원"
        anno02.subtitle = "주변공원"
        let anno = [anno01,anno02]
        //복수핀
        myMapView.addAnnotations(anno)
        //단수핀
        //myMapView.addAnnotation(<#T##annotation: MKAnnotation##MKAnnotation#>)
        
        //반드시 딜리게이트 연결
        myMapView.delegate = self
        myMapView.selectAnnotation(anno01, animated: true)
        
    }
    //핀 뷰 바꾸기
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        
        let identifier = "myPin"
        
        //핀의 재활용
        var annotationView = myMapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView //부모를 자식으로 캐스팅을 한다
        //처음이면 아노테이션 뷰를 하나 만든다
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            //핀색깔 조건에따라 바꾸기
            if annotation.title! == "시민공원"{
           annotationView?.pinTintColor = UIColor.blue
            annotationView?.animatesDrop = true
                let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
                leftIconView.image = UIImage(named: "images.png")
                annotationView?.leftCalloutAccessoryView = leftIconView
                
            }else {
                let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
                leftIconView.image = UIImage(named: "다운로드.png")
                annotationView?.leftCalloutAccessoryView = leftIconView
                annotationView?.pinTintColor = UIColor.cyan
            }
            
            //사진넣기
            //leftcalloutAcceary
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            
            //사진넣기
            //rightCalloutAccesary
//            let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
//            leftIconView.image = UIImage(named: "images.png")
//            annotationView?.leftCalloutAccessoryView = leftIconView
        } else {
            //nil 이 아닌경우 이미 만들어진것을 재활용
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        
        print("call out acssory Tappad!")
        
        let viewAnno = view.annotation
        let viewTitle: String = ((viewAnno?.title)!)!
        let viewSubTitle: String = ((viewAnno?.subtitle)!)!
        
        print("\(viewTitle) \(viewSubTitle)")
        
        let ac = UIAlertController(title: viewTitle, message: viewSubTitle, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }




}


