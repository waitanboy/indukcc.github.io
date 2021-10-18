//
//  MyTableViewCell.swift
//  MovieCjw
//
//  Created by 소프트웨어컴퓨터 on 2021/05/27.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var totalMan: UILabel! // 누적 관객 수 레이블
    @IBOutlet weak var openDate: UILabel! // 박스오피스 순위 레이블(개봉일에서 도중에 바꿈)
    @IBOutlet weak var movieName: UILabel! // 영화 이름 레이블
    @IBOutlet weak var totalProfit: UILabel! // 누적 매출액 레이블
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
