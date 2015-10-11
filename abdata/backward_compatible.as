#ifndef        IG_ABDATA_BACKWARD_COMPATIBLE_AS
#define global IG_ABDATA_BACKWARD_COMPATIBLE_AS

/*
このファイルを include することで、古い abdata のコマンドが使用できる。
ただし以下のコマンドは挙動が変更されたため、このファイルでは対処されない。

`*_swap`: 現在はコンテナの中身を交換するコマンド。古いものは `*_iter_swap` に改名された。
`*_count`: 現在はある値を持つ要素の個数を数えるコマンド。古いものは `*_size` を使う。
//*/

#enum global SortMode_Ascending = 0
#enum global SortMode_Decending = 1

#define global list_clone list_dup
#define global unor_clone unor_dup
#define global pair_clone pair_dup
#define global pair_clone_lhs pair_dup_lhs
#define global pair_clone_rhs pair_dup_rhs

#define global pair_loc_swap        pair_iter_swap
#define global list_loc_move        list_iter_move
#define global list_loc_swap        list_iter_swap
#define global list_loc_swap_front(%1)  list_iter_swap %1,  0,  1
#define global list_loc_swap_back(%1)   list_iter_swap %1, -2, -1

#define global list_lower_bound list_lb
#define global list_upper_bound list_ub

#define global list_push  list_push_back
#define global list_pushv list_pushv_back

#define global list_rotate(%1, %2 = 0, %3 = stdarray_index_of_end) \
	listImpl_rotate abdataInsts(%1), %2, %3

#define global list_rotate_back(%1, %2 = 0, %3 = stdarray_index_of_end) \
	listImpl_rotate_back abdataInsts(%1), %2, %3

#define global list_lexicographical_compare list_compare
#define global pair_lexicographical_compare pair_compare
#define global unor_lexicographical_compare unor_compare

#module
#deffunc list_double int self, int i,  local tmp
	list_getv    self, tmp, i
	list_insertv self, tmp, i
	return
#global
#define global list_double_front(%1)   list_double (%1), 0
#define global list_double_back(%1)    list_double (%1), -1

#define global stack_make          deque_make
#define global stack_new           deque_new
#define global stack_delete        deque_delete
#define global stack_peekv         stack_getv
#define global stack_peek          stack_get
#define global stack_get_back      deque_get_back
#define global stack_getv_back     deque_getv_back
#define global stack_pop_back      deque_pop_back
#define global stack_popv_back     deque_popv_back
#define global stack_pop           deque_pop_back
#define global stack_popv          deque_popv_back
#define global stack_vartype       list_vartype_back
#define global stack_double_front  deque_double_front
#define global stack_double_back   deque_double_back
#define global stack_push_back     deque_push_back
#define global stack_pushv_back    deque_pushv_back
#define global stack_add           stack_push
#define global stack_push          deque_push_back
#define global stack_pushv         deque_pushv_back
#define global stack_erase         deque_erase_back
#define global stack_loc_swap_back deque_loc_swap_back
#define global stack_loc_swap      stack_loc_swap_back
#define global stack_clear         deque_clear
#define global stack_chain         deque_chain
#define global stack_copy          deque_copy
#define global stack_swap          deque_swap
#define global stack_iter_init     deque_iter_init
#define global stack_iter_next     deque_iter_next
#define global stack_size          deque_size
#define global stack_length        stack_size
#define global stack_empty         deque_empty
#define global stack_count         deque_count
#define global stack_is_valid      deque_is_valid
#define global stack_dbglog        deque_dbglog
#define global stack_getv(%1,%2=0)      deque_getv %1, (-(%2) - 1)
#define global ctype stack_get(%1,%2=0) deque_get(%1, (-(%2) - 1))
#define global stack_clone(%1,%2=0)     deque_clone %1, (-(%2) - 1)
#define global ctype stack_ref(%1,%2=0) deque_ref(%1, (-(%2) - 1))

#define global dequeNull            abdataNull
#define global deque_make           list_make
#define global deque_new            list_new
#define global deque_delete         list_delete
#define global deque_getv           list_getv
#define global deque_popv           list_popv
#define global deque_get            list_get
#define global deque_pop            list_pop
#define global deque_clone          list_clone
#define global deque_ref            list_ref
#define global deque_get_front      list_get_front
#define global deque_get_back       list_get_back
#define global deque_getv_front     list_getv_front
#define global deque_getv_back      list_getv_back
#define global deque_pop_front      list_pop_front
#define global deque_pop_back       list_pop_back
#define global deque_popv_front     list_popv_front
#define global deque_popv_back      list_popv_back
#define global deque_vartype        list_vartype
#define global deque_vartype_front  list_vartype_front
#define global deque_vartype_back   list_vartype_back
#define global deque_set            list_set
#define global deque_setv           list_setv
#define global deque_insert         list_insert
#define global deque_insertv        list_insertv
#define global deque_double_front   list_double_front
#define global deque_double_back    list_double_back
#define global deque_push_front     list_push_front
#define global deque_push_back      list_push_back
#define global deque_pushv_front    list_pushv_front
#define global deque_pushv_back     list_pushv_back
#define global deque_push           list_push
#define global deque_pushv          list_pushv
#define global deque_add            list_add
#define global deque_erase          list_erase
#define global deque_erase_front    list_erase_front
#define global deque_erase_back     list_erase_back
#define global deque_loc_swap_front list_loc_swap_front
#define global deque_loc_swap_back  list_loc_swap_back
#define global deque_rotate         list_rotate
#define global deque_rotate_back    list_rotate_back
#define global deque_reverse        list_reverse
#define global deque_clear          list_clear
#define global deque_chain          list_chain
#define global deque_copy           list_copy
#define global deque_swap           list_swap
#define global deque_iter_init      list_iter_init
#define global deque_iter_next      list_iter_next
#define global deque_size           list_size
#define global deque_length         deque_size
#define global deque_empty          list_empty
#define global deque_count          list_count
#define global deque_is_valid       list_is_valid
#define global deque_dbglog         list_dbglog

