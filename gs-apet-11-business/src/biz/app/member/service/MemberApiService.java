package biz.app.member.service;

import biz.app.member.model.MemberBasePO;
import biz.app.pet.model.PetBaseSO;
import framework.common.model.NaverApiVO;

import java.util.List;
import java.util.Map;

public interface MemberApiService {

    /**
     * 네이버 연동 시 사용할 토큰 정보를 회원번호로 저장 (1시간 유효)
     * @param key 회원번호
     * @param value  토큰
     */
    public void createTokenCookie(String key, String value);

    /**
     * 네이버 연동 시 전달 할 토큰 정보를 받음
     * @param key 회원번호
     * @return
     */
    public String getTokenCookie(String key);

    /**
     * accessToken 및 네이버 사용자 정보를 받음
     * @param code
     * @return
     */
    public Map<String, String> getNaverUserProfile(String code);

    /**
     * 제휴사 연동스토어 번호 동일여부 체크
     * @param interlockSellerNo
     * @return
     */
    public Boolean sellerNoEquals(String interlockSellerNo);

    /**
     * 회원 연동 여부 체크 : 0 이상이면 연동 상태
     * @param vo
     * @return
     */
    public boolean checkInterlock(NaverApiVO vo);

    /**
     * LIF-0003 : 매핑삭제 요청
     * @param vo
     * @return
     */
    public boolean deleteInterlock(NaverApiVO vo);

    /**
     * 신규 회원 가입
     * @param userMap
     * @param provisionIds
     * @param optionIds
     * @return
     */
    public MemberBasePO insertInterlockMember(Map<String, String> userMap, String[] provisionIds, String[] optionIds);

    /**
     * [=== NIF-0001 ===] : AboutPet ==> Naver
     * N-네이버회원정보 조회 API
     * @param token
     * @return
     */
    public NaverApiVO getNif0001(String token);

    /**
     * [=== NIF-0002 ===] : AboutPet ==> Naver
     * N-제휴회원연동 매핑요청 API
     *
     * @param vo @return
     */
    public NaverApiVO getNif0002(NaverApiVO vo);

    /**
     * [=== NIF-0003 ===] : AboutPet ==> Naver
     * N-제휴회원연동 매핑조회 API
     * @return
     */
    public NaverApiVO getNif0003(NaverApiVO vo);

    /**
     * [=== NIF-0004 ===] : AboutPet ==> Naver
     * N-제휴회원연동 매핑삭제 API
     *   ( AboutPet ==> Naver )
     */
    public NaverApiVO getNif0004(NaverApiVO vo);

    /**
     * [=== NIF-0005 ===] : AboutPet ==> Naver
     * N-제휴회원연동완료 callback 웹페이지 API
     *   ( AboutPet ==> Naver )
     * @return
     */
    public NaverApiVO getNif0005(NaverApiVO vo);

    /**
     * 네이버 펫윈도 펫정보 요청
     * @param vo
     */
    public void getPartnerPetInfo(NaverApiVO vo) throws Exception;

    /**
     * TWC 웹쳇 제공 펫정보
     * @param so
     * @return
     */
    public List<Map<String, Object>> listPetBaseByPartner(PetBaseSO so);

    public List<Map<String, Object>> listPetBaseByPartner(NaverApiVO vo);



}
