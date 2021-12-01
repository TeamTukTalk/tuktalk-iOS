//
//  SpecialtyTableViewCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/18.
//

import UIKit

class SpecialtyTableViewCell: UITableViewCell {
    
    public static let identifier : String = "SpecialtyTableViewCell"
    
    var textData: [SubSpecialty] = []
    
    private let titleLabel = UILabel().then {
        $0.text = "전문분야 🛠"
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    var mainTextView = UITextView().then {
        $0.text = ""
        $0.font = UIFont.TTFont(type: .SDReg, size: 14)
        $0.textColor = UIColor.GrayScale.sub1
        $0.isEditable = false
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
    
    func setData(data: [SubSpecialty]) {
        textData = data
        for text in textData {
            mainTextView.text += text.value
            mainTextView.text += "\n"
        }
        mainTextView.snp.makeConstraints {
            $0.height.equalTo(20 * textData.count)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
    }
    
    private func setUI() {
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.leading.equalToSuperview()
        }
        
        contentView.addSubview(mainTextView)
    }

}
