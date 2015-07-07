// abdata elem

#ifndef IG_ABSTRACT_DATA_STRUCTURE_ABELEM_AS
#define IG_ABSTRACT_DATA_STRUCTURE_ABELEM_AS

#include "mod_pvalptr.as"

#module abdata_abelem mValue

//##########################################################
//        �\�z�E���
//##########################################################
#define global abelem_new(%1,%2 = stt_zero@) newmod %1, abdata_abelem@, %2
#define global abelem_delete(%1)             delmod %1

//------------------------------------------------
// �\�z
//------------------------------------------------
#modinit var vSrc
	abelem_setv thismod, vSrc
	return getaptr(thismod)
	
//------------------------------------------------
// ���
//------------------------------------------------

//##########################################################
//        �擾�n
//##########################################################
//------------------------------------------------
// �l�̎擾 ( ���ߌ`�� )
//------------------------------------------------
#modfunc abelem_getv var dst
	dst = mValue
	return
	
//------------------------------------------------
// �Q�Ɖ� ( ���ߌ`�� )
//------------------------------------------------
#modfunc abelem_clone var dst
	dup dst, mValue
	return
	
//##########################################################
//        ����n
//##########################################################
//------------------------------------------------
// �l�̐ݒ� ( �ϐ� )
//------------------------------------------------
#modfunc abelem_setv var src
	mValue = src
	return
	
//------------------------------------------------
// �ϒ��v�f�̊g��
//------------------------------------------------
#modfunc abelem_memexpand int size
	memexpand mValue, size
	return
	
//##########################################################
//        �G���n
//##########################################################
//------------------------------------------------
// �v�f�̌^���擾����
//------------------------------------------------
#modcfunc abelem_vartype
	return vartype(mValue)
	
//------------------------------------------------
// �v�f�̌^��ϊ�����
// 
// @+ ���̌^�� vt �������Ȃ�ϊ����Ȃ��B
//------------------------------------------------
#modfunc abelem_changeVartype int vt
	if ( vartype(mValue) != vt ) {
		dimtype mValue, vt
	}
	return
	
#global

#endif