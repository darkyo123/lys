package egovframework.whms.sm.attentionItem.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.whms.sm.attentionItem.service.AttentionItemVO;

@Repository("attentionItemDAO")
public class AttentionItemDAO extends EgovComAbstractDAO {

	public AttentionItemVO selectAttentionItem(AttentionItemVO attentionItemVO) throws Exception {
		return (AttentionItemVO) selectOne("attentionItemDAO.selectAttentionItem", attentionItemVO);
	}

}
