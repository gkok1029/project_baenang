package com.bn.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;





@Data
@NoArgsConstructor
@AllArgsConstructor
public class PlanVo {
	
	int p_id;//�÷����̵�
	int m_id;//ȸ�����̵�
	String p_name;//�÷��̸�
	Date p_birth;//�÷�������
	Date p_moddate;//�÷�������
	
	
}
