//
//  ViewController.swift
//  MovieCjw
//
//  Created by 소프트웨어컴퓨터 on 2021/05/27.
//

import UIKit
// let name = ["cjw", "abc", "def", "ghi", "jkl"]
struct MovieData : Codable {
    let boxOfficeResult : BoxOfficeResult
}
struct BoxOfficeResult : Codable {
    let dailyBoxOfficeList : [DailyBoxOfficeList]
}
struct DailyBoxOfficeList : Codable {
    let movieNm : String // 영화 이름
    let rank : String // 박스오피스 순위
    let audiAcc : String // 누적 관객 수
    let salesAcc : String // 누적 매출 액
}
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var movieData : MovieData? // 영화
    @IBOutlet weak var table: UITableView!
    var movieURL = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f806d709e8867223922d811f06550632&targetDt="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
        
        movieURL += ChangetoYesterday()
        getData()
    }
    
    func ChangetoYesterday() -> String {
        let y = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let dateF = DateFormatter()
        dateF.dateFormat = "yyyyMMdd"
        let day = dateF.string(from: y)
        return day
    }
    
    func getData() {
        if let url = URL(string:movieURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in // 지정된 URL의 내용을 검색하는 작업을 만든(create) 다음, 완료시 handler(클로저)를 호출
                if error != nil {
                    print(error!)
                    return
                }
                if let JSONdata = data { // 옵셔널 형이라서 옵셔널 바인딩
                    // print(JSONdata, response!)
                   //let dataString =  String(data: JSONdata, encoding: .utf8)
                    //print(dataString!)
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(MovieData.self, from:JSONdata)
                        //print(decodedData.boxOfficeResult.dailyBoxOfficeList[0].movieNm)
                        //print(decodedData.boxOfficeResult.dailyBoxOfficeList[0].audiCnt)
                        //print(decodedData.boxOfficeResult.dailyBoxOfficeList[1].movieNm)
                        //print(decodedData.boxOfficeResult.dailyBoxOfficeList[1].audiCnt)
                        self.movieData = decodedData
                        DispatchQueue.main.async {
                            self.table.reloadData()
                        }
                        
                    }catch {
                        print(error)
                    }
                }
            }
            task.resume() // 작업이 일시 중단 될 경우 다시 시작하는 메소드.
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dest = segue.destination as? DetailViewController else {
            return
        }
        let myIndexPath = table.indexPathForSelectedRow!
        let row = myIndexPath.row
        print(row)
        dest.movieName = (movieData?.boxOfficeResult.dailyBoxOfficeList[row].movieNm)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cjwCell", for: indexPath) as! MyTableViewCell
        
        cell.movieName.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].movieNm
        // 영화 이름
        if let aRank = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].rank {
            cell.openDate.text = "\(aRank)등"
        } // 영화 랭킹
        
        if let aAc = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].audiAcc {
            let numF = NumberFormatter()
            numF.numberStyle = .decimal
            let aCount = Int(aAc)!
            let result = numF.string(for: aCount)!+"명"
            cell.totalMan.text = "누적 관객 \(result)"
        } // 누적 관객수
        
        if let profitAc = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].salesAcc {
            let numF = NumberFormatter()
            numF.numberStyle = .decimal
            let pCount = Int(profitAc)!
            let result = numF.string(for: pCount)!+"원"
            cell.totalProfit.text = "누적 매출 \(result)"
        }
        // indexPath.description // name[indexPath.row]
        // print(indexPath.description, seperator: " ", terminator: " ")
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.description)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "박스오피스(영화진흥위원회제공:"+ChangetoYesterday()+")"
    }

}

