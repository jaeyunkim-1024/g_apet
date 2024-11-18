package biz.bamboo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.bamboo.dao.BambooDao;


@Service("bambooService")
@Transactional
public class BambooServiceImpl implements BambooService{
	@Autowired
	private BambooDao bambooDao;
	

	public String getSelectBamboo() {
		
		return bambooDao.getSelectBamboo();
	}
}
