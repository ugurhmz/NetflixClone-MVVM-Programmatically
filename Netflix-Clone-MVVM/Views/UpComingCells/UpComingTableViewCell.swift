//
//  UpComingTableViewCell.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 1.04.2022.
//

import UIKit

class UpComingTableViewCell: UITableViewCell {

    static var identifier = "UpComingTableViewCell"
    
    private let cellImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    private func setupViews() {
        [cellImageView, titleLabel, playBtn].forEach { contentView.addSubview($0) }
        setContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }

}



//MARK: - Constraints
extension UpComingTableViewCell {
    
    private func setContraints(){
        NSLayoutConstraint.activate([
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            cellImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
