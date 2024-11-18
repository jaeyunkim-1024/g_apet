package biz.app.system.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.system.dao.LocalPostDao;
import biz.app.system.model.LocalPostSO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.system.service
 * - 파일명		: LocalPostServiceImpl.java
 * - 작성일		: 2017. 6. 1.
 * - 작성자		: Administrator
 * - 설명		: 도서산간지역 우편번호 서비스
 * </pre>
 */
@Service("localPostService")
@Transactional
public class LocalPostServiceImpl implements LocalPostService {

	@Autowired
	private LocalPostDao localPostDao;

	
	/**
	 * <pre>
	 * - 작성일		: 2017. 6. 1.
	 * - 작성자		: Administrator
	 * - 설명		: 도서/산간지역 여부
	 * </pre>
	 * 
	 * @param postNoNew
	 * @param postNoOld
	 * @return
	 */
	@Override
	public String getLocalPostYn(String postNoNew, String postNoOld) {
		LocalPostSO lpso = new LocalPostSO();
		lpso.setPostNoNew(postNoNew);
		lpso.setPostNoOld(postNoOld);
		return this.localPostDao.getLocalPostYn(lpso);
	}

}