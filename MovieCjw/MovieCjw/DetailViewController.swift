//
//  DetailViewController.swift
//  MovieCjw
//
//  Created by 소프트웨어컴퓨터 on 2021/06/03.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView! // 웹 뷰 레이블
    @IBOutlet weak var nameLabel: UILabel!
    var movieName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // nameLabel.text = movieName
        navigationItem.title = movieName
        // let urlString = "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%EB%B6%84%EB%85%B8%EC%9D%98+%EC%A7%88%EC%A3%BC" chrome말고 사파리로 하면 해당 쿼리의 내용이 한글로 나온다.
        let urlKorString = "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query="+movieName
        let urlString = urlKorString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! // 쿼리 URL 구성 요소에서 허용되는 문자집합을 반환
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)

        // Do any additional setup after loading the view.
    } // 선택한 영화제목에 따라 해당하는 영화 제목을 웹 뷰의 웹사이트에서 검색할 수 있도록 해준다.

}
