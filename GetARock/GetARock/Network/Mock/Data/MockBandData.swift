//
//  MockBandData.swift
//  GetARock
//
//  Created by 김수진 on 2022/11/21.
//

import Foundation

enum MockData {
    // MARK: - Bands
    static var bands: [BandInfo] = [
        BandInfo(
            bandID: "bandID-001",
            band: Band(
                name: "빅나인밴드",
                filledPosition: [
                    .init(position: .vocal, numberOfPerson: 1),
                    .init(position: .bass, numberOfPerson: 1),
                    .init(position: .drum, numberOfPerson: 1),
                    .init(position: .guitar, numberOfPerson: 2)
//                    .init(position: .keyboard, numberOfPerson: 1),
//                    .init(position: .etc, numberOfPerson: 2)
                ],
                repertoire: [
                    "빅나인밴드 - 시린 사랑",
                    "빅나인밴드 - 고민",
                    "빅나인밴드 - 달구벌로망스"
                ],
                ageGroups: [
                    .twenties,
                    .thirties
                ],
                location: Location(
                    name: "레드제플린",
                    address: "대구광역시 남구 명덕로 102",
                    additionalAddress: "레드제플린",
                    coordinate: Coordinate(
                      latitude: 35.85672,
                      longitude: 128.58130
                    )
                ),
                introduction:
                        """
                        안녕하세요.
                        저희는 대구의 자랑 빅나인밴드입니다.
                        """
            )
        ),
        BandInfo(
            bandID: "bandID-002",
            band: Band(
                name: "블랙로즈",
                filledPosition: [
                    .init(position: .vocal, numberOfPerson: 1),
//                    .init(position: .bass, numberOfPerson: 1),
//                    .init(position: .drum, numberOfPerson: 1),
                    .init(position: .guitar, numberOfPerson: 2),
                    .init(position: .keyboard, numberOfPerson: 1)
//                    .init(position: .etc, numberOfPerson: 2)
                ],
                repertoire: [
                    "Sum 41 - Still Waiting",
                    "Sum 41 - In Too Deep",
                    "Sum 41 - With Me"
                ],
                ageGroups: [
                    .twenties
                ],
                location: Location(
                    name: "블랙로즈",
                    address: "대한민국 대구광역시 중구 태평로2가 17-11",
                    additionalAddress: nil,
                    coordinate: Coordinate(
                        latitude: 35.87478,
                        longitude: 128.59192
                    )
                ),
                introduction:
                        """
                        안녕하세요. 블랙로즈입니다.
                        안녕 안녕 안녕하세요
                        안녕 안녕 안녕하세요
                        안~녕 안-녕하세요-오-오!
                        """
            )
        ),
        BandInfo(
            bandID: "bandID-003",
            band: Band(
                name: "모닝샐러드",
                filledPosition: [
                    .init(position: .vocal, numberOfPerson: 1),
                    .init(position: .bass, numberOfPerson: 1),
//                    .init(position: .drum, numberOfPerson: 1),
                    .init(position: .guitar, numberOfPerson: 1),
                    .init(position: .keyboard, numberOfPerson: 1)
//                    .init(position: .etc, numberOfPerson: 2)
                ],
                repertoire: [
                    "Coldplay - Viva La Vida",
                    "Coldplay - Highter Power",
                    "Coldplay - Paradise",
                    "Coldplay - In My Place",
                    "Coldplay - Everglow"
                ],
                ageGroups: [
                    .twenties,
                    .forties
                ],
                location: Location(
                    name: "모닝샐러드",
                    address: "대한민국 대구광역시 중구 남산동 2185-110",
                    additionalAddress: nil,
                    coordinate: Coordinate(
                        latitude: 35.85785,
                        longitude: 128.58661                    )
                ),
                introduction:
                        """
                        모닝샐러드는 아침에 공복감을 없애고 상큼함을 더해줍니다.
                        """
            )
        ),
        BandInfo(
            bandID: "bandID-004",
            band: Band(
                name: "직스",
                filledPosition: [
                    .init(position: .vocal, numberOfPerson: 1),
                    .init(position: .bass, numberOfPerson: 1),
                    .init(position: .drum, numberOfPerson: 1),
                    .init(position: .guitar, numberOfPerson: 1)
//                    .init(position: .keyboard, numberOfPerson: 1),
//                    .init(position: .etc, numberOfPerson: 2)
                ],
                repertoire: [
                    "노브레인(No Brain) - 미친 듯 놀자",
                    "YB - 나는 나비",
                    "DAY6 (데이식스) - 한 페이지가 될 수 있게"
                ],
                ageGroups: [
                    .thirties
                ],
                location: Location(
                    name: "직스",
                    address: "대한민국 대구광역시 중구 대신동 291-61",
                    additionalAddress: "2층",
                    coordinate: Coordinate(
                        latitude: 35.86677,
                        longitude: 128.57930
                    )
                ),
                introduction:
                        """
                        저희는 한국 밴드 음악 커버 연습을 주로합니다.
                        """
            )
        ),
        BandInfo(
            bandID: "bandID-005",
            band: Band(
                name: "파란색페스츄리",
                filledPosition: [
                    .init(position: .vocal, numberOfPerson: 2),
                    .init(position: .bass, numberOfPerson: 1),
                    .init(position: .drum, numberOfPerson: 1),
                    .init(position: .guitar, numberOfPerson: 2),
                    .init(position: .keyboard, numberOfPerson: 1)
//                    .init(position: .etc, numberOfPerson: 2)
                ],
                repertoire: [
                    "Oasis - Champagne Supernova",
                    "Muse - Hyssteria"
                ],
                ageGroups: [
                    .fifties
                ],
                location: Location(
                    name: "파란색페스츄리",
                    address: "대한민국 대구광역시 남구 대명동 2542-33",
                    additionalAddress: "4층",
                    coordinate: Coordinate(
                        latitude: 35.85625,
                        longitude: 128.57935
                    )
                ),
                introduction:
                        """
                        안녕하세요. 파란색 페스츄리입니다!
                        """
            )
        )
    ]
    
