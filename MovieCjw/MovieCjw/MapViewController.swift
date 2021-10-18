//
//  MapViewController.swift
//  MovieCjw
//
//  Created by 소프트웨어컴퓨터 on 2021/06/03.
//

import UIKit
import WebKit

class MapViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlKorString = "https://map.naver.com/v5/search/영화관"
        let urlString = urlKorString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        // Do any additional setup after loading the view.
    } // "영화관"을 웹 뷰 레이블에서 검색하기 위한 코드
    
}
