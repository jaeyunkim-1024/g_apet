package biz.app.pet.service;

import java.util.List;

import biz.app.pet.model.PetBasePO;
import biz.app.pet.model.PetBaseVO;

public interface PetBatchService {

	public List<PetBasePO> listPetForAgeBatch();
	
	public int updatePetAge(PetBasePO po);
}