#define global queueNull           dequeNull
#define global queue_make          deque_make
#define global queue_new           deque_new
#define global queue_delete        deque_delete
#define global queue_getv          deque_getv
#define global queue_peekv         queue_getv
#define global queue_get           deque_get
#define global queue_peek          queue_get
#define global queue_clone         deque_clone
#define global queue_ref           deque_ref
#define global queue_get_front     deque_get_front
#define global queue_getv_front    deque_getv_front
#define global queue_pop_front     deque_pop_front
#define global queue_popv_front    deque_popv_front
#define global queue_popv          deque_popv_front
#define global queue_pop           deque_pop_front
#define global queue_vartype       list_vartype_front
#define global queue_vartype_front list_vartype_front
#define global queue_set           deque_set
#define global queue_setv          deque_setv
#define global queue_insert        deque_insert
#define global queue_insertv       deque_insertv
#define global queue_double_front  deque_double_front
#define global queue_double_back   deque_double_back
#define global queue_push_back     deque_push_back
#define global queue_pushv_back    deque_pushv_back
#define global queue_add           queue_push
#define global queue_push          deque_push_back
#define global queue_pushv         deque_pushv_back
#define global queue_erase         deque_erase_front
#define global queue_clear         deque_clear
#define global queue_chain         deque_chain
#define global queue_copy          deque_copy
#define global queue_swap          deque_swap
#define global queue_iter_init     deque_iter_init
#define global queue_iter_next     deque_iter_next
#define global queue_size          deque_size
#define global queue_length        queue_size
#define global queue_empty         deque_empty
#define global queue_count         deque_count
#define global queue_is_valid      deque_is_valid
#define global queue_dbglog        deque_dbglog

#define global ArrayInsert stdarray_insert_room
#define global ArrayRemove stdarray_erase
#define global ArrayMove stdarray_loc_move
#define global ArraySwap stdarray_swap
#define global ArrayRotate stdarray_rotate
#define global ArrayRotateBack stdarray_rotate_back
#define global ArrayReverse stdarray_reverse

#define global list_exchange list_swap
#define global deque_exchange deque_swap
#define global stack_exchange stack_swap
#define global queue_exchange queue_swap
#define global tnode_exchange tnode_swap
#define global unor_exchange unor_swap
#define global pair_exchange pair_swap

#define global list_setSize list_resize
#define global deque_setSize deque_resize
#define global stack_setSize stack_resize
#define global queue_setSize queue_resize

#define global list_iterInit list_iter_init
#define global deque_iterInit deque_iter_init
#define global stack_iterInit stack_iter_init
#define global queue_iterInit queue_iter_init
#define global tnode_iterInit tnode_iter_init
#define global unor_iterInit unor_iter_init
#define global pair_iterInit pair_iter_init

#define global list_iterNext list_iter_next
#define global deque_iterNext deque_iter_next
#define global stack_iterNext stack_iter_next
#define global queue_iterNext queue_iter_next
#define global tnode_iterNext tnode_iter_next
#define global unor_iterNext unor_iter_next
#define global pair_iterNext pair_iter_next

#define global list_move list_loc_move
#define global deque_move deque_loc_move
#define global stack_move stack_loc_move
#define global queue_move queue_loc_move

#define global list_remove list_erase
#define global list_remove_front list_erase_front
#define global list_remove_back list_erase_back
#define global deque_remove deque_erase
#define global deque_remove_front deque_erase_front
#define global deque_remove_back deque_erase_back
#define global stack_remove stack_erase
#define global stack_remove_front stack_erase_front
#define global stack_remove_back stack_erase_back
#define global queue_remove queue_erase
#define global queue_remove_front queue_erase_front
#define global queue_remove_back queue_erase_back

#define global list_isValid list_is_valid
#define global deque_isValid deque_is_valid
#define global queue_isValid queue_is_valid

#define global unor_count unor_size
#define global unor_exists unor_count_key

#define global pair_getLhs pair_get_lhs
#define global pair_getRhs pair_get_rhs
#define global pair_getBoth pair_get_both
#define global pair_getvLhs pair_getv_lhs
#define global pair_getvRhs pair_getv_rhs
#define global pair_getvBoth pair_getv_both
#define global pair_setLhs pair_set_lhs
#define global pair_setRhs pair_set_rhs
#define global pair_setBoth pair_set_both
#define global pair_setvLhs pair_setv_lhs
#define global pair_setvRhs pair_setv_rhs
#define global pair_setvBoth pair_setv_both
#define global pair_cloneLhs pair_clone_lhs
#define global pair_cloneRhs pair_clone_rhs
#define global pair_cloneBoth pair_clone_both
#define global pair_vartypeLhs pair_vartype_lhs
#define global pair_vartypeRhs pair_vartype_rhs
#define global pair_vartypeBoth pair_vartype_both

#define global new_list list_make
#define global new_deque deque_make
#define global new_stack stack_make
#define global new_queue queue_make
#define global new_tnode tnode_make
#define global new_unor unor_make
#define global new_pair pair_make

#endif
