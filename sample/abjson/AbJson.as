#ifndef        IG_ABDATA_JSON_HEADER_AS
#define global IG_ABDATA_JSON_HEADER_AS

// json on abdata

//------------------------------------------------
// 定数：値の種類
//------------------------------------------------
#enum global AbJsonValueType_Null = 0
#enum global AbJsonValueType_Object
#enum global AbJsonValueType_Pair
#enum global AbJsonValueType_Array
#enum global AbJsonValueType_String
#enum global AbJsonValueType_Number
#enum global AbJsonValueType_Bool
#enum global AbJsonValueType_MAX

//------------------------------------------------
// 定数：ノードの種類と名前
//------------------------------------------------
#enum global AbJsonNodeType_Root = 0
#enum global AbJsonNodeType_Object
#enum global AbJsonNodeType_Pair
#enum global AbJsonNodeType_Array
#enum global AbJsonNodeType_Value
#enum global AbJsonNodeType_String
#enum global AbJsonNodeType_Number
#enum global AbJsonNodeType_Bool
#enum global AbJsonNodeType_Null
#enum global AbJsonNodeType_MAX

#define global AbJsonNodeName_Root   "json-root"
#define global AbJsonNodeName_Object "object"
#define global AbJsonNodeName_Pair   "pair"
#define global AbJsonNodeName_Array  "array"
#define global AbJsonNodeName_Value  "value"
#define global AbJsonNodeName_String "string"
#define global AbJsonNodeName_Number "number"
#define global AbJsonNodeName_Bool   "bool"
#define global AbJsonNodeName_Null   "null"
#define global AbJsonNodeName_MAX

//------------------------------------------------
// 定数：組み込みの定数識別子
//------------------------------------------------
#define global AbJsonInternalConst_True  "true"
#define global AbJsonInternalConst_False "false"
#define global AbJsonInternalConst_Null  "null"

#endif
