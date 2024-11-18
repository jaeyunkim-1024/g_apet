package biz.app.pet.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.pet.model.PetBasePO;
import biz.app.pet.model.PetBaseVO;
import framework.common.dao.MainAbstractDao;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class PetBatchDao extends MainAbstractDao {
	
    private static final String BASE_DAO_PACKAGE = "petBatch.";

	public List<PetBaseVO> listPetForAgeBatch() {
		return selectList(BASE_DAO_PACKAGE + "listPetForAgeBatch");
	}
    
    public int updatePetAge(PetBasePO po) {
    	return update(BASE_DAO_PACKAGE + "updatePetAge", po);
    }
}
