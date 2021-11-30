//
//  TermsTableViewModel.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/11/30.
//

import UIKit

struct TemrsTableViewModel {
    var open = [false, false, false, false, false]
    
    let titleDataList = [
        "제1장 총 칙\n\n",
        "제2장 회원\n\n",
        "제3장 서비스 이용\n\n",
        "제4장 기타\n\n",
        "제5장 특별규정\n\n"
    ]
    
    let contentDataList = [
        [
            "제1조 [목적]\n",
            "제2조 [정의]\n",
            "제3조 [약관의 명시 및 개정]\n",
            "제4조 [약관의 효력]\n",
            "제5조 [회원에 대한 통지]\n",
            "제6조 [서비스의 제공 및 변경\n",
            "제7조 [서비스의 중단]\n",
            "제8조 [회사의 의무]\n"
        ],
        [
            "제9조 [개인정보보호]\n",
            "제10조 [회원가입]\n",
            "제11조 [회원 탈퇴 및 자격 상실 등]\n",
            "제12조 [이용자의 의무]\n",
        ],
        [
            "제13조 [거래조건에 대한 정보의 표시]\n",
            "제14조 [열람]\n",
            "제15조 [부정이용 금지]\n"
        ],
        [
            "제16조 [저작권]\n",
            "제17조 [책임과 면책]\n",
            "제18조 [분쟁의 해결]\n",
            "제19조 [법령 및 준용]\n"
        ],
        [
            "제30조 [개별약관]\n"
        ]
    ]
    
