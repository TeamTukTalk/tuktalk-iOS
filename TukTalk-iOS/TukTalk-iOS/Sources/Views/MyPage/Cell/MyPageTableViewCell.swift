//
//  MentorRowTableViewCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/03.
//

import UIKit

class MyPageTableViewCell: UITableViewCell {

    public static let identifier : String = "MyPageTableViewCell"
    
    private let title = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDMed, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data : MyPageTVDataModel){
        title.text = data.title
    }
    
    func setUI(){
        addSubview(title)
        title.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
        }
    }

}