    // MARK: - Gatherings
    static var gatherings: [GatheringInfo] = [
        GatheringInfo(
            gatheringID: "gatheringID-001",
            gathering: Gathering(
                title: "시카고 라이브클럽에서 합공하실분!!",
                host: bands[0],
                status: .recruiting,
                date: "2022.12.12 13:22".toDate(format: DateFormatLiteral.standard) ?? Date(),
                location: Location(
                    name: bands[0].band.name,
                    address: "대구광역시 수성구 달구벌대로 2354",
                    additionalAddress: "시카고 라이브클럽",
                    coordinate: Coordinate(
                        latitude: 35.85922,
                        longitude: 128.61990
                    )
                ),
                introduction: "같이 술이나 한잔 하면서 음악 얘기하며 노가리깔 분들 구합니다",
                createdAt: "2022.11.10 13:22".toDate(format: DateFormatLiteral.standard) ?? Date()
            )
        ),
        GatheringInfo(
            gatheringID: "gatheringID-002",
            gathering: Gathering(
                title: "투다리(효자)에서 같이 노가리까요",
                host: bands[1],
                status: .progressing,
                date: Date(),
                location: Location(
                    name: bands[0].band.name,
                    address: "대한민국 대구광역시 중구 남성로 13-3",
                    additionalAddress: "라이브카페",
                    coordinate: Coordinate(
                        latitude: 35.86971,
                        longitude: 128.58828
                    )
                ),
                introduction: "같이 술이나 한잔 하면서 음악 얘기하며 노가리깔 분들 구합니다",
                createdAt: "2022.11.10 13:22".toDate(format: DateFormatLiteral.standard) ?? Date()
            )
        ),
        GatheringInfo(
            gatheringID: "gatheringID-003",
            gathering: Gathering(
                title: "오투에서 같이 연습하실 분",
                host: bands[3],
                status: .canceled,
                date: "2022.12.10 13:22".toDate(format: DateFormatLiteral.standard) ?? Date(),
                location: Location(
                    name: bands[1].band.name,
                    address: "대한민국 대구광역시 남구 대명동 1883-3",
                    additionalAddress: "오투뮤직스토리 지하",
                    coordinate: Coordinate(
                        latitude: 35.85388,
                        longitude: 128.58477
                    )
                ),
                introduction:
                    """
                    오투 예약 잡아놨는데 팀원들 시간이 안 맞아서 팀 내 연습은 좀 어려울 것 같아요.
                    같이 합주하면서 놀 밴드 있나요?
                    편하게 연락주세요!
                    """,
                createdAt: "2022.11.10 13:22".toDate(format: DateFormatLiteral.standard) ?? Date()
            )
        ),
        GatheringInfo(
            gatheringID: "gatheringID-004",
            gathering: Gathering(
                title: "시카고 라이브클럽에서 합공하실분!!",
                host: bands[0],
                status: .finished,
                date: "2022.11.15 13:22".toDate(format: DateFormatLiteral.standard) ?? Date(),
                location: Location(
                    name: bands[0].band.name,
                    address: "대구광역시 수성구 달구벌대로 2354",
                    additionalAddress: "시카고 라이브클럽",
                    coordinate: Coordinate(
                        latitude: 35.85922,
                        longitude: 128.61990
                    )
                ),
                introduction:
                    """
                    이번에 시카고 라이브클럽에서 합공하실분 있나요??
                    같이 대구를 불태워봐요!!
                    """,
                createdAt: "2022.11.10 13:22".toDate(format: DateFormatLiteral.standard) ?? Date()
            )
        )
    ]
    
