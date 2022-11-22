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
                name: "로젤리아",
                filledPosition: [
                    .init(position: .vocal, numberOfPerson: 2),
                    .init(position: .bass, numberOfPerson: 1),
                    .init(position: .drum, numberOfPerson: 1),
                    .init(position: .guitar, numberOfPerson: 2),
                    .init(position: .keyboard, numberOfPerson: 1),
                    .init(position: .etc, numberOfPerson: 2)
                ],
                repertoire: [
                    "Oasis - Wonderwall",
                    "Oasis - Champagne Supernova",
                    "Oasis - Stop Crying Your Heart Out"
                ],
                ageGroups: [
                    .twenties,
                    .thirties
                ],
                location: Location(
                    name: "로젤리아",
                    address: "경북 포항시 남구 시청로 1",
                    additionalAddress: "포항시청",
                    coordinate: Coordinate(
                        latitude: 36.0191816,
                        longitude: 129.3432983
                    )
                ),
                introduction:
                        """
                        안녕하세요.
                        저희는 오아시스를 좋아하는 밴드 로젤리아입니다.
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
                    address: "경상북도 포항시 남구 효자동 효자동길5번길 14",
                    additionalAddress: nil,
                    coordinate: Coordinate(
                        latitude: 36.0077063,
                        longitude: 129.3287019
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
                    address: "경상북도 포항시 남구 중흥로 85",
                    additionalAddress: nil,
                    coordinate: Coordinate(
                        latitude: 36.0134304,
                        longitude: 129.3496776
                    )
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
                    address: "경상북도 포항시 남구 중흥로126번길 6",
                    additionalAddress: "2층",
                    coordinate: Coordinate(
                        latitude: 36.0154461,
                        longitude: 129.353048
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
                    address: "경상북도 포항시 남구 상도동 617-5",
                    additionalAddress: "4층",
                    coordinate: Coordinate(
                        latitude: 36.0138495,
                        longitude: 129.3572625
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
                title: "투다리에서 같이 노가리깝시당",
                host: bands[0],
                status: .recruiting,
                date: Date(),
                location: Location(
                    name: bands[0].band.name,
                    address: "경상북도 포항시 남구 대잠동 938",
                    additionalAddress: "투다리",
                    coordinate: Coordinate(
                        latitude: 36.0141708,
                        longitude: 129.3472287
                    )
                ),
                introduction: "같이 술이나 한잔 하면서 음악 얘기하며 노가리깔 분들 구합니다",
                createdAt: Date()
            )
        ),
        GatheringInfo(
            gatheringID: "gatheringID-002",
            gathering: Gathering(
                title: "투다리(효자)에서 같이 노가리까요",
                host: bands[0],
                status: .progressing,
                date: Date(),
                location: Location(
                    name: bands[0].band.name,
                    address: "경상북도 포항시 남구 효자동 253-113",
                    additionalAddress: "투다리 효자점",
                    coordinate: Coordinate(
                        latitude: 36.007961,
                        longitude: 129.3293999
                    )
                ),
                introduction: "같이 술이나 한잔 하면서 음악 얘기하며 노가리깔 분들 구합니다",
                createdAt: Date()
            )
        ),
        GatheringInfo(
            gatheringID: "gatheringID-003",
            gathering: Gathering(
                title: "오투에서 같이 연습하실 분",
                host: bands[1],
                status: .canceled,
                date: Date(),
                location: Location(
                    name: bands[1].band.name,
                    address: "경상북도 포항시 남구 연일읍 동문로 40-1",
                    additionalAddress: "오투뮤직스토리 지하",
                    coordinate: Coordinate(
                        latitude: 35.9937237,
                        longitude: 129.3521299
                    )
                ),
                introduction:
                    """
                    오투 예약 잡아놨는데 팀원들 시간이 안 맞아서 팀 내 연습은 좀 어려울 것 같아요.
                    같이 합주하면서 놀 밴드 있나요?
                    편하게 연락주세요!
                    """,
                createdAt: Date()
            )
        ),
        GatheringInfo(
            gatheringID: "gatheringID-004",
            gathering: Gathering(
                title: "이번에 락 페스티벌 가는 분 계시면 같이 가요",
                host: bands[2],
                status: .finished,
                date: Date(),
                location: Location(
                    name: bands[2].band.name,
                    address: "경북 포항시 북구 두호동 685-1",
                    additionalAddress: "영일대 해수욕장",
                    coordinate: Coordinate(
                        latitude: 36.0561507,
                        longitude: 129.3781717
                    )
                ),
                introduction:
                    """
                    페스티벌 구경가는 밴드있나요?
                    같이 놀아요!
                    저희는 영일대에서 바로 만나서 입장할 예정입니다!
                    """,
                createdAt: Date()
            )
        )
    ]
    
    // MARK: - GatheringComments
    static var gatheringComments: [GatheringCommentInfo] = [
        GatheringCommentInfo(
            commentID: "gatheringCommentID-001",
            comment: GatheringComment(
                gathering: gatherings[0].gathering,
                author: bands[1],
                content: "저희 밴드에서는 저 혼자만 가는데, 혹시 같이가도 괜찮을까요?",
                createdAt: Date()
            )
        ),
        GatheringCommentInfo(
            commentID: "gatheringCommentID-001",
            comment: GatheringComment(
                gathering: gatherings[0].gathering,
                author: bands[0],
                content: "물론이죠!",
                createdAt: Date()
            )
        ),
        GatheringCommentInfo(
            commentID: "gatheringCommentID-001",
            comment: GatheringComment(
                gathering: gatherings[0].gathering,
                author: bands[0],
                content:
                    """
                    12시쯤에 입구앞에서 만나요!! 저희는 3명 정도 갑니다ㅎㅎ
                    """,
                createdAt: Date()
            )
        ),
    ]
    
}
