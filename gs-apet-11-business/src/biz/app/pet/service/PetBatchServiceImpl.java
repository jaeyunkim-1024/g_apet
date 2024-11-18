package biz.app.pet.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.pet.dao.PetBatchDao;
import biz.app.pet.model.PetBasePO;
import biz.app.pet.model.PetBaseVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class PetBatchServiceImpl implements PetBatchService {
	
	@Autowired private PetBatchDao petBatchDao;

	@Override
	public List<PetBasePO> listPetForAgeBatch() {
		List<PetBasePO> poList = new ArrayList<PetBasePO>();
		List<PetBaseVO> voList = petBatchDao.listPetForAgeBatch();
		
		for(PetBaseVO vo : voList) {

			PetBasePO po = new PetBasePO();

			if(vo.getAge() != null && !"".equals(vo.getAge()) && vo.getMonth() != null && !"".equals(vo.getMonth())){

				int age, month = 0;

				try{
					if(numberPatternCheck(vo.getAge())){
						age = Integer.parseInt(vo.getAge().trim());
					}else{
						throw new NumberFormatException("[error] petNo("+vo.getPetNo() + ") : age에 문자가 포함되어 있습니다.");
					}

					if(numberPatternCheck(vo.getMonth())){
						month = Integer.parseInt(vo.getMonth().trim());
					}else{
						throw new NumberFormatException("[error] petNo("+vo.getPetNo() + ") : month에 문자가 포함되어 있습니다.");
					}
					
					if(month < 12){
						if((month+1) == 12 ){
							po.setAge(String.valueOf((age+1)));
							po.setMonth("0");
						}else{
							po.setAge(String.valueOf(age));
							po.setMonth(String.valueOf((month+1)));
						}
					}else{
						po.setAge(String.valueOf((age+1)));
						po.setMonth("0");
					}
					
					po.setPetNo(vo.getPetNo());
					poList.add(po);
					
				}catch(NumberFormatException e){
					log.error(e.getMessage());
				}
			}
		}
		return poList;
	}
	
	@Override
	public int updatePetAge(PetBasePO po) {
		return petBatchDao.updatePetAge(po);
	}

	private Boolean numberPatternCheck(String str){
		return (str.trim()).matches("a*[0-9]*");
	}
}
