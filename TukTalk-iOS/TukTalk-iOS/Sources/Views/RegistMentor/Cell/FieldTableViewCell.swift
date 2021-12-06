//
//  SpecialityTableViewCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/13.
//

import UIKit

class FieldTableViewCell: UITableViewCell {
    
    public static let identifier : String = "FieldTableViewCell"
    
    private let title = UILabel().then {
        $0.font = UIFont.TTFont(type: .SDMed, size: 15)
        $0.textColor = UIColor.GrayScale.normal
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
    
    func setData(data : FieldTableViewDataModel){
        title.text = data.title
    }
    
    func setUI(){
        addSubview(title)
        title.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
    }


}