    // MARK: - GatheringComments
    static var gatheringComments: [GatheringCommentInfo] = [
        GatheringCommentInfo(
            commentID: "gatheringCommentID-001",
            comment: GatheringComment(
                gathering: gatherings[0],
                author: bands[1],
                content: "저희 밴드에서는 저 혼자만 가는데, 혹시 같이가도 괜찮을까요?",
                createdAt: "2022.11.12 13:22".toDate(format: DateFormatLiteral.standard) ?? Date()
            )
        ),
        GatheringCommentInfo(
            commentID: "gatheringCommentID-002",
            comment: GatheringComment(
                gathering: gatherings[0],
                author: bands[0],
                content: "물론이죠!",
                createdAt: "2022.11.13 13:22".toDate(format: DateFormatLiteral.standard) ?? Date()
            )
        ),
        GatheringCommentInfo(
            commentID: "gatheringCommentID-003",
            comment: GatheringComment(
                gathering: gatherings[0],
                author: bands[0],
                content:
                    """
                    12시쯤에 입구앞에서 만나요!! 저희는 3명 정도 갑니다ㅎㅎ
                    """,
                createdAt: "2022.11.14 13:22".toDate(format: DateFormatLiteral.standard) ?? Date()
            )
        ),
        GatheringCommentInfo(
            commentID: "gatheringCommentID-004",
            comment: GatheringComment(
                gathering: gatherings[0],
                author: bands[1],
                content:
                    """
                    네~~ 좋아요!
                    그럼 투다리 앞에서 만나요!!
                    """,
                createdAt: "2022.11.15 13:22".toDate(format: DateFormatLiteral.standard) ?? Date()
            )
        ),
    ]
    
    // MARK: - VisitorComments
    static var visitorComments: [VisitorCommentInfo] = [
        VisitorCommentInfo(
            commentID: "visitorCommentID-001",
            comment: VisitorComment(
                hostBand: bands[0],
                author: bands[2],
                content:
                    """
                    언제 또 저희랑 합주 한 번 더 같이 가시죠~~
                    """,
                createdAt: "2022.11.17 13:22".toDate(format: DateFormatLiteral.standard) ?? Date()
            )
        ),
        VisitorCommentInfo(
            commentID: "visitorCommentID-002",
            comment: VisitorComment(
                hostBand: bands[0],
                author: bands[3],
                content:
                    """
                    안녕하세요~~!!
                    저희는 \(bands[3].band.name)입니다.
                    저희 팀원이 전에 \(bands[0].band.name) 공연하는 거 봤었는데,
                    말 걸고 싶은데 못 걸어서 아쉽다고 하더라구요.
                    시간되시면 나중에 밴드 대 밴드로 같이 이야기 나눠볼 수 있을까요?
                    """,
                createdAt: "2022.11.15 13:22".toDate(format: DateFormatLiteral.standard) ?? Date()
            )
        ),
        VisitorCommentInfo(
            commentID: "visitorCommentID-003",
            comment: VisitorComment(
                hostBand: bands[0],
                author: bands[2],
                content:
                    """
                    잘 지내고 계신가요~~!!
                    저희팀 다음 주에 공연합니다.
                    시간되면 놀려와주세요ㅎㅎ
                    """,
                createdAt: "2022.11.13 13:22".toDate(format: DateFormatLiteral.standard) ?? Date()
            )
        ),
        VisitorCommentInfo(
            commentID: "visitorCommentID-004",
            comment: VisitorComment(
                hostBand: bands[0],
                author: bands[2],
                content:
                    """
                    안녕하세요~~ \(bands[2].band.name)입니다.
                    잘 부탁드려요.
                    """,
                createdAt: "2022.11.10 13:22".toDate(format: DateFormatLiteral.standard) ?? Date()
            )
        )
    ]
}