    let articleDataList = [
        [
            "본 약관은 주식회사 뚝딱(이하 “회사”라 합니다)가 운영하는 뚝딱을 통하여 제공하는 상품 및 디지털콘텐츠 서비스(이하 “서비스”라 합니다)의 이용과 관련하여 이용자의 권리, 의무 및 책임사항 등을 규정함을 목적으로 합니다.\n",
            "본 약관에서 사용하는 용어의 정의는 다음과 같습니다.\n\n1. “뚝딱”이란 회사가 디지털콘텐츠를 이용자에게 제공하기 위하여 운영하는, 정보통신설비(인터넷, 전화 등)를 이용하여 디지털콘텐츠를 거래할 수 있도록 설정한 가상의 전자상거래 웹사이트를 말합니다.\n2. “이용자”란 회사의 웹사이트에 접속하여 본 약관에 따라 회사가 제공하는 콘텐츠 및 제반 서비스를 이용하는 회원 및 비회원을 말합니다.\n3. “회원”이란 본 약관에 동의하고 개인정보를 제공하여 회원 등록을 한 자로서, 회사가 제공하는 정보와 서비스를 지속적으로 이용할 수 있는 자를 말합니다.\n4. “콘텐츠”라 함은 회사가 제공하는 포트폴리오, 멘토링 등 디지털 콘텐츠 및 기타 관련 정보를 의미하며, 정보통신망이용촉진 및 정보보호 등에 관한 법률 제2조 제1항 제1호의 규정에 의한 정보통신망에서 사용되는 부호, 문자, 이미지등으로 표현된 자료 또는 정보를 말합니다.\n5. 전항 각호에 해당하는 정의 이외의, 기타 용어의 정의에 대하여는 거래 관행 및 관계 법령에 따릅니다.\n",
            "1. 회사는 이용자가 별도의 연결화면을 통하여 본 약관의 내용과 상호, 연락처 등을 확인할 수 있도록 뚝딱서비스 하단에 게시합니다.\n2. 회사는 약관의 규제 등에 관한 법률, 전자서명법, 정보통신망 이용촉진 등에 관한 법률 등 관계 법령을 위배하지 않는 범위에서 본 약관을 개정할 수 있습니다.\n3. 회사가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여, 개정 전 약관과 함께 적용일자 7일 전부터 서비스에서 확인할 수 있도록 게시하며, 기존 회원에게는 본 약관 제5조의 방법을 통하여 약관 개정사실을 통지합니다. 다만, 회원의 권리 또는 의무에 관한 중요한 규정의 변경은 최소한 30일전에 공지하고 개정약관을 회원이 등록한 이메일로 발송하여 통지합니다.\n4. 회사가 개정약관을 공지 또는 통지한 후에 회원이 30일 기간 내에 명시적으로 거부의 의사 표시를 하지 않으면 약관의 개정사항에 대해 동의한 것으로 간주하며, 변경된 약관에 대한 정보를 알지 못하여 발생하는 이용자의 피해에 대해 회사는 책임을 지지 않습니다.\n5. 개정된 약관에 동의하지 않는 회원은 회원 탈퇴를 요청할 수 있습니다.\n6. 본 약관에서 명시하지 않은 사항과 본 약관의 해석에 관하여는 정부가 제정한 소비자보호지침 및 관계법령, 또는 상관례에 따릅니다.\n",
            "1. 본 약관은 이용자가 회원가입 시 약관의 내용에 동의하고, 회사가 그 회원가입 신청에 대하여 승낙함으로써 효력이 발생합니다.\n2. 회사는 기존 회원이 본 약관 제5조에 따른 공지 또는 통지에도 불구하고, 동 기간 내에 이의를 제기하지 않는 경우에는 변경된 약관을 승인한 것으로 봅니다.\n",
            "1. 회사는 회원에게 알려야 할 사항이 발생하는 경우, 회원가입 시 회원이 공개한 전자우편주소, 팝업, 알림(애플리케이션), 푸시알림 등의 방법으로 통지할 수 있습니다. 회원이 통지를 받을 전자우편 주소를 지정한 때에는 회사의 통지는 부가통신사업자 또는 수신인이 관리하는 메일서버 등에 도착하여 회원이 검색할 수 있는 상태에 이르렀을 때 도달된 것으로 보며, 회원이 전자우편을 개봉하였는지 여부, 회원의 PC에 전자우편이 전송되었는지 여부는 불문합니다.\n2. 회사는 회원 전체에 대한 통지의 경우 7일 이상 회사 웹사이트 게시판에 게시함으로써 전항의 통지에 갈음할 수 있습니다. 다만, 회원 본인의 거래와 관련하여 중대한 영향을 미치는 사항에 대하여는 전항과 동일한 방법으로 별도 통지할 수 있습니다.\n",
            "1. 회사는 다음과 같은 업무를 수행합니다.\n- 재화 또는 용역에 대한 정보 제공\n- 광고 또는 이벤트 등 재화 또는 용역과 관련된 판촉 행위\n- 기타 이용자에게 유용한 정보 제공\n2. 회사는 재화의 품절 또는 기술적 사양의 변경 등의 불가피한 경우에는 장차 체결되는 계약에 의해 제공할 재화와 용역의 내용을 변경할 수 있습니다. 이 경우에는 변경된 재화 등의 내용 및 제공일자를 명시하여 현재의 재화 등의 내용을 게시한 곳에 그 제공일자 이전 7일부터 공지합니다. 단, 회사가 합리적으로 예측할 수 없는 불가피한 여건이나 사정이 있는 경우, 위 공지를 하지 않을 수 있습니다.\n3. 회사가 제공하기로 이용자와 계약을 체결한 서비스의 내용을 재화 등의 품절 또는 기술적 사양의 변경 등의 사유로 변경할 경우에는 회사는 이로 인하여 이용자가 입은 손해를 배상합니다. 단, 회사에 고의 또는 과실이 없는 경우에는 그 책임을 지지 않습니다.\n4. 회사는 무료로 제공되는 서비스의 일부 또는 전부를 회사의 정책 및 운영의 필요상 수정, 중단, 변경할 수 있으며, 이에 대하여 회원에게 별도의 보상을 하지 않습니다.\n",
            "1. 멘토의 계약 종료 및 변경 등의 사유로 서비스의 내용이 변경되거나, 서비스가 중단될 수 있습니다.\n2. 회사는 정보통신 설비의 보수점검 교체 및 고장, 통신의 두절, 천재지변 등의 불가항력적 사유가 발생한 경우에는 서비스의 전부 또는 일부를 제한하거나 일시 중단할 수 있습니다.\n3. 서비스가 일시적으로 중단되는 경우 회사는 제5조에 정한 방법으로 이용자에게 통지합니다. 다만, 미리 통지하는 것이 곤란하거나 급박하거나 불가피한 사정이 있는 경우에는 사후에 통지할 수 있습니다\n4. 회사는 서비스의 제공이 일시적으로 중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단, 회사에 고의 또는 과실이 없는 경우는 책임을 지지 않습니다.\n5. 사업종목의 전환, 사업의 포기, 업체간의 통합 등의 이유로 서비스를 제공할 수 없게 되는 경우에는 회사는 제5조에 정한 방법으로 이용자에게 통지하고, 해당 시점에 통지된 내용에 따라 이용자에게 손해가 최소화되도록 조치합니다. 다만, 회사가 통제할 수 없는 사유로 인한 서비스의 중단(운영자의 고의나 과실이 없는 디스크 장애, 시스템 다운 등)으로 인하여 사전 통지가 불가능한 경우에는 사후에 통지할 수 있습니다.\n",
            "1. 회사는 법령과 본 약관에 반하는 행위를 하지 않으며, 본 약관이 정하는 바에 따라 지속적이고 안정적으로 서비스를 제공하는 데 최선을 다합니다.\n2. 회사는 이용자가 안전하게 서비스를 이용할 수 있도록 회사의 [개인정보보호정책]을 마련, 준수하고 이용자의 개인정보보호를 위한 보안 시스템을 갖추어 이용자의 개인정보보호에 최선을 다합니다.\n3. 회사는 상품이나 용역에 대하여 표시.광고의 공정화에 관한법률 제3조 소정의 부당한 표시.광고행위를 함으로써 이용자가 손해를 입은 때에는 이를 배상할 책임을 집니다.\n\n"
        ],
        [
            "회사는 정보통신망이용촉진및정보보호에관한법률 등 관계법령이 정하는 바에 따라 회원의 개인정보를 보호를 위해 노력합니다. 개인정보의 보호 및 활용에 대해서는 관련법 및 회사의 개인정보처리방침이 적용됩니다. 다만, 회사의 공식 사이트 이외의 링크된 사이트에서는 회사의 개인정보처리방침이 적용되지 않습니다. 또한 회사는 회원의 귀책사유로 인해 노출된 정보에 대해서 책임을 지지 않습니다.\n",
            "1. 회원으로 회사 서비스의 이용을 희망하는 자는 약관의 내용에 동의함을 표시하고, 회사가 제시하는 회원가입 양식에 관련 사항을 기재하여 회원가입을 신청하여야 합니다.\n2. 허위 정보를 기재한 회원은 법적인 보호를 받을 수 없으며, 본 약관의 관련 규정에 따라 서비스 사용에 제한을 받을 수 있습니다.\n3. 회사는 다음 각 호에 해당되지 않는 한 회원 등록을 승인합니다.\n        1. 가입신청자가 본 약관 제11조 제2항에 의하여 이전에 회원자격을 상실한 적이 있는 경우 (단, 제11조 제2항에 의하여 회원자격 상실 후 30일이 경과한 자로서 회사의 회원 재가입 승낙을 얻은 경우는 예외)\n        2. 이용자의 귀책사유로 인하여 승인이 불가능한 경우\n        3. 허위로 또는 오기로 정보를 기재하거나 타인의 명의 또는 개인 정보를 도용하는 경우\n        4. 만 14세 미만인 이용자가 신청하였을 경우 (단, 법정대리인의 동의가 있는 경우에는 회원가입이 가능)\n        5. 임시 이메일 서비스(일회용 이메일 서비스, 시스템에 의한 계정 생성 포함)를 이용하여 가입하는 경우\n        6. 회사의 재정적, 기술적 문제로 서비스 제공에 문제가 있다고 판단 되는 경우\n        7. 본 약관 및 관계법령을 위반하는 경우\n        8. 회원으로 등록하는 것이 회사의 기술상 현저히 지장이 있다고 판단되는 경우\n4. 회원은 회원 가입 시 등록한 사항에 변경이 있는 경우, 직접 서비스에서 수정하거나 이메일, 고객센터를 통하여 회사에 알려야 합니다.\n5. 회원의 E-Mail 등의 정보가 변경되었을 경우에는 정보변경 메뉴를 통하여 정보 수정 등의 방법으로 변경사항을 알려야 하며 변경사항의 미통보로 인해 발생하는 손해는 회원 본인에게 있습니다.\n",
            "1. 회원은 회사에 언제든지 서비스 이용을 중단하고 탈퇴를 요청할 수 있으며 회사는 즉시 회원 탈퇴를 처리합니다.\n2. 회원 탈퇴 시 기존에 구매했거나 다운로드 했던 콘텐츠는 이용이 불가합니다.\n3. 회사는 회원이 다음 각 호에 해당하는 경우 별도의 통보 절차 없이 서비스 이용을 제한하거나 회원 자격을 상실시킬 수 있습니다.\n- 뚝딱의 콘텐츠를 무단으로 복제, 배포, 판매할 경우\n- 회원 가입 신청서에 기재 사항을 허위로 작성한 허위로 또는 오기로 정보를 기재하거나 타인의 명의 또는 개인 정보를 도용한 것이 확인된 경우\n- 임시 이메일 서비스(일회용 이메일 서비스, 시스템에 의한 계정 생성 포함)를 이용하는 등 부정한 방법으로 가입한 것이 확인된 경우\n- 회사를 이용하여 구입한 재화.용역 등의 대금, 기타 회사 이용에 관련하여 회원이 부담하는 채무를 기일 내에 지급하지 않는 경우\n- 상업적 또는 홍보/광고, 악의적인 목적으로 활동한 것이 확인된 경우\n- 이벤트의 참여를 위해 여러 개의 계정을 생성하여 가입한 것이 확인된 경우\n- 다른 사람의 서비스 이용을 방해하거나 그 정보를 도용하는 등 전자거래질서를 위협하는 경우\n- 회사를 이용하여 법령과 이 약관이 금지하거나 미풍양속에 반하는 행위를 하는 경우\n4. 회사가 회원 자격을 제한 또는 정지한 후 동일한 행위를 2회 이상 반복하거나 30일 이내에 그 사유를 시정하지 아니하는 경우, 회사는 회원 자격을 상실시킬 수 있습니다.\n5. 회사가 회원 자격을 상실시키는 경우에는 회원 등록을 말소합니다. 이 경우 회원에게 이를 통지하고, 회원등록 말소 전에 소명할 기회를 부여합니다.\n",
            "1. 회원 본인의 과실로 타인이 사용하게 되어 일어날 수 있는 금전적 손실 등 각종 손해에 대한 관리 책임은 회원 본인에게 있습니다.\n2. 이메일, 비밀번호는 본인이 직접 사용하여야 하며 제 3자에게 이용하게 해서는 안됩니다.\n3. 회원의 닉네임,  E-Mail 등의 정보가 변경되었을 경우에는 정보변경 메뉴를 통하여 정보 수정 등의 방법으로 변경사항을 알려야 하며 변경사항의 미 통보로 인해 발생하는 손해는 회원 본인에게 있습니다.\n4. 회원이 자신의 비밀번호를 도난 당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 회사에 통보하고 회사의 안내를 따라야 합니다.\n5. 회원은 다음 행위를 하여서는 안되며, 적발 시 회원탈퇴 등의 조치를 받을 수 있습니다. 또한 경우에 따라 경고, 일시정지, 영구이용정지 등으로 서비스 이용을 단계적으로 제한하는 조치를 받을 수 있고, 관련 법규에 의거하여 법적 조치가 이루어질 수 있습니다.\n- 뚝딱의 콘텐츠를 무단으로 복제, 배포, 판매할 경우\n- 회원 등록 또는 회원정보 변경 시 허위 또는 타인의 정보를 무단으로 기재\n- 회사 또는 제3자가 게시된 정보를 임의로 변경\n- 회사가 금지한 정보(컴퓨터 프로그램 등)의 사용, 송신 또는 게시\n- 불특정 다수를 대상으로 회사의 서비스를 이용하여 영리활동을 하는 행위\n- 회사와 제3자의 저작권을 침해하고 명예를 손상시키거나 업무를 방해하는 행위\n- 외설, 폭력적 표현, 기타 미풍양속에 반하는 정보를 뚝딱에 공개 또는 게시하는 행위\n- 회사의 기술적 보호조치를 회피 혹은 무력화하는 행위\n- 사실관계를 왜곡하는 정보제공 행위 등 기타 회사가 부적절하다고 판단하는 행위\n- 타인의 정보 도용\n- 고객센터 문의 및 전화 상담 내용이 욕설, 폭언, 성희롱, 반복민원을 통한 업무방해 등에 해당하는 행위\n\n",
        ],
        [
            "1. 회사는 다음 각호에 해당하는 사항을 해당 재화, 콘텐츠 또는 관련 게시물에 표시합니다.\n- 재화, 콘텐츠의 명칭, 종류, 내용, 이용기간\n- 서비스 이용계약의 해지방법 및 효과\n- 이용약관 및 개인정보처리방침\n2. 회사는 전항 각 호의 사항을 회사 웹사이트, 본 이용약관, 개인정보보호정책 등에서 이미 고지하고 있는 경우 별도로 표시하지 않을 수 있습니다.\n",
            "1. 회원은 회사가 제공하는 다음 각호 또는 이와 유사한 절차에 의하여 재화, 콘텐츠 열람 신청을 합니다.\n- 재화, 콘텐츠의 검색, 목록 열람 대상 선택\n- 재화, 콘텐츠 상세정보 확인\n- 열람\n2. 1인당 1회 한정으로 제공되는 혜택의 경우, 서로 다른 ID에서 혜택 수령을 시도하더라도 개인식별정보를 이용하여 동일인으로 간주하고 혜택 제공을 차단할 수 있습니다.\n",
            "1. 회사는 다음 각호에 해당하는 경우를 부정 이용행위로 봅니다.\n- 동일한 ID로 5대를 초과하여 기기(스마트폰, 태블릿PC 등)에서 동시 접속해서 서비스를 이용하는 경우\n- 자신의 ID 및 포트폴리오 등을 타인에게 판매, 대여, 양도하는 행위 및 이를 광고하는 경우\n- 서비스 이용 중, 복제프로그램을 실행하거나 화면을 캡쳐, 또는 녹화를 하는 경우\n- 콘텐츠의 DRM(Digital Rights Management)을 무력화하는 경우\n- 결재를 통한 회사와 회원 간의 정당한 계약이 성립되지 아니한 상태에서 콘텐츠를 불법으로 사용하려는 경우\n- 타인의 개인정보, 금융정보를 불법으로 취득하거나 본인의 동의 없이 이용하여 디지털콘텐츠, 상품을 구매한 경우\n- 뚝딱에서 진행되는 이벤트의 참여 조건에 반하여 참여한 경우\n- 회사가 제공하는 이벤트를 통해 부정한 방법으로 참여하여 이용할 경우\n- 기타 다음과 같은 행위 등을 반복하여 회사의 건전한 운영을 해하거나 회사의 서비스 운영을 고의로 방해하는 경우\n- 회사의 운영에 관련하여 허위 사실을 적시하거나 유포하여 회사의 명예를 실추시키거나 회사의 신뢰성을 해하는 경우\n- 회사의 운영 과정에서 폭언, 음란한 언행, 협박, 인과 관계가 입증되지 않는 피해에 대한 보상 (적립금, 현금, 상품 등) 및 요구 등으로 업무 환경을 심각히 해하는 경우\n- 회사를 통해 구입한 재화 또는 서비스에 특별한 하자가 없음에도 불구하고, 일부 사용 후 일부 또는 전부의 반품을 지속적으로 요구하는 경우\n- 임시 이메일 서비스(일회용 이메일 서비스, 시스템에 의한 계정 생성 포함)를 통하여 가입하여 뚝딱 서비스를 이용하는 경우\n- 회사명 또는 뚝딱 임직원이나 운영진을 사칭하여 타인을 속이거나 이득을 취하는 등 피해와 혼란을 주는 경우\n\n2. 회사는 전항에 따른 부정 이용자가 발견 되었을 경우, 다음 각호에 따른 조치를 취할 수 있습니다.\n    1. [1차 발견 시] 회사는 전자우편, 팝업 등 제5조의 방법을 통하여 해당 위반 사실을 사전 경고합니다. 경고와 동시에 이용제한 ID로 등록되어 서비스 이용을 정지시킴과 동시에 부정이용을 통해 취득한 콘텐츠 이용을 중지할 수 있습니다. 실물 상품의 경우 회수 조치 또는 배상을 요구할 수 있습니다.\n    2. [2차 발견 시] 회사는 위반 내용을 제5조의 방법을 통하여 고지하고, 필요시 법적인 대응을 할 수 있습니다. 회사는 회원에게 30일 간의 소명기간을 부여하고, 회원이 소명기간 내 정당한 사유를 제시하지 못할 경우 회원 등록을 말소시키고 구입한 콘텐츠, 상품의 사용권한을 강제 종료할 수 있습니다.\n    3. 이벤트 참여 조건에 반하여 참여한 경우에는 사전 고지 없이 당첨 및 혜택 제공이 제한될 수 있습니다.\n    4. 위 각 호에 해당되는 조치에 대해서는 별도로 보상하지 않습니다.\n\n3. 회원은 회사로부터의 본 조 제1,2항의 조치에 이의가 있는 경우, 회사 고객지원팀에 해당 사실에 대하여 소명할 수 있으며 그에 따라 이용에 관한 별도의 조치를 받을 수 있습니다.\n\n"
        ],
        [
            "1. 회사가 작성한 모든 콘텐츠에 대한 저작권은 회사에 있습니다.\n2. 회원은 회사를 통하여 입수한 정보를 회사의 사전 동의 없이 복제, 판매, 출판, 편집, 전시, 전송, 배포, 판매, 방송, 공연하는 등의 행위로 회사의 저작권을 침해 하여서는 안됩니다.\n3. 회원이 창작하여 뚝딱에 게재 또는 등록한 게시물에 대한 저작권은 회원에게 있으며 해당 게시물이 타인의 지적 재산권을 침해하여 발생하는 모든 책임은 회원 본인에 귀속됩니다. 회원의 게시물에 대해 제3자로부터 저작권 및 기타 권리의 침해로 이의가 제기된 경우, 회사는 해당 게시물을 임의로 삭제할 수 있습니다.\n4. 회원은 자신이 게재 또는 등록한 게시물을 회사가 뚝딱의 서비스를 운영 또는 홍보를 위해 사용할 경우 사용료 없는 사용권을 회사에 부여합니다. 사용권은 회사가 뚝딱의 서비스를 운영하는 동안에만 유효하며, 회원 탈퇴 후에도 유효합니다\n5. 회사가 상기 사용권 외에 회원의 게시물을 상업적으로 이용하고자 할 경우 회원의 사전 동의를 얻어야 하며, 이 경우 회사는 별도의 보상제도를 운영할 수 있습니다.\n",
            "1. 회사와 회원이 이 규약을 위반함으로써 발생하는 모든 책임은 위반한 자가 부담하며, 이로 인해 상대방에게 손해를 입힌 경우에는 손해를 입힌 자가 배상하여야 합니다.\n2. 회원의 이름, E-Mail 등의 정보가 변경되었을 경우에는 사전에 통지하거나 변경해야 하며 변경하지 않아서 발생하는 사고에 대한 책임은 회원 본인에게 있습니다.\n3. 회사는 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 관한 책임이 면제됩니다.\n4. 회사는 이용자의 귀책사유로 인하여 서비스를 제공할 수 없는 경우에는 그에 대한 책임을 지지 않습니다.\n5. 회사는 이용자 상호간 또는 이용자와 제3자 간에 콘텐츠를 매개로 하여 발생한 분쟁 등에 대하여 책임을 지지 않습니다.\n",
            "1. 회사는 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해를 보상처리하기 위하여 고객서비스팀을 설치 운영합니다.\n2. 회사는 이용자가 제출하는 불만사항 및 의견이 있을 경우 우선적으로 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 즉시 통보해야 합니다.\n3. 회사와 이용자 간에 발생한 분쟁은 전자거래기본법 제28조 및 동 시행령 제15조에 의하여 설치된 전자거래분쟁조정위원회의 조정에 따를 수 있습니다.\n",
            "본 약관에 명시하지 않은 사항은 전자거래 기본법, 전자서명법, 방문판매법 및 기타 관련 법령(이하 ‘관계법규’)과 회사의 규정 및 상관례에 따릅니다.\n\n"
        ],
        [
            "1. 이 약관은 회사와 회원 간에 성립되는 서비스이용계약의 기본 약정입니다. 회사는 필요한 경우 특정 서비스에 관하여 적용될 사항을 정하여 미리 공지할 수 있습니다. 회원이 이러한 개별약관에 동의하고 특정 서비스를 이용하는 경우에는 개별약관이 우선적으로 적용되고, 이 약관은 보충적인 효력을 갖습니다.\n2. 회사는 필요한 경우 서비스 이용과 관련된 세부적인 개별내용(이용정책 등)을 정하여 사이트 등을 통하여 공지할 수 있습니다.\n- 이용약관 시행일자 : 2021년 10월 27일"
        ]
    ]
    
    func getAttributedText(index: Int) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 14/6

        let attributedText = NSMutableAttributedString(string: titleDataList[index], attributes: [NSAttributedString.Key.font: UIFont.TTFont(type: .SDBold, size: 14)])

        for i in Range(0...contentDataList[index].count - 1) {
            attributedText.append(NSAttributedString(string: contentDataList[index][i], attributes: [NSAttributedString.Key.foregroundColor: UIColor.GrayScale.sub1, NSAttributedString.Key.font: UIFont.TTFont(type: .SDBold, size: 14)]))
            attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, contentDataList[index][i].count))
            attributedText.append(NSAttributedString(string: articleDataList[index][i], attributes: [NSAttributedString.Key.foregroundColor: UIColor.GrayScale.sub1, NSAttributedString.Key.font: UIFont.TTFont(type: .SDReg, size: 14)]))
            attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, articleDataList[index][i].count))
        }

        return attributedText
    }
}